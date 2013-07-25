package nx3.elements;
import jasononeil.CleverSort;
import nx3.elements.NHead;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteArticulation;
import nx3.elements.ENoteAttributes;
import nx3.elements.ENoteValue;
import nx3.elements.ENoteVariant;
import nx3.elements.ENoteType;
import nx3.elements.tools.ENoteTypeTools;

/**
 * ...
 * @author Jonas Nyström
 */
using jasononeil.CleverSort;
 
class NNote
{
	public var type(default, default):ENoteType;
	public var value(default, default): ENoteValue;
	public var direction(default, default):EDirectionUD;
	
	//----------------------------------------------------------------------------------------
	// Constructor	
	public function new(?type:ENoteType=null, ?heads:Array<NHead>=null, ?value:ENoteValue=null , ?direction:EDirectionUD=null) 
	{
		if (type == null) 
		{
			type = (heads != null) ? ENoteType.Note(heads) :  ENoteType.Note([new NHead()]);
		}
		
		if (value == null) value = ENoteValue.Nv4;		
		
		this.type = type;
		this.value = value;
		this.direction = direction;
		ENoteTypeTools.noteSortHeads(this.type);
	}
	
	//----------------------------------------------------------------------------------------
	// Public
	
	public var heads(get, null):Array<NHead>;
	private var heads_:Array<NHead>;
	private function get_heads():Array<NHead> 
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