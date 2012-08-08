package nx.core.display;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Voice;
import nx.display.beam.BeamGroups;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.IBeamGroup;
import nx.display.beam.IBeamingProcessor;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.utils.EDirectionTools;
import nme.ObjectHash;

/**
 * ...
 * @author Jonas Nyström
 */

class DVoice 
{
	public var voice(default, null):Voice;
	public var dnotes(default, null):Array<DNote>;
	public function dnote(idx:Int) return this.dnotes[idx]
	public var direction(default, null):EDirectionUAD;
	public var value(default, null):Int;
	
	public var dnotePosition(default, null):ObjectHash<DNote, Int>;
	public var dnotePositionEnd(default, null):ObjectHash<DNote, Int>;
	

	

	public function new(voice:Voice=null, direction:EDirectionUAD=null, beamingProcessor:IBeamingProcessor=null) 
	{
			this.voice = (voice != null) ? voice : new Voice([
				new Note([new Head(0)]),
				new Note([new Head(2)]),
				new Note([new Head(-1)]),
				new Note([new Head(-0)]),
			]);
			
			this._beamingProcessor = (beamingProcessor != null) ? beamingProcessor : new BeamingProcessor_4();
			
			if (direction == null) {
				this.direction = this.voice.direction;
			} else {
				this.direction = direction;				
			}
			
			this.dnotes = [];
			for (note in this.voice.notes) {
				this.dnotes.push(new DNote(note, EDirectionTools.UADtoUD(this.direction)));
			}	
			
			this.dnotePosition = new ObjectHash<DNote, Int>();
			this.dnotePositionEnd = new ObjectHash<DNote, Int>();
			
			this.value = 0;
			for (dnote in this.dnotes) {				
				this.dnotePosition.set(dnote, value);
				this.value += dnote.notevalue.value;
				this.dnotePositionEnd.set(dnote, value);
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
	
	public function beamGroupsClear() {
		this._beamGroups = [];
	}
	public function beamGroupsAdd(beamGroup:IBeamGroup) {
		this._beamGroups.push(beamGroup);
	}
	private var _beamGroups:BeamGroups;
	private function get_beamGroups():BeamGroups {
		return _beamGroups;
	}
	public var beamGroups(get_beamGroups, null):BeamGroups;
	
	
	//------------------------------------------------------------------------------------------------
	
}

