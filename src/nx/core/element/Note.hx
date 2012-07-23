za	package nx.core.element;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class Note  
{

	public function new(heads:Iterable<Head>=null, notevalue:ENoteValue=null, direction:EDirectionUAD=null) {
		this.heads = Lambda.array(heads);
		this.notevalue = (notevalue != null) ? notevalue : ENoteValue.Nv4;
		this.direction = (direction != null) ? direction : EDirectionUAD.Auto;

		this._sortHeads();
	}

	//-----------------------------------------------------------------------------------------------------
	
	public var heads(default, null):Array<Head>;
	public var notevalue(default, null):ENoteValue;
	public var direction(default, null):EDirectionUAD;

	//-----------------------------------------------------------------------------------------------------
	
	private function _sortHeads()  {
		this.heads.sort(function(a, b) { return Reflect.compare(a.level, b.level); } );
	}
	
}
