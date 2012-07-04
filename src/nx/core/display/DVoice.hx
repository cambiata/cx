package nx.core.display;
import nx.core.element.Voice;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class DVoice 
{
	public var voice(default, null):Voice;
	public var dnotes(default, null):Array<DNote>;
	private var direction(default, null):EDirectionUAD;
	private var value(default, null):Int;

	public function new(voice:Voice, direction:EDirectionUAD=null) 
	{
			this.voice = voice;			
			
			if (direction == null) {
				this.direction = this.voice.direction;
			} else {
				this.direction = direction;				
			}
			
			this.dnotes = [];
			for (note in this.voice.notes) {
				this.dnotes.push(new DNote(note));
			}	
			
			this.value = 0;
			for (note in this.voice.notes) {
				trace(note.notevalue.value);
				this.value += note.notevalue.value;
			}
	}
	
}
