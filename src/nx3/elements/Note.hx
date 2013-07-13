package nx3.elements;
import nx.enums.ENoteType;
import nx3.elements.Head;
import nx3.enums.ENoteValue;
import nx3.enums.ENoteVariant;
import nx3.enums.ENoteType;

/**
 * ...
 * @author Jonas Nyström
 */
class Note
{
	//----------------------------------------------------------------------------------------
	// Constructor
	
	public function new(?type:ENoteType=null, ?value:ENoteValue=null, heads:Array<Head>=null ) 
	{
		if (type == null) 			type = ENoteType.Note(ENoteVariant.Normal);
		if (value == null)		value = ENoteValue.Nv4;
		this.heads_				= heads;
	}

	
	//----------------------------------------------------------------------------------------
	// Public
	
	public var heads(get, null):Array<Head>;
	
	//-----------------------------------------------------------------------------------------
	// Private
	
	var heads_:Array<Head>;
	private function get_heads():Array<Head> return this.heads_;
	
}