package nx.display;
import cx.geom.IPolyRect;
import cx.NmeTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.display.beam.IBeamGroup;
import nx.element.Head;
import nx.element.Note;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;


/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayNote {
	function getNote(): Note<Dynamic>;
	function getDisplayHeads():Array<DisplayHead> ;
	function getDisplayHead(index:Int):DisplayHead;
	function getDisplayHeadPositions(): Array<Int>;
	function getDisplayHeadBottom():DisplayHead;
	function getDisplayHeadTop():DisplayHead;
	function getDisplayHeadsDisplayRects():Array<Rectangle>;	
	function getValue():ENoteValue;
	function getLevel():Int;	
	function getDirection():EDirectionUD;
	function setDirection(direction:EDirectionUD):IDisplayNote;	
	function getDisplayRect():Rectangle;
	function getDisplayRectStave():Rectangle;	
	function getDisplayRectSigns():Rectangle;
	function getDisplayRectAppogiatura():Rectangle;
	function getDisplayRectTieTo():Rectangle;
	function getDisplayRectArpeggio():Rectangle;
	function getDisplayRectDots():Rectangle;
	function getDisplayRectTieFrom():Rectangle;
	function getDisplayRectClef():Rectangle;	
}
 
 
using DisplayNote.SignsUtil; 
using cx.NmeTools;
class DisplayNote implements IDisplayNote, implements IDisplayElement, implements IPolyRect
{

	private var _hasTieFrom:Bool;
	private var _hasTieTo:Bool;
	private var _hasAppogiatura:Bool;
	private var _hasArpeggio:Bool;
	private var _hasClef:Bool;
	
	public function new(note:Note<Dynamic>, ?forceDirection:EDirectionUD = null) {
		this.note = note;
		
		this._hasTieFrom = false;
		this._hasTieTo = false;
		this._hasAppogiatura = false;
		
		this.displayHeads = new Array<DisplayHead>();
		for (child in note.children) {
			this.displayHeads.push(new DisplayHead(child));		
			if (child.getTieFrom() != null) this._hasTieFrom = true;
			if (child.getTieTo() != null) this._hasTieTo = true;
			if (child.getApoggiatura() != null) this._hasAppogiatura = true;
		}
		this._hasArpeggio = (note.getArpeggio() != null);
		this._hasClef = (note.getClef() != null);
		
		var dir = (forceDirection != null) ? forceDirection : this.calcDirection();
		this.setDirection(dir);		
	}
	
	private var note:Note<Dynamic>;
	public function getNote():Note<Dynamic> {
		return this.note;
	}	
	
	private var displayHeads:Array<DisplayHead>;
	public function getDisplayHeads():Array<DisplayHead> {
		return this.displayHeads;
	}
	public function getDisplayHead(index:Int):DisplayHead {
		return this.displayHeads[index];
	}	
	
	public function getDisplayHeadTop():DisplayHead {
		return this.getDisplayHead(0);
	}
	
	public function getDisplayHeadBottom():DisplayHead {
		return this.getDisplayHead(this.getDisplayHeads().length - 1);
	}
	
	public function getDisplayHeadPositions():Array<Int> {
		var ret = new Array<Int>();
		for (dh in this.displayHeads) {
			ret.push(dh.getPosition());
		}
		return ret;
	}

	public function getDisplayHeadsDisplayRects():Array<Rectangle> {
		var a = new Array<Rectangle>();
		for (h in this.getDisplayHeads()) {
			a.push(h.getDisplayRect());
		}
		return a;
	}
	
	/*
	public function getDisplayHeadTopPosition():Int {
		return this.getDisplayHead(0).getPosition();
	}
	
	public function getDisplayHeadBottomPosition():Int {
		//if (this.getDisplayHeads().length == 1) return 0;
		return this.getDisplayHead(this.getDisplayHeads().length-1).getPosition();
	}	
	*/
	
	public function getLevel():Int {
		if (this.displayHeads.length < 2) return this.note.getLevelTop();
		return this.note.getLevelTop() + this.note.getLevelBottom();
	}	
		
	public function getLevelTop():Int {
		return this.note.getLevelTop();
	}	
	
