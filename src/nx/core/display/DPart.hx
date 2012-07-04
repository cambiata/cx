package nx.core.display;
import nx.core.element.Part;

/**
 * ...
 * @author Jonas Nyström
 */

class DPart 
{

	public function new(part:Part) {
		this.part = part;
		for (voice in this.part.voices) {
			for (note in voice.notes) {
				trace(note.notevalue.value);
			}			
		}		
	}
	
	public var part(default, null):Part;
	
}