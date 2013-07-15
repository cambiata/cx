package nx.display;
import cx.ArrayTools;
import cx.GUIDTools;
import cx.StrTools;
import haxe.Utf8;
import nme.geom.Point;
import nme.geom.Rectangle;
import nx.Constants;
import nx.element.Note;
import nx.display.type.TSigns;
import nx.display.util.GeomUtils;
import nx.display.util.SignsUtil;
import nx.display.beam.IBeamGroup;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ERectCorrection;
import nx.enums.utils.EDirectionTools;
import nx.output.ITextProcessor;
import nx.output.Scaling;
import nx.output.Text;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
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
		
		this.flagCorrection 	= ERectCorrection.None;
		
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
		
		this.guid = GUIDTools.guid();

	}
	
	public var note(default, null):Note;
	public var notevalue(default, null):ENoteValue;
	public var notetype(default, null):ENoteType;	
	public var dheads(default, null):Array<DHead>;
	public var headsCount(default, null):Int;
	public var levelTop(default, null):Int;
	public var levelBottom(default, null):Int;
	public var headPositions(default, null):Array<Int>;
	public var signs(default, null):TSigns;	
	public var guid(default, null):String;
	
	
	public var topConnPointLeft:Point;
	public var topConnPointMid:Point;
	public var topConnPointRight:Point;
	
	public var botConnPointLeft:Point;
	public var botConnPointMid:Point;
	public var botConnPointRight:Point;
	
	
	public function dhead(idx:Int) {
		return this.dheads[idx];
	}

	private var flagCorrection:ERectCorrection;
	
	public function setFlagCorrection(correction:ERectCorrection) {
		
			this.flagCorrection = ERectCorrection.CorrectFlags;
			this._rectStave = null;
			//trace('Rect stave != null - recalculate!');
			var dummy = this.rectStave;	 // force recalculate

	}
	
	public function countTies():Int {
		var count = 0;
		for (head in this.note.heads) {
			if (head.tie != null) count++;
		}
		return count;
	}

	private var _levels:Array<Int>;
	public function getLevels():Array<Int> {
		if (_levels != null) return _levels;
		this._levels = [];
		for (dhead in this.dheads) {
			this._levels.push(dhead.head.level);
		}
		return this._levels;
	}
	
	private var _tieLevels:Array<Int>;
	public function getTieLevels():Array<Int> {
		if (this._tieLevels != null) return this._tieLevels;
		this._tieLevels = [];
		for (dhead in this.dheads) {
			if (dhead.head.tie != null) this._tieLevels.push(dhead.head.level);
		}
		return this._tieLevels;
	}

	private var _tieConnections:Array<Int>;
	public function getTieConnections(next:DNote):Array<Int> {		
		var thisTieLevels = this.getTieLevels();
		var nextLevels = next.getLevels();
		var overlap = ArrayTools.overlap(thisTieLevels, nextLevels);
		return overlap; // 
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
		
		switch(this.notetype) {
			default: return null;
			case ENoteType.Normal: {} // continue;
		}
		
		var ret:TSigns = [];
		for (head in this.note.heads) {
			ret.push( { position:0, sign:head.sign, level:head.level} );			
		}		
		return SignsUtil.adjustPositions(ret);
	}	
	
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
			case ENoteType.Lyric:
				this._rectHeads = new Rectangle( -0.1, -1, 0.2, 2);
			case ENoteType.Tpl, ENoteType.TplChain:
				this._rectHeads = new Rectangle( -1, -1, 2, 2);
			
			default: // Normal
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
	
	private var _rectText:Rectangle;
	public var rectText(get_rectText, null):Rectangle;
	private function get_rectText():Rectangle 	{
		if (this._rectText != null) return this._rectText;
		
		switch (this.notetype) {
			default: return null;
			case ENoteType.Lyric: { } // continue
				if (this.notetype != ENoteType.Lyric) return null;
				var lyricLevel = this.dheads[0].level;
				var text = this.note.text;
				if (text.endsWith('-')) text = text.replace('-', '');
				if (text.endsWith('_')) text = text.replace('-', '');
				var textProcessor:Text = Text.getInstance();		
				var rect = textProcessor.getStringRect(text).clone();		
				var w:Float = rect.width / 3;
				var h:Float = rect.height / 6;				
				this._rectText = new Rectangle( -w/2, -h/2, w + Constants.HEAD_HALFWIDTH, h);		
				this._rectText.offset(0, lyricLevel * Constants.HEAD_HALFHEIGHT);					
			case ENoteType.Tpl: { }	// continue
				this._rectText = new Rectangle( -Constants.TPL_RECT_X, -Constants.TPL_RECT_Y, 2 * Constants.TPL_RECT_X, 2 * Constants.TPL_RECT_Y);		
			case ENoteType.TplChain:	
				this._rectText = new Rectangle( -Constants.TPL_RECT_X, -Constants.TPL_RECT_Y, 2 * Constants.TPL_RECT_X, 2 * Constants.TPL_RECT_Y);
				this._rectText.offset(0, this.levelTop * Constants.TPLCHAIN_Y_SHIFT);
		}
		
		return this._rectText;
	}
	
	public function setRectText(rect:Rectangle) {
		this._rectText = rect;
	}
	
	private var _rectStave:Rectangle;
	public var rectStave(get_rectStave, null):Rectangle;
	private function get_rectStave():Rectangle {
		if (this.notevalue.stavingLevel == 0) return null;
		if (this.notetype != ENoteType.Normal) return null;
		
		if (this._rectStave != null) return this._rectStave;		
		
		var r = this.rectHeads.clone();		
		if (this.direction == EDirectionUD.Up) {
			r.x = Constants.HEAD_HALFWIDTH;
			
			r.width = Constants.STAVE_WIDTH;

			// 8ths and 16ths flags:
			if (this.flagCorrection == ERectCorrection.CorrectFlags) {
				//trace('Correct Flag');
				r.width += Constants.STAVE_FLAGCORRECTION;	
			}
			
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
		if (this.notetype != ENoteType.Normal) return null;
		
		if (this.notevalue.dotLevel == 0) return null;		
		
		var r = this.rectHeads.clone();		
		r.offset(r.width+ Constants.HEAD_QUARTERWIDTH, 0) ;
		r.width = Constants.HEAD_HALFWIDTH * this.notevalue.dotLevel + Constants.HEAD_QUARTERWIDTH;
		this._rectDots = r;
		return this._rectDots;
	}
	
	
	
	
	private var _rectTiesfrom:Rectangle;
	public var rectTiesfrom(get_rectTiesfrom, null):Rectangle;

	private function get_rectTiesfrom():Rectangle {
		if (this._rectTiesfrom != null) return this._rectTiesfrom;
		if (this.notetype != ENoteType.Normal) return null;
		
		this._rectTiesfrom = null;
		
		if (this.countTies() > 0) {
			var r = this.rectHeads.clone();
			r.offset(r.width + Constants.HEAD_QUARTERWIDTH, 0);
			r.width = Constants.TIE_WIDTH;
			if (this.rectDots != null) {
				r.offset(this.rectDots.width, 0);
			}
			this._rectTiesfrom = r;
		}
		
		return this._rectTiesfrom;
		
	}
	
}