	public function getLevelBottom():Int {
		return this.note.getLevelBottom();
	}
	 	
	private function getType():ENoteType {
		return this.note.type;
	}	
	
	//-----------------------------------------------------------------------------------------
	
	private var direction:EDirectionUD;
	public function getDirection():EDirectionUD {
		return this.direction;
	}	
	public function setDirection(direction:EDirectionUD):IDisplayNote {		
		this.displayRect = null;
		this.signsDisplayRect = null;
		
		this.calcHeadPositions(direction);
		this.direction = direction;
		return this;
	}

	public function getValue():ENoteValue {
		return this.note.getValue();
	}
	
	//-----------------------------------------------------------------------------------------
	
	public function hasSigns():Bool {
		return this.getSigns().length > 0;
	}
	
	public function hasStave():Bool {
		return (this.getValue().stavingLevel != 0);
	}
	
	public function hasDot():Bool {
		return (this.getValue().dotLevel != 0);
	}
	
	public function hasDotDouble():Bool {
		return this.getValue().dotLevel == 2;
	}
	
	public function hasTieFrom():Bool {
		return this._hasTieFrom;
	}

	public function hasTieTo():Bool {
		return this._hasTieTo;
	}
	
	public function hasAppogiatura():Bool {
		return this._hasAppogiatura;
	}
	
	public function hasArpeggio():Bool {
		return this._hasArpeggio;
	}
	
	public function hasClef():Bool {
		return this._hasClef;
	}
	
	//-----------------------------------------------------------------------------------------
	// Display rectangles
	
	private var displayRect:Rectangle;
	private var displayRectLeft:Float;
	
	public function getDisplayRect():Rectangle {
		if (this.displayRect != null) return this.displayRect;
		var r = this.displayHeads[0].getDisplayRect();
		if (this.displayHeads.length > 1) {
			for (i in 1...this.displayHeads.length) {
				var dHead = this.displayHeads[i];
				//r = Rectangle.fromRectangle(r.union(dHead.getDisplayRect()));
				r = r.union(dHead.getDisplayRect());
			}
		}
		this.displayRect = r;
		this.displayRectLeft = r.left;
		return r;
	}
	
	
	private var signsDisplayRect:Rectangle;
	public function getDisplayRectSigns():Rectangle {
		if (!this.hasSigns()) return null;
		if (this.signsDisplayRect != null) return this.signsDisplayRect;		
		var signRect = this.getSigns().getDisplayRectSigns();
		if (signRect == null) return null;				
		
		//signRect.width = signRect.width + 1;
		signRect.offset( -(signRect.width + Constants.HEAD_HALFWIDTH), 0);
		
		//trace(this.getDisplayHeadsDisplayRects());
		
		var ir = NmeTools.rectangleArraysIntersection(this.getDisplayHeadsDisplayRects(), [signRect]);
		if (ir != null) {
			if (ir.width > 0) signRect.offset( -ir.width, 0);
		}
		
		//signRect.offset(this.getDisplayRect().left + -signRect.width - 1, 0);		
		return signRect;
	}
	
	public function getDisplayRectStave():Rectangle {
		if (!this.hasStave()) return null;				
		
		var levelBottom = this.getLevelBottom();
		var levelTop = this.getLevelTop();	
		var staveRectHeight:Int = 10;
		if (this.getDirection() == EDirectionUD.Up) {
			return new Rectangle(0, levelTop - staveRectHeight, Constants.HEAD_HALFWIDTH, staveRectHeight); 			
		} else {
			return new Rectangle(-Constants.HEAD_HALFWIDTH, levelTop, Constants.HEAD_HALFWIDTH, staveRectHeight); 			
		}
		
	}
	
	public function getDisplayRectAppogiatura():Rectangle {
		if (!this.hasAppogiatura()) return null;
		var ret:Rectangle = null;
		
		
		for (h in this.getDisplayHeads()) {
			var a = h.getHead().getApoggiatura();
			if (a != null) {
				var r = a.getDisplayRect();
				r.offset(0, h.getLevel());
				ret = (ret == null) ? r : ret.union(r);
			}			
		}
		
		if (ret != null) ret.offset(-(ret.width) + this.getDisplayRect().left, 0);
		
		if (this.hasSigns()) {
			var ir = (this.getDisplayRectSigns().intersection(ret));			
			if (ir.width > 0) {
				ret.offset( -(ret.left - this.getDisplayRectSigns().left) - ir.width , 0);
			}
		}
		
		return ret;
	}
	
