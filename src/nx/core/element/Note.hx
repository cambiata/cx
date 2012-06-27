package nx.core.element;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class Note 
{
	
	public function new(heads:Iterable<Head>=null, notevalue:ENoteValue=null) 
	{
		this._heads = Lambda.array(heads);
		this._sortHeads();
	}

	//-----------------------------------------------------------------------------------------------------
	
	private var _heads:Array<Head>;
	
	private function get_heads():Array<Head> 
	{
		return _heads;
	}
	
	public var heads(get_heads, null):Array<Head>;	
	
	
	//-----------------------------------------------------------------------------------------------------
	
	private function _sortHeads() 
	{
		this._heads.sort(function(a, b) { return Reflect.compare(a.level, b.level); } );
	}
	

	
}