package nx3.display.calc;

import nx3.display.IDNoteRects;
import nx3.display.tools.HeadsTool;
import nx3.display.tools.HeadTool;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.enums.EDirectionUD;
import nx3.enums.ENoteArticulation;
import nx3.enums.ENoteAttributes;
import nx3.enums.ENoteValue;
import nx3.enums.ENoteVariant;
import nx3.enums.tools.EDirectionTools;
import nx3.units.Level;
import nx3.units.NRect;
import nx3.units.NX;

/**
 * ...
 * @author 
 */
class DNoteCalc implements IDNoteRects
{
	var note:Note;
	//public var heads(default, null):Array<Head>;
	public var variant(default, null):ENoteVariant;
	public var articulations(default, null):Array<ENoteArticulation>;
	public var attributes(default, null):Array<ENoteAttributes>;
	
	private var forceDirection:EDirectionUD;
	public var direction(get, null):EDirectionUD;
	public  var value(get, null):ENoteValue;
	
	public function new(note:Note, variant:ENoteVariant, articulations: Array<ENoteArticulation>, attributes:Array<ENoteAttributes>, forceDirection:EDirectionUD)
	{
		this.note = note;		
		this.variant = variant;
		this.articulations = articulations;
		this.attributes = attributes;
		this.forceDirection = forceDirection;
		this.rectsBack;		
	}
	
	private var direction_:EDirectionUD;
	private function get_direction():EDirectionUD
	{
		if (direction_ != null) return direction_;
		if (forceDirection != null)
		{
			direction_ = forceDirection;			
		}
		else
		{
			direction_ = (note.direction != null) ? note.direction : HeadsTool.getDirection(note.heads);
		}		
		return direction_;
	}
	
	public var rectsFront(get, null): Array<NRect>;
	public var rectsBack(get, null): Array<NRect>;

	private function get_rectsFront():Array<NRect>
	{
		return null;
	}
	
	private var rectsBack_:Array<NRect>;
	private function get_rectsBack():Array<NRect>
	{
		this.headRects;		
		return null;
	}		
	
	//-------------------------------------------------------------------------------
	
	var headRects_:Array<NRect> = null;
	public var headRects(get, null):Array<NRect>;
	private function  get_headRects():Array<NRect>
	{		
		if (this.headRects_ != null) return this.headRects_;
		this.headRects_ = [];
		var headPositions:Array<Int> = HeadsTool.getHeadPositions(this.note.heads, this.direction);
		var i = 0;
		for (head in note.heads)
		{			
			var rect:NRect = HeadTool.getHeadRect(head, this.note.value);
			rect.offset(rect.width * headPositions[i], 0);
			this.headRects_.push(rect);	
			i++;
		}
		return this.headRects_;
	}

	public var midLevel(get, null):Float;
	private var midLevel_:Null<Float>;
	private function get_midLevel():Float
	{
		if (this.midLevel_ != null) return this.midLevel_;
		this.midLevel_ =  HeadsTool.midLevel(this.note.heads);		
		return this.midLevel_;
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	var heads_: Array<Head>;
	public var heads(get, null):Array<Head>;
	private function get_heads():Array<Head>
	{
		if (this.heads_ != null) return this.heads_;		
		this.heads_ = this.note.heads;
		return this.heads_;
	}
	
	public var headTop(get, null):Head;
	function get_headTop():Head
	{
		if (this.heads_ != null) return this.heads_[0];
		return this.heads[0];
	}

	private var headBottom_:Head;
	public var headBottom(get, null):Head;
	function get_headBottom():Head
	{
		if (this.headBottom_ != null) return this.headBottom_;
		this.headBottom_ = this.heads[this.heads.length -1];
		return this.headBottom_;
	}
	
	//--------------------------------------------------------------------------------------------------------------------

	var headsRect_: NRect;
	
	public var headsRect (get, null): NRect;
	private function get_headsRect():NRect
	{
		if (this.headsRect_ != null) return this.headsRect_;		
		this.headsRect_ = this.headRects[0];			
		if (this.heads.length > 1) 
		{
			for (i in 1...this.heads.length)
			{
				this.headsRect_ = this.headsRect_.union(this.headRects[i]);
			}
		} 		
		return this.headsRect_;		
	}
	
	//------------------------------------------------------------------------------------------------------------------------
	
	var xAdjust_:NX = 0;
	public var xAdjust(get, set):NX;
	private function get_xAdjust():NX
	{
		return this.xAdjust_;
	}
	
	private function set_xAdjust(val:NX):NX
	{
		return this.xAdjust_ = val;
	}
	
	private function get_value():ENoteValue
	{
		return this.note.value;
	}
}