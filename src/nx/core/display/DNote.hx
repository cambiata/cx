package nx.core.display;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.element.Note;
import nx.core.type.TSigns;
import nx.core.util.GeomUtils;
import nx.core.util.SignsUtil;
import nx.display.beam.IBeamGroup;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.utils.EDirectionTools;

/**
 * ...
 * @author Jonas Nyström
 */

class DNote 
{
	
	static var DEFAULT_STAVE_LENGTH = 6.0;
	
	public function new(note:Note, forceDirection:EDirectionUD=null) 
	{
		this.note 				= (note != null) ? note : new Note();		
		this.notevalue 		= this.note.notevalue;
		this.headsCount 		= this.note.heads.length;
		this.levelTop 			= this.note.heads[0].level;
		this.levelBottom 	= this.note.heads[this.headsCount-1].level;		
		this.dheads 			= [];
		this.notetype			= this.note.type;
		
		for (head in this.note.heads) {
			this.dheads.push(new DHead(head));
		}
		
		this.signs 				= this._calcSigns();
		
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
	//public var type(default, null):ENoteType;
	public var notetype(default, null):ENoteType;	
	public var dheads(default, null):Array<DHead>;
	public var headsCount(default, null):Int;
	public var levelTop(default, null):Int;
	public var levelBottom(default, null):Int;
	public var headPositions(default, null):Array<Int>;
	public var signs(default, null):TSigns;	
	
	public function dhead(idx:Int) {
		return this.dheads[idx];
	}
	
	
	//--------------------------------------
	
	public var direction(get_direction, set_direction):EDirectionUD;
	private var _direction:EDirectionUD;
	private function get_direction():EDirectionUD {
		return _direction;
	}
	
	private function set_direction(value:EDirectionUD):EDirectionUD {
		this._rectHeads = null;
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
	
	
	
	//-----------------------------------------------------------------------------------------------------
	
	public var beamGroup:IBeamGroup;
	public var beamTemp:Int;	
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _rectHeads:Rectangle;
	public var rectHeads(get_rectHeads, null):Rectangle;	
	private function get_rectHeads():Rectangle {
		if (this._rectHeads != null) return this._rectHeads;
		
		switch(note.type) {
			case ENoteType.Pause:
				var pauseLevel = this.dheads[0].level;
				this._rectHeads = new Rectangle( -Constants.HEAD_QUARTERWIDTH, -3, Constants.HEAD_HALFWIDTH, 6);			
				this._rectHeads.offset(0, pauseLevel * Constants.HEAD_HALFHEIGHT);
			default:
				this._rectHeads = this.dheads[0].rect;
				this._rectHeads.offset(this.headPositions[0]*Constants.HEAD_WIDTH, 0);
				if (this.dheads.length > 1) {
					for (i in 1...this.dheads.length) {
						var headRect = this.dheads[i].rect;
						headRect.offset(this.headPositions[i]*Constants.HEAD_WIDTH, 0);
						this._rectHeads = this._rectHeads.union(headRect);
					}
				}
		}
		return this._rectHeads;
	}
	
	
	private var _rectStave:Rectangle;
	public var rectStave(get_rectStave, null):Rectangle;
	private function get_rectStave():Rectangle {
		if (this.notevalue.stavingLevel == 0) return null;
		if (this._rectStave != null) return this._rectStave;		
		var r = this.rectHeads.clone();		
		if (this.direction == EDirectionUD.Up) {
			r.x = Constants.HEAD_HALFWIDTH;
			
			r.width = Constants.STAVE_WIDTH;

			// 8ths and 16ths flags:
			if (this.notevalue.beamingLevel > 0) r.width += Constants.HEAD_HALFWIDTH*0.7;
			
			
			this._rectStave = GeomUtils.stretchUp(r, DEFAULT_STAVE_LENGTH);
			this._rectStave = GeomUtils.stretchDown(r, -Constants.STAVE_OFFSET);
		} else {
			r.x = -Constants.HEAD_HALFWIDTH;
			r.width = Constants.STAVE_WIDTH;			
			this._rectStave = GeomUtils.stretchDown(r, DEFAULT_STAVE_LENGTH);
			this._rectStave = GeomUtils.stretchUp(r, -Constants.STAVE_OFFSET);
		}		
		return this._rectStave;
	}
	
	
	private var _rectDots:Rectangle;
	public var rectDots(get_rectDots, null):Rectangle;
	private function get_rectDots():Rectangle {
		if (this._rectDots != null) return this._rectDots;		
		if (this.notevalue.dotLevel == 0) return null;		
		var r = this.rectHeads.clone();		
		r.offset(r.width+ Constants.HEAD_QUARTERWIDTH, 0) ;
		r.width = Constants.HEAD_HALFWIDTH * this.notevalue.dotLevel;
		this._rectDots = r;
		return this._rectDots;
	}
	
}
