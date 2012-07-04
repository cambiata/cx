package nx.core.element;

/**
 * ...
 * @author Jonas Nyström
 */

class Part 
{
	public function new(voices:Array<Voice>) {
		this.voices = Lambda.array(voices);
	}
	
	public var voices(default, null):Array<Voice>;
}