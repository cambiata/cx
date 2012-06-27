package nx.core.display;
import nx.core.element.Note;
import nx.enums.EDirectionUD;

/**
 * ...
 * @author Jonas Nyström
 */

class DNote 
{
	public function new(note:Note, forceDirection:EDirectionUD=null) 
	{
		this._note = note;		
		this._headsCount = this._note.heads.length;
		this._levelTop = this._note.heads[0].level;
		this._levelBottom = this._note.heads[this._headsCount-1].level;		
		this._dHeads = new Array<DHead>();
		for (head in this._note.heads) {
			this._dHeads.push(new DHead(head));
		}
		
		//var dir:EDirectionUD = ;
		this.set_direction((forceDirection != null) ? forceDirection : this._calcDirection());		
	}

	//-----------------------------------------------------------------------------------------------------
	
	private var _note:Note;
	
	private function get_note():Note 
	{
		return _note;
	}
	
	public var note(get_note, null):Note;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _dHeads:Array<DHead>;
	
	private function get_dHeads():Array<DHead> 
	{
		return _dHeads;
	}
	
	public var dHeads(get_dHeads, null):Array<DHead>;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _headsCount:Int;
	
	private function get_headsCount():Int 
	{
		return _headsCount;
	}
	
	public var headsCount(get_headsCount, null):Int;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _levelTop:Int;
	
	private function get_levelTop():Int 
	{
		return _levelTop;
	}
	
	public var levelTop(get_levelTop, null):Int;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _levelBottom:Int;
	
	private function get_levelBottom():Int 
	{
		return _levelBottom;
	}
	
	public var levelBottom(get_levelBottom, null):Int;
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _direction:EDirectionUD;
	
	private function get_direction():EDirectionUD 
	{
		return _direction;
	}
	
	private function set_direction(value:EDirectionUD):EDirectionUD 
	{
		this._direction = value;
		this._headPositions = this._calcHeadPositions(this._direction);
		return this._direction;
	}
	
	public var direction(get_direction, set_direction):EDirectionUD;	
	
	//-----------------------------------------------------------------------------------------------------
	
	private function get_headPositions():Array<Int> 
	{
		return _headPositions;
	}
	
	public var headPositions(get_headPositions, null):Array<Int>;
	
	private var _headPositions:Array<Int>;
	
	
	//-----------------------------------------------------------------------------------------------------
	// Private methods
	//-----------------------------------------------------------------------------------------------------
	
	private function _calcDirection():EDirectionUD 
	{
		return (this._getHeadsLevel() > 0) ? EDirectionUD.Up : EDirectionUD.Down;
	}		
	
	public function _getHeadsLevel():Int 
	{
		if (this._headsCount < 2) return this.levelTop;
		return this.levelTop + this.levelBottom;
	}		

	private function _calcHeadPositions(direction:EDirectionUD)	
	{
		if (this._headsCount < 2) return [0];
		var len:Int = this._headsCount;
		var ret:Array<Int> = [];
		// reset
		for (i in 0...len) {  ret.push(0); }
		// calc
		if (direction == EDirectionUD.Down) {
			for (i in 0...len - 1) {				
				var dHead = this._dHeads[i];
				var dHeadNext = this._dHeads[i + 1];
				var lDiff = dHeadNext.level - dHead.level;
				if (lDiff < 2) {
					if (ret[i] == ret[i + 1]) {
						ret[i + 1] = -1;
					}
				}
			}
		} else {
			for (j in 0...len - 1) {
				var i = len - j - 1;				
				var dHead = this._dHeads[i];
				var dHeadNext = this._dHeads[i - 1];
				var lDiff = dHead.level - dHeadNext.level;				
				if (lDiff < 2) {
					if (ret[i] == ret[i - 1]) {
						ret[i - 1] = 1;
					}
				}								
			}
		}
		return ret;
	}
	
}
