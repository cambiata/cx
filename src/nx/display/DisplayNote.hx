package nx.display;
import nme.geom.Rectangle;
import nx.const.Constants;
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
	function getDisplayHeadBottomPosition():Int;
	function getDisplayHeadTopPosition():Int;
	
	function getValue():ENoteValue;
	function getLevel():Int;	

	function getDirection():EDirectionUD;
	function setDirection(direction:EDirectionUD):IDisplayNote;
	
	function getDisplayRect():Rectangle;
	function getStaveDisplayRect():Rectangle;
	
	function getSignsDisplayRect():Rectangle;
	function getAppogiaturaDisplayRect():Rectangle;
	function getTietoDisplayRect():Rectangle;
	function getArpeggioDisplayRect():Rectangle;
	function getNoteclefDisplayRect():Rectangle;
	function getDotsDisplayRect():Rectangle;
	function getTiefromDisplayRect():Rectangle;
	
}
 
 
using DisplayNote.SignsUtil; 

class DisplayNote implements IDisplayNote, implements IDisplayElement
{

	private var _hasTieFrom:Bool;
	private var _hasTieTo:Bool;
	private var _hasAppogiatura:Bool;
	
	
	
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
	
	public function getDisplayHeadPositions():Array<Int> {
		var ret = new Array<Int>();
		for (dh in this.displayHeads) {
			ret.push(dh.getPosition());
		}
		return ret;
	}

	public function getDisplayHeadTopPosition():Int {
		return this.getDisplayHead(0).getPosition();
	}
	
	public function getDisplayHeadBottomPosition():Int {
		//if (this.getDisplayHeads().length == 1) return 0;
		return this.getDisplayHead(this.getDisplayHeads().length-1).getPosition();
	}	
	
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
	
	public function getDotLevel():Int {
		return this.getValue().dotLevel;
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
	public function getSignsDisplayRect():Rectangle {
		if (!this.hasSigns()) return null;
		if (this.signsDisplayRect != null) return this.signsDisplayRect;
		
		var signRect = this.getSigns().getSignsDisplayRect();
		if (signRect == null) return null;				

		signRect.offset(this.getDisplayRect().left + -signRect.width - 1, 0);		
		return signRect;
	}
	
	public function getStaveDisplayRect():Rectangle {
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
	
	public function getAppogiaturaDisplayRect():Rectangle {
		return null;
	}
	
	public function getTietoDisplayRect():Rectangle {
		return null;
	}
	
	public function getArpeggioDisplayRect():Rectangle {
		return null;
	}
	
	public function getNoteclefDisplayRect():Rectangle {
		return null;
	}
	
	public function getDotsDisplayRect():Rectangle {
		return null;
	} 
	
	public function getTiefromDisplayRect():Rectangle {
		return null;
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
	
	static public function getSignsDisplayRect(signs:TSigns):Rectangle {
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

