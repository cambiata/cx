package nx.core.element;
import nx.core.element.Part;

/**
 * ...
 * @author Jonas Nyström
 */

class Bar 
{
	public var parts(default, null):Array<Part>;

	public function new(parts:Iterable<Part>=null) {
		this.parts = (parts != null) ? Lambda.array(parts) : [new Part()];
	}
	
}