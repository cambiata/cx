package nx.core.element;

/**
 * ...
 * @author Jonas Nyström
 */

class Part 
{
	public function new(voices:Iterable<Voice>=null) {
		this.voices = (voices != null) ? Lambda.array(voices) : [new Voice()];
	}
	
	public var voices(default, null):Array<Voice>;
}