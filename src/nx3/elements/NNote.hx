package nx3.elements;
import jasononeil.CleverSort;

import nx3.elements.tools.ENoteTypeTools;


/**
 * ...
 * @author Jonas Nyström
 */
using jasononeil.CleverSort;
 
class NNote
{
	
	public var type(default, null):ENoteType;
	public var value(default, null): ENoteValue;
	public var direction(default, null):EDirectionUD;
	public var heads(get, null):Array<NHead>;	
	
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
	}
	
	var heads_:Array<NHead>;
	function get_heads():Array<NHead> 
	{
		if (this.heads_ != null) return this.heads_;		
		switch(this.type) 
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				heads.cleverSort(_.level);
				this.heads_ = heads;
				return this.heads_;
			default:
		}
		return null;
	}
	
}