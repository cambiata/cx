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
	public var direction(default, null):EDirectionUAD;
	public var heads(get, null):Array<NHead>;	
	
	public function new(?type:ENoteType=null, ?heads:Array<NHead>=null, ?value:ENoteValue=null , ?direction:EDirectionUAD=null) 
	{
		if (type == null) 
		{
			type = (heads != null) ? ENoteType.Note(heads) :  ENoteType.Note([new NHead()]);
		}
		
		this.type = (type == null) ? ENoteType.Note(heads) : type;
		this.value = (value == null) ? ENoteValue.Nv4 : value;
		this.direction = (direction == null) ? EDirectionUAD.Auto : direction;
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