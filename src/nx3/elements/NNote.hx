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
	public var nheads(get, null):Array<NHead>;	
	
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
	
	var nheads_:Array<NHead>;
	function get_nheads():Array<NHead> 
	{
		if (this.nheads_ != null) return this.nheads_;		
		switch(this.type) 
		{
			case ENoteType.Note(nheads, variant, articulations, attributes):
				nheads.cleverSort(_.level);
				this.nheads_ = nheads;
				return this.nheads_;
			default:
		}
		return null;
	}
	
	var headLevels:Array<Int>;
	public function getHeadLevels():Array<Int>
	{
		if (headLevels != null) return this.headLevels;
		this.headLevels = [];
		for (head in this.nheads) this.headLevels.push(head.level);
		return this.headLevels;
	}
	
	
	public function getTopLevel():Int
	{
		return this.nheads[0].level;
	}
	
	public function getBottomLevel():Int
	{
		return this.nheads[this.nheads.length-1].level;
	}
}