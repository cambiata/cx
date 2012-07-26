package nx.core.display;
import cx.ArrayTools;
import cx.NmeTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.type.TSigns;
import nx.core.util.SignsUtil;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class DPlex
{
	private var dnotesX:Array<Float>;
	
	static private var COLLISION_XSHIFT_SECOND:Float = 3 * Constants.HEAD_QUARTERWIDTH;
	public var signs(default, null):TSigns;
	

	public function new(dnotes:Iterable<DNote>)  {
		this.dnotes 		= Lambda.array(dnotes);
		this.dnotesX 		= [];
		this.signs 			= [];
		
		for (dnote in this.dnotes) this.dnotesX.push(0);
		
		var sgs:TSigns = [];
		for (dnote in this.dnotes) {
			for (dhead in dnote.dheads) {
				sgs.push({sign:dhead.head.sign, level:dhead.head.level, position:0});
			}
		}
		this.signs = SignsUtil.adjustPositions(sgs);

		
		
		// X offset for second DNote to avoid collisions...
		if (this.dnotes.length > 1) {
			var diff = this.dnote(1).levelTop -  this.dnote(0).levelBottom;
			if (diff == 1) {
				//trace('second clash');		
				this._setDnoteX(1, COLLISION_XSHIFT_SECOND);
			} else if (diff < 1) {
				//trace('overlap');	
				var isect = NmeTools.intersection2(this.dnote(0).rectHeads, this.dnote(1).rectHeads);
				this._setDnoteX(1, isect.width);
			} else {
				//trace('no overlap');
			}
		}		
		
	
	}
	
	public var dnotes(default, null):Array<DNote>;	
	
	
	public function dnote(idx:Int) : DNote 	return this.dnotes[idx]	
	public function dnoteX(idx:Int): Float return this.dnotesX[idx]
	private function _setDnoteX(idx:Int, x:Float) 	this.dnotesX[idx] = x	
	
	//------------------------------------------------------------------------------------------------------------------
	
	private var _rectHeads:Rectangle;
	public var rectHeads(get_rectHeads, null):Rectangle;
	private function get_rectHeads():Rectangle {
		if (this._rectHeads != null) return this._rectHeads;
		var idx = 0;
		for (dnote in this.dnotes) {
			var r = dnote.rectHeads;
			r.offset(this.dnoteX(idx), 0);
			if (this._rectHeads == null) {
				this._rectHeads = r;
			} else {
				this._rectHeads = this._rectHeads.union(r);
			}
			idx++;
		}
		return this._rectHeads;
	}
	
	//------------------------------------------------------------------------------------------------------------------
	
	private var _rectSigns:Rectangle;
	private function get_rectSigns():Rectangle {
		if (this._rectSigns != null) return this._rectSigns;		
		this._rectSigns = SignsUtil.getDisplayRectSigns(signs);		
		trace(this._rectSigns);
		
		return this._rectSigns;
	}
	public var rectSigns(get_rectSigns, null):Rectangle;
	
}