package nx.core.display;
import nx.core.element.Note;
import nx.core.type.TSigns;
import nx.core.util.SignsUtil;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
import nx.enums.utils.EDirectionTools;

/**
 * ...
 * @author Jonas Nyström
 */

class DNote 
{
	public function new(note:Note, forceDirection:EDirectionUD=null) 
	{
		this.note = note;		
		this.notevalue = this.note.notevalue;
		this.headsCount = this.note.heads.length;
		this.levelTop = this.note.heads[0].level;
		this.levelBottom = this.note.heads[this.headsCount-1].level;		
		this.dheads = [];
		for (head in this.note.heads) {
			this.dheads.push(new DHead(head));
		}
		this.signs = this._calcSigns();
		
		/*
		this.direction = (forceDirection != null) ? forceDirection : this._calcDirection();		
		*/
		
		if (forceDirection != null) {
			this.set_direction(forceDirection);
		} else if (note.direction != EDirectionUAD.Auto) {
			this.direction = EDirectionTools.UADtoUD(note.direction);
		} else {
			this.direction = this._calcDirection();
		}
		
	}
	
	public var note(default, null):Note;
	public var notevalue(default, null):ENoteValue;
	public var dheads(default, null):Array<DHead>;
	public var headsCount(default, null):Int;
	public var levelTop(default, null):Int;
	public var levelBottom(default, null):Int;
	public var headPositions(default, null):Array<Int>;
	public var signs(default, null):TSigns;	
	
	//--------------------------------------
	
	public var direction(get_direction, set_direction):EDirectionUD;
	private var _direction:EDirectionUD;
	private function get_direction():EDirectionUD {
		return _direction;
	}
	private function set_direction(value:EDirectionUD):EDirectionUD {
		this._direction = value;
		this.headPositions = this._calcHeadPositions(this._direction);
		this.signs = this._calcSigns();
		return this._direction;
	}
	
	//-----------------------------------------------------------------------------------------------------
	// Private methods
	//-----------------------------------------------------------------------------------------------------
	
	private function _calcDirection():EDirectionUD {
		return (this._getHeadsLevel() > 0) ? EDirectionUD.Up : EDirectionUD.Down;
	}		
	
	public function _getHeadsLevel():Int {
		if (this.headsCount < 2) return this.levelTop;
		return this.levelTop + this.levelBottom;
	}		

	private function _calcHeadPositions(direction:EDirectionUD)	{
		if (this.headsCount < 2) return [0];
		var len:Int = this.headsCount;
		var ret:Array<Int> = [];
		// reset
		for (i in 0...len) {  ret.push(0); }
		// calc
		if (direction == EDirectionUD.Down) {
			for (i in 0...len - 1) {				
				var dhead = this.dheads[i];
				var dheadNext = this.dheads[i + 1];
				var lDiff = dheadNext.level - dhead.level;
				if (lDiff < 2) {
					if (ret[i] == ret[i + 1]) {
						ret[i + 1] = -1;
					}
				}
			}
		} else {
			for (j in 0...len - 1) {
				var i = len - j - 1;				
				var dhead = this.dheads[i];
				var dheadNext = this.dheads[i - 1];
				var lDiff = dhead.level - dheadNext.level;				
				if (lDiff < 2) {
					if (ret[i] == ret[i - 1]) {
						ret[i - 1] = 1;
					}
				}								
			}
		}
		return ret;
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	private function _calcSigns():TSigns {
		var ret:TSigns = [];
		for (head in this.note.heads) {
			ret.push( { position:0, sign:head.sign, level:head.level} );			
		}		
		return SignsUtil.adjustPositions(ret);
	}	
	
	
}
