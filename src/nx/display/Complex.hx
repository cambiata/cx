package nx.display;
import cx.ArrayTools;
import cx.NmeTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.display.type.TSigns;
import nx.display.util.GeomUtils;
import nx.display.util.SignsUtil;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteType;

/**
 * ...
 * @author Jonas Nyström
 */

/*
interface IDisplayRects {
	public var rects(get_rects, null): Array<Rectangle>;
*/
 
class Complex /*implements IDisplayRects*/
{
	/**************************************************************************
	 * Private vars
	 * 
	 **************************************************************************/	

	
	
	private var _dnotesXshift:Array<Float>;
	
	public function new(dnotes:Iterable<DNote>, dpart:DPart=null)  {
		this.dnotes 			= Lambda.array(dnotes);
		this.dpart 				= dpart;
		this._dnotesXshift 	= [];
		this.signs 				= [];
		
		for (dnote in this.dnotes) {
			this._dnotesXshift.push(0);
		}

		this.signs = this._calculateSigns();		
		this._avoidCollisions();
	}
	
	/**************************************************************************
	 * Public vars 
	 * 
	 **************************************************************************/	
	
	public var signs(default, null):TSigns;
	public var dnotes(default, null):Array<DNote>;		
	public var dpart(default, null):DPart;
	
	public function dnote(idx:Int) : DNote {
		return this.dnotes[idx];
	}
	
	public function dnoteXshift(idx:Int): Float {
		return this._dnotesXshift[idx];
	}
	
	/**************************************************************************
	 * Private functions
	 * 
	 **************************************************************************/	

	private function _calculateSigns():TSigns {
		var sgs:TSigns = [];
		for (dnote in this.dnotes) {
			switch (dnote.notetype) {
				case ENoteType.Normal:
					for (dhead in dnote.dheads) {
						sgs.push({sign:dhead.head.sign, level:dhead.head.level, position:0});
					}
				default: {} // nothing!
			}
		}	
		return SignsUtil.adjustPositions(sgs);
	}
	
	private function _avoidCollisions() {
		
		if (this.dnotes.length > 1) {
			var diff = this.dnote(1).levelTop -  this.dnote(0).levelBottom;
			
			var checkRect = (this.dnote(0).notevalue.dotLevel > 0) ? this.dnote(0).rectDots : this.dnote(0).rectHeads;
			
			if (diff == 1) {
				//trace('second clash');		
				if (this.dnote(0).notevalue.dotLevel > 0) {
					var isect = GeomUtils.overlapX(checkRect, this.dnote(1).rectHeads);
					this._setDnoteX(1, isect.x);
				} else {
					this._setDnoteX(1, 	Constants.COMPLEX_COLLISION_SECOND_XSHIFT);					
				}
			} else if (diff < 1) {
				//trace('overlap');	
				//var isect = NmeTools.intersection2(this.dnote(0).rectHeads, this.dnote(1).rectHeads);
				var isect = GeomUtils.overlapX(checkRect, this.dnote(1).rectHeads);
				this._setDnoteX(1, isect.x);
			} else {
				//trace('no overlap');
			}
		}				
	}	
	
	private function _setDnoteX(idx:Int, x:Float) 	{
		this._dnotesXshift[idx] = x;
	}	
	
	/**************************************************************************
	 * Public getters and setters
	 * 
	 **************************************************************************/	
	
	private var _rectHeads:Rectangle;
	public var rectHeads(get_rectHeads, null):Rectangle;
	private function get_rectHeads():Rectangle {
		if (this._rectHeads != null) return this._rectHeads;
		var idx = 0;
		for (dnote in this.dnotes) {
			var r = dnote.rectHeads;
			r.offset(this.dnoteXshift(idx), 0);
			if (this._rectHeads == null) {
				this._rectHeads = r;
			} else {
				this._rectHeads = this._rectHeads.union(r);
			}
			idx++;
		}
		return this._rectHeads;
	}	
	
	private var _rectSigns:Rectangle;
	private function get_rectSigns():Rectangle {
		if (this._rectSigns != null) return this._rectSigns;		
		this._rectSigns = SignsUtil.getDisplayRectSigns(signs);		
		if (this._rectSigns == null) return null;
		var shiftRect = GeomUtils.overlapX(this._rectSigns, this.rectHeads);
		this._rectSigns.offset(-shiftRect.x - 	Constants.SIGNS_HEADS_DISTANCE, 0);
		
		return this._rectSigns;
	}
	public var rectSigns(get_rectSigns, null):Rectangle;

	
	private var _rectsAll:Array<Rectangle>;
	public var rectsAll(get_rectsAll, null):Array<Rectangle>;
	private function get_rectsAll():Array<Rectangle> {
		if (this._rectsAll != null) return this._rectsAll;
		this._rectsAll = [];
		if (this.rectHeads != null) this._rectsAll.push(this.rectHeads);
		if (this.rectSigns != null) this._rectsAll.push(this.rectSigns);
		
		for (dnote in this.dnotes) {
			if (dnote.rectStave != null) 			this._rectsAll.push(dnote.rectStave);			
			if (dnote.rectDots != null) 			this._rectsAll.push(dnote.rectDots);
			if (dnote.rectTiesfrom != null) 		this._rectsAll.push(dnote.rectTiesfrom);
			if (dnote.rectText != null)				this._rectsAll.push(dnote.rectText);
		}
		
		return this._rectsAll;
	}
	
	public function getRectsAllCopy():Array<Rectangle> {
		var ret : Array<Rectangle> = [];		
		for (rect in this.rectsAll) {			
			ret.push(new Rectangle(rect.x, rect.y, rect.width, rect.height));			
		}		
		return ret;
	}
	
	private var _rectFull:Rectangle;
	public var rectFull(get_rectFull, null):Rectangle;	
	private function get_rectFull():Rectangle {
		if (this._rectFull != null) return this._rectFull;
		
		for (r in this.rectsAll) {
			this._rectFull = (this._rectFull == null) ? r.clone() : this._rectFull.union(r);			
		}
		
		return this._rectFull;
	}
	
	/**************************************************************************
	 * Public methods
	 * 
	 **************************************************************************/		
	
	public function distanceX(next:Complex):Float {	
		var thisRects = this.rectsAll;
		var thisRectsHeadsWidth = this.rectHeads.width;
		var nextRects = next.rectsAll;
		
		var distanceX = dplexDistanceX(thisRects, thisRectsHeadsWidth, nextRects);
		return distanceX;
	}
	
	static public function dplexDistanceX(firstRects:Array<Rectangle>, firstRectHeadsWidth:Float, nextRects:Array<Rectangle>):Float {
		var plexDistanceX = GeomUtils.arrayOverlapX(firstRects, nextRects);
		var minDistanceX =firstRectHeadsWidth ;
		var distanceX = Math.max(plexDistanceX + Constants.HEAD_QUARTERWIDTH, minDistanceX); // Constants.HEAD_WIDTH + Constants.HEAD_QUARTERWIDTH);
		return distanceX;
	}
	
}