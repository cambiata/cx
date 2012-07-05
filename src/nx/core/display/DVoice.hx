package nx.core.display;
import nx.core.element.Voice;
import nx.display.beam.IBeamingProcessor;
import nx.enums.EDirectionUAD;
import nx.enums.utils.EDirectionTools;

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

	public function new(voice:Voice, direction:EDirectionUAD=null, beamingProcessor:IBeamingProcessor=null) 
	{
			this.voice = voice;		
			this._beamingProcessor = beamingProcessor;
			
			if (direction == null) {
				this.direction = this.voice.direction;
			} else {
				this.direction = direction;				
			}
			
			this.dnotes = [];
			for (note in this.voice.notes) {
				this.dnotes.push(new DNote(note, EDirectionTools.UADtoUD(this.direction)));
			}	
			
			this.value = 0;
			for (note in this.voice.notes) {
				this.value += note.notevalue.value;
			}
			
			this._adjustBeaming();
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	private var _beamingProcessor:IBeamingProcessor;
	private function _adjustBeaming()  {
		if (this._beamingProcessor != null) {			
			this._beamingProcessor.doBeaming(this, this.direction);
		}		
	}
	
}
