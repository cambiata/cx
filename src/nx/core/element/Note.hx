package nx.core.element;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class Note  
{
	
	public function new(heads:Iterable<Head>=null, notevalue:ENoteValue=null) {
		this.heads = Lambda.array(heads);
		this._sortHeads();
		this.notevalue = (notevalue != null) ? notevalue : ENoteValue.Nv4;
	}

	//-----------------------------------------------------------------------------------------------------
	
	public var heads(default, null):Array<Head>;
	public var notevalue(default, null):ENoteValue;

	//-----------------------------------------------------------------------------------------------------
	
	private function _sortHeads()  {
		this.heads.sort(function(a, b) { return Reflect.compare(a.level, b.level); } );
	}
	
	
}