	public function getDisplayRectTieTo():Rectangle {
		if (!this.hasTieTo()) return null;
		
		/*
		var y = this.getDisplayHeadTop().getLevel() - 2;
		var h =  this.getDisplayHeadBottom().getLevel() - y;
		var w = Constants.HEAD_WIDTH * 2;		
		var x = this.getDisplayRect().left - w ;		
		var ret = new Rectangle(x, y , w, h);
		*/
		var ret:Rectangle = null;
		for (h in this.getDisplayHeads()) {
			var a = h.getHead().getTieTo();
			if (a != null) {				
				var r = a.getDisplayRect();
				r.offset(0, h.getLevel());
				ret = (ret == null) ? r : ret.union(r);
			}			
		}		
		if (ret == null) return null;
		ret.x = this.getDisplayRect().left - ret.width;		
		ret.offset(0, -1);
		/*
		if (this.hasDot()) {
			ret.offset(this.getDisplayRectDots().width, 0) ;
		}		
		ret.offset(0, -1);
		if (this.getDirection() == EDirectionUD.Up) ret.offset(0, 2);		
		return ret;
		*/
		
		
		
		
		
		if (this.getDirection() == EDirectionUD.Up) ret.offset(0, 2);
		if (this.hasSigns()) {
			var ir = (this.getDisplayRectSigns().intersection(ret));
			if (ir.width > 0) ret.offset(-(ir.width+1), 0);			
		}		
		if (this.hasAppogiatura()) {
			var ir = (this.getDisplayRectAppogiatura().intersection(ret));
			if (ir.width > 0) ret.offset(-(ir.width), 0);			
		}				
		if (this.hasArpeggio()) {
			var ir = (this.getDisplayRectArpeggio().intersection(ret));
			if (ir.width > 0) ret.offset(-(ir.width), 0);			
		}
		return ret;
	}
	
	public function getDisplayRectArpeggio():Rectangle {
		if (!this.hasArpeggio()) return null;
		var a = this.getNote().getArpeggio();				
		var y = this.getDisplayHeadTop().getLevel() - 1 + a.topOffset;
		var h =  this.getDisplayHeadBottom().getLevel() - y + 1 + a.bottomOffset;
		var w = Constants.HEAD_WIDTH ;
		var x = this.getDisplayRect().left - Constants.HEAD_WIDTH - Constants.HEAD_HALFWIDTH;
		var ret = new Rectangle(x, y , w, h);		
		if (this.hasSigns()) {
			//ret.offset( -this.getDisplayRectSigns().width, 0);
			var ir = (this.getDisplayRectSigns().intersection(ret));
			if (ir.width > 0) {
				ret.offset( -(ir.width), 0);
			}
		}
		if (this.hasAppogiatura()) {
			var ir = (this.getDisplayRectAppogiatura().intersection(ret));
			if (ir.width > 0) {
				ret.offset( -(ir.width), 0);
			}
		}		

		return ret;
	}
	
	public function getDisplayRectClef():Rectangle {
		if (!this.hasClef()) return null;
		var c = this.getNote().getClef();						
		var y = -5 + c.levelOffset;
		var h =  10;
		var w = Constants.HEAD_WIDTH * 2;
		var x = this.getDisplayRect().left - w;		
		var ret = new Rectangle(x, y , w, h);		
		if (this.hasSigns()) {
			var ir = (this.getDisplayRectSigns().intersection(ret));
			if (ir.width > 0) ret.offset( -(ir.width+1), 0);
		}	
		if (this.hasAppogiatura()) {
			var ir = (this.getDisplayRectAppogiatura().intersection(ret));
			if (ir.width > 0) ret.offset( -(ir.width), 0);
		}			
		if (this.hasArpeggio()) {
			var ir = (this.getDisplayRectArpeggio().intersection(ret));
			if (ir.width > 0) ret.offset( -(ir.width), 0);
		}	
		if (this.hasTieTo()) {
			var ir = (this.getDisplayRectTieTo().intersection(ret));
			if (ir.width > 0) ret.offset( -(ir.width), 0);
		}			
		return ret;
	}
	
	public function getDisplayRectDots():Rectangle {
		if (!this.hasDot()) return null;
		var y = this.getDisplayHeadTop().getLevel() - 1;
		var h =  this.getDisplayHeadBottom().getLevel() - y + 1;
		var w = (this.hasDotDouble()) ? Constants.HEAD_WIDTH + Constants.HEAD_HALFWIDTH : Constants.HEAD_WIDTH;
		var x = this.getDisplayRect().right;
		var ret = new Rectangle(x, y , w, h);
		return ret;
	} 
	
	public function getDisplayRectTieFrom():Rectangle {
		if (!this.hasTieFrom()) return null;		
		var ret:Rectangle = null;
		for (h in this.getDisplayHeads()) {
			var a = h.getHead().getTieFrom();
			if (a != null) {				
				var r = a.getDisplayRect();
				r.offset(0, h.getLevel());
				ret = (ret == null) ? r : ret.union(r);
			}			
		}		
		if (ret == null) return null;
		ret.x = this.getDisplayRect().right;		
		ret.offset(0, -1);
		if (this.hasDot()) {
			ret.offset(this.getDisplayRectDots().width, 0) ;
		}		
		if (this.getDirection() == EDirectionUD.Up) ret.offset(0, 2);		
		return ret;
	}
	
	//-----------------------------------------------------------------------------------------------------

	private var totalRect:Rectangle;
	public function getTotalRect():Rectangle {
		if (this.totalRect == null) this.getArrayOfDisplayRects();
		return this.totalRect;
	}
	
	private var arrayOfDisplayRects:Array<Rectangle>;
	public function getArrayOfDisplayRects(): Array<Rectangle> {		
		if (this.arrayOfDisplayRects != null) return this.arrayOfDisplayRects;
		var ret = new Array<Rectangle>();		
		
		this.totalRect = this.getDisplayRect().clone();
		
		ret.push(this.getDisplayRect().clone());		
		
		if (this.hasStave()) ret.push(this.getDisplayRectStave());
		
		if (this.hasSigns()) {
			//trace(this.totalRect);
			//trace(this.getDisplayRectSigns());
			ret.push(this.getDisplayRectSigns());
			this.totalRect = this.totalRect.union(this.getDisplayRectSigns());
		}
		
		if (this.hasDot()) {
			ret.push(this.getDisplayRectDots());
			this.totalRect = this.totalRect.union(this.getDisplayRectDots());
		}
		if (this.hasTieFrom()) {
			ret.push(this.getDisplayRectTieFrom());
			this.totalRect = this.totalRect.union(this.getDisplayRectTieFrom());
		}
		
		if (this.hasAppogiatura()) {
			ret.push(this.getDisplayRectAppogiatura());
			this.totalRect = this.totalRect.union(this.getDisplayRectAppogiatura());
		}
		if (this.hasArpeggio()) {
			ret.push(this.getDisplayRectArpeggio());
			this.totalRect = this.totalRect.union(this.getDisplayRectArpeggio());
		}
		if (this.hasTieTo()) {
			ret.push(this.getDisplayRectTieTo());
			this.totalRect = this.totalRect.union(this.getDisplayRectTieTo());
		}
		if (this.hasClef()) {
			ret.push(this.getDisplayRectClef());
			this.totalRect = this.totalRect.union(this.getDisplayRectClef());
		}
		this.arrayOfDisplayRects = ret;
		return this.arrayOfDisplayRects;
	}	
	
	public function getNoteDistanceX(nextDisplayNote:DisplayNote, includeNotesWidth:Bool=true):Float {		
		var distance:Float = cx.NmeTools.arrayRectanglesOverlapX(this.getArrayOfDisplayRects(), nextDisplayNote.getArrayOfDisplayRects());
		if (includeNotesWidth) return Math.max(distance, this.getDisplayRect().width);
		return distance;
	}
	
	
	
	
	//--------------------------------------------------------------------------------------------------------------
	
	public function getSigns():TSigns {
		var r:TSigns = [];
		for (head in this.note.children) {
			r.push( { position:0, sign:head.getSign(), level:head.getLevel() } );			
		}		
		return r.adjustPositions();
	}
		
	public function debugSigns() {
		trace(this.getSigns().debug());
	}
	
	public var beamGroup:IBeamGroup;
	public var beamTemp:Int;
	
	
	//----------------------------------------------------------------------------------------
	
	private function calcDirection():EDirectionUD {
		return (this.getLevel() > 0) ? EDirectionUD.Up : EDirectionUD.Down;
	}	
	
	private function calcHeadPositions(direction:EDirectionUD):DisplayNote {
		if (this.getDisplayHeads().length < 2) return this;
		//if (this.type != nx.Enum.ENoteType.Normal) return this;
		var len:Int = this.getDisplayHeads().length;		
		
		// reset
		for (i in 0...len) {
			this.getDisplayHeads()[i].setPosition(0);
		}
		
		if (direction == EDirectionUD.Down) {
			for (i in 0...len - 1) {
				var dHead = this.getDisplayHead(i);
				var dHeadNext = this.getDisplayHead(i + 1);
				var lDiff = dHeadNext.getLevel() - dHead.getLevel();
				if (lDiff < 2) {
					if (dHead.getPosition() == dHeadNext.getPosition()) dHeadNext.setPosition(-1);
				}
			}
		} else {
			for (j in 0...len - 1) {
				var i = len - j - 1;
				var dHead:DisplayHead = this.getDisplayHead(i);
				var dHeadNext:DisplayHead = this.getDisplayHead(i - 1);
				var lDiff = dHead.getLevel() - dHeadNext.getLevel();
				if (lDiff < 2) {
					if (dHead.getPosition() == dHeadNext.getPosition()) dHeadNext.setPosition(1);
				}
			}
		}
		return this;
	}
	
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	/* INTERFACE cx.geom.IPolyRect */
	
	public function getRects():Array<Rectangle> 
	{
		return null;
	}	
	
	
	
}

typedef TSign = {
	sign:ESign,
	level:Int,	
	position:Int,
}

typedef TSigns = Array<TSign>;

class SignsUtil {
	
	static var BREAKPOINT:Int = 6;
	
	static public function adjustPositions(signs:TSigns):TSigns {
		signs = removeNones(signs);
		//debug(signs);
		if (signs.length < 2) return signs;
		signs = sortSigns(signs);
		signs = calcPositions(signs);
		//debug(signs);
		return signs;
	}
	
	static private function calcPositions(signs:TSigns):TSigns {
		var levels = [-999, -999, -999, -999];		
		for (sign in signs) {		
			var cpos = 0;
			var diff = sign.level - levels[cpos];
			while (diff < SignsUtil.BREAKPOINT) {
				cpos++;
				diff = sign.level - levels[cpos];
			}
			levels[cpos] = sign.level;
			sign.position = cpos;
		}
		return signs;
	}
	
	static private function removeNones(signs:TSigns):TSigns {
		var r:TSigns = [];
		for (sign in signs) {
			if (sign.sign != ESign.None) r.push(sign);
		}
		return r;
	}
	
	static private function sortSigns(signs:TSigns):TSigns {
		signs.sort(function(signA, signB) {
			if (signA.level <= signB.level) { return -1; }
			else { return 1; }
		});
		return signs;		
	}
	
	static public function getPositions(signs:TSigns):Array<Int> {
		return Lambda.array(Lambda.map(signs, function(sign) { return sign.position; } ));
	}
	
	static public function debug(signs:TSigns) {
		trace('');
		for (sign in signs) {
			trace(sign);
		}
	}
	
	static public function getDisplayRectSigns(signs:TSigns):Rectangle {
		var resultRect:Rectangle = null;
		for (sign in signs) {
			var signRect = new Rectangle(sign.position * -3, sign.level - 3, 3, 6);
			if (resultRect == null) {
				resultRect = signRect.clone();
			} else {
				resultRect = resultRect.union(signRect);
			}
		}	
		if (resultRect != null) resultRect.offset(-resultRect.left, 0);
		
		return resultRect;
	}
	


	
}

