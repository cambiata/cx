package nx3.elements;

import nx3.geom.Rectangle;
import nx3.elements.tools.HeadsTool;
import nx3.elements.tools.HeadTool;

/**
 * ...
 * @author 
 */

using nx3.elements.EDirectionUD.EDirectionUDTools;
using nx3.elements.EDirectionUAD.EDirectionUADTools;
 
class DNote
{
	var note:NNote;
	//public var heads(default, null):Array<Head>;
	public var type(default, null):ENoteType;
	public var variant(default, null):ENotationVariant;
	public var articulations(default, null):Array<ENoteArticulation>;
	public var attributes(default, null):Array<ENoteAttributes>;
	
	private var forceDirection:EDirectionUD;
	public var direction(get, set):EDirectionUD;

	public var levelTop(default, null):Int;
	public var levelBottom(default, null):Int;	
	public var value(default, null):ENoteValue;	
	
	public function new(note:NNote, ?variant:ENotationVariant, ?articulations: Array<ENoteArticulation>, ?attributes:Array<ENoteAttributes>, ?forceDirection:EDirectionUD)
	{
		this.note = note;		
		this.variant = (variant == null) ? ENotationVariant.Normal : variant;
		this.articulations = (articulations == null) ? [] : articulations;
		this.attributes = (attributes == null) ? [] : attributes;
		this.forceDirection = forceDirection; // Can be null!?

		this.levelTop = this.note.nheads[0].level;
		this.levelBottom = this.note.nheads[this.note.nheads.length - 1].level;		
		this.value = this.note.value;		
		this.type = this.note.type;
	}
	
	private var direction_:EDirectionUD;
	private function get_direction():EDirectionUD
	{
		if (direction_ != null) return direction_;
		if (forceDirection != null)
		{
			direction_ =  forceDirection;			
		}
		else
		{
			direction_ = (note.direction != null) ? note.direction.toUD() : HeadsTool.getDirection(note.nheads);
		}		
		return direction_;
	}
	
	private function set_direction(val:EDirectionUD):EDirectionUD
	{
		this.direction_ = val;
		//trace('set dnote direction to ' + Std.string(val));
		return this.direction_;
	}
	
	public var stemX(get, null):Null<Float>;
	var stemX_:Null<Float>;
	function get_stemX():Null<Float>
	{
		if (this.stemX_ !=null) return this.stemX_;
		
		this.stemX_ = Constants.NOTE_STEM_X_NORMAL;
		
		if (this.direction == EDirectionUD.Down) 
		{
			this.stemX_ = -this.stemX_;
		}
		
		return this.stemX_;
	}
	
	//-------------------------------------------------------------------------------
	
	var headRects_:Array<Rectangle> = null;
	public var headRects(get, null):Array<Rectangle>;
	private function  get_headRects():Array<Rectangle>
	{		
		if (this.headRects_ != null) return this.headRects_;
		this.headRects_ = [];
		var headPositions:Array<Int> = HeadsTool.getHeadPositions(this.note.nheads, this.direction);
		var i = 0;
		for (head in note.nheads)
		{			
			var rect:Rectangle = HeadTool.getHeadRect(head, this.note.value);
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
		this.midLevel_ =  HeadsTool.midLevel(this.note.nheads);		
		return this.midLevel_;
	}
	
	//-------------------------------------------------------------------------------------------------------------------
	
	var heads_: Array<NHead>;
	public var heads(get, null):Array<NHead>;
	private function get_heads():Array<NHead>
	{
		if (this.heads_ != null) return this.heads_;		
		this.heads_ = this.note.nheads;
		return this.heads_;
	}
	
	public var headTop(get, null):NHead;
	function get_headTop():NHead
	{
		if (this.heads_ != null) return this.heads_[0];
		return this.heads[0];
	}

	private var headBottom_:NHead;
	public var headBottom(get, null):NHead;
	function get_headBottom():NHead
	{
		if (this.headBottom_ != null) return this.headBottom_;
		this.headBottom_ = this.heads[this.heads.length -1];
		return this.headBottom_;
	}
	
	//--------------------------------------------------------------------------------------------------------------------

	var headsRect_: Rectangle;
	
	public var headsRect (get, null): Rectangle;
	private function get_headsRect():Rectangle
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
	
	var xAdjust_:Float = 0;
	public var xAdjust(get, set):Float;
	private function get_xAdjust():Float
	{
		return this.xAdjust_;
	}
	
	private function set_xAdjust(val:Float):Float
	{
		return this.xAdjust_ = val;
	}

	
	//------------------------------------------------------
	
	public function reset()
	{
		this.headRects_ = null;
		this.headsRect_ = null;
	}	
	
}