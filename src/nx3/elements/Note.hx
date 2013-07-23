package nx3.elements;
import jasononeil.CleverSort;
import nx3.elements.Head;
import nx3.enums.EDirectionUD;
import nx3.enums.ENoteArticulation;
import nx3.enums.ENoteAttributes;
import nx3.enums.ENoteValue;
import nx3.enums.ENoteVariant;
import nx3.enums.ENoteType;
import nx3.enums.tools.ENoteTypeTools;

/**
 * ...
 * @author Jonas Nyström
 */
using jasononeil.CleverSort;
 
class Note
{
	public var type(default, default):ENoteType;
	public var value(default, default): ENoteValue;
	public var direction(default, default):EDirectionUD;
	
	//----------------------------------------------------------------------------------------
	// Constructor	
	public function new(?type:ENoteType=null, ?value:ENoteValue=null , ?direction:EDirectionUD=null, ?heads:Array<Head>=null) 
	{
		if (type == null) 
		{
			type = (heads != null) ? ENoteType.Note(heads) :  ENoteType.Note([new Head()]);
		}
		
		if (value == null) value = ENoteValue.Nv4;		
		
		this.type = type;
		this.value = value;
		this.direction = direction;
		ENoteTypeTools.noteSortHeads(this.type);
	}
	
	//----------------------------------------------------------------------------------------
	// Public
	
	public var heads(get, null):Array<Head>;
	private var heads_:Array<Head>;
	private function get_heads():Array<Head> 
	{
		if (this.heads_ != null) return this.heads_;		
		switch(this.type) 
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				this.heads_ = heads;
				return this.heads_;
			default:
		}
		return null;
	}
	
}