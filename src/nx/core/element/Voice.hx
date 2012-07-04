package nx.core.element;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class Voice 
{
	public function new(notes:Iterable<Note>=null, direction:EDirectionUAD=null)  {
		this.notes = Lambda.array(notes);
		this.direction = direction;
	}

	public var notes(default, null):Array<Note>;
	public var direction(default, null):EDirectionUAD;
}