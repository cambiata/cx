package nx.display;
import nme.geom.Rectangle;
import nx.display.beam.IBeamGroup;
import nx.element.Head;
import nx.element.Note;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.geom.DRectangle;
import nx.types.NxY;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayNote {
	function getNote(): Note<Dynamic>;
	function getDisplayHeads():Array<DisplayHead> ;
	function getDisplayHead(index:Int):DisplayHead;
	function getDisplayHeadPositions(): Array<Int>;
	
	function getLevel():NxY;	
	function getDirection():EDirectionUD;
	
	function setDirection(direction:EDirectionUD):IDisplayNote;
	function getSignsDisplayRect():DRectangle;
	
	
	//function getDisplayPreRect():DRectangle;
	/*
	function getDisplayStaveRect():DRectangle;
	function getDisplayRect():DRectangle;
	function getDisplayPostRect():DRectangle;
	function getValue(): Int; // ????	
	*/
	
	
}
 
 
using DisplayNote.SignsUtil; 

class DisplayNote implements IDisplayNote, implements IDisplayElement
{

	public function new(note:Note<Dynamic>, ?forceDirection:EDirectionUD = null) {
		this.note = note;
		this.displayHeads = new Array<DisplayHead>();
		for (child in note.children) this.displayHeads.push(new DisplayHead(child));		
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
	
	public function getLevel():NxY {
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
	
	
	private var direction:EDirectionUD;
	public function getDirection():EDirectionUD {
		return this.direction;
	}	
	public function setDirection(direction:EDirectionUD):IDisplayNote {		
		this.calcHeadPositions(direction);
		this.direction = direction;
		this.displayRect = null;
		return this;
	}

	public function getValue():ENoteValue {
		return this.note.getValue();
	}
	
	private var displayRect:DRectangle;
	public function getDisplayRect():DRectangle {
		if (this.displayRect != null) return this.displayRect;
		var r = this.displayHeads[0].getDisplayRect();
		if (this.displayHeads.length > 1) {
			for (i in 1...this.displayHeads.length) {
				var dHead = this.displayHeads[i];
				r = DRectangle.fromRectangle(r.union(dHead.getDisplayRect()));
			}
		}
		this.displayRect = r;
		return r;
	}
	
	public function getSignsDisplayRect():DRectangle {
		var signRect = this.getSigns().getSignsDisplayRect();
		var noteRect = this.getDisplayRect();
		signRect.offset(noteRect.left + -signRect.width - 1, 0);		
		return DRectangle.fromRectangle(signRect);
	}
	
	
	
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
	
	public function calcHeadPositions(direction:EDirectionUD):DisplayNote {
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
	
	static public function getSignsDisplayRect(signs:TSigns):DRectangle {
		var resultRect:DRectangle = null;
		for (sign in signs) {
			var signRect = new DRectangle(sign.position * -3, sign.level - 3, 3, 6);
			if (resultRect == null) {
				resultRect = DRectangle.fromRectangle(signRect.clone());
			} else {
				resultRect = DRectangle.fromRectangle(resultRect.union(signRect));
			}
		}	
		resultRect.offset(-resultRect.left, 0);
		
		return DRectangle.fromRectangle(resultRect);
	}
}



