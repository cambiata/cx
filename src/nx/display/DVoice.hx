package nx.display;
import nme.geom.Rectangle;
import nx.display.beam.BeamingProcessor_4dot;
import nx.element.Head;
import nx.element.Note;
import nx.element.Voice;
import nx.display.beam.BeamGroups;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.IBeamGroup;
import nx.display.beam.IBeamingProcessor;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.EVoiceType;
import nx.enums.utils.EDirectionTools;
import nme.ObjectHash;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
class DVoice 
{
	public var voice(default, null):Voice;
	public var dnotes(default, null):Array<DNote>;
	public function dnote(idx:Int) return this.dnotes[idx]
	public var direction(default, null):EDirectionUAD;
	public var value(default, null):Int;
	
	public var dnotePosition(default, null):ObjectHash<DNote, Int>;
	public var dnotePositionEnd(default, null):ObjectHash<DNote, Int>;
	public var dnoteBeamgroup(default, null):ObjectHash<DNote, IBeamGroup>;

	

	public function new(voice:Voice=null, direction:EDirectionUAD=null, beamingProcessor:IBeamingProcessor=null) 
	{
		this.voice = (voice != null) ? voice : new Voice([new Note([new Head(0)])]);
		this._beamingProcessor = (beamingProcessor != null) ? beamingProcessor : new BeamingProcessor_4();
		if (direction == null) {
			this.direction = this.voice.direction;
		} else {
			this.direction = direction;				
		}
		this.dnotes = [];
		switch(this.voice.type) {
			case EVoiceType.Normal:
				for (note in this.voice.notes) {
					this.dnotes.push(new DNote(note, EDirectionTools.UADtoUD(this.direction)));
				}	
			case EVoiceType.Barpause:
				var emptyNoteLevel = this.voice.notes.first().heads.first().level;
				var emptyNote:Note = new Note([new Head(emptyNoteLevel)], ENoteValue.Nv1, null, ENoteType.BarPause);
				this.dnotes.push(new DNote(emptyNote, EDirectionTools.UADtoUD(this.direction)));
			default:
				throw "Unimplemented Voicetype";
		}
		this.dnotePosition = new ObjectHash<DNote, Int>();
		this.dnotePositionEnd = new ObjectHash<DNote, Int>();
		this.dnoteBeamgroup = new ObjectHash<DNote, IBeamGroup>();
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
	
	private var _heightRect:Rectangle;
	public var heightRect(get_heightRect, null):Rectangle;
	private function get_heightRect():Rectangle 
	{
		if (this._heightRect != null) return this._heightRect;
		
		var lowest = 0.0;
		var highest = 0.0;
		
		for (beamGroup in this.beamGroups) {
			if (beamGroup.getDirection() == EDirectionUD.Up) {
				highest = Math.min(highest, beamGroup.getLevelTop() - Constants.STAVE_LENGTH);
				lowest = Math.max(lowest, beamGroup.getLevelBottom());
			} else {
				highest = Math.min(highest, beamGroup.getLevelTop());
				lowest = Math.max(lowest, beamGroup.getLevelBottom() + Constants.STAVE_LENGTH);			
			}			
		}		
		this._heightRect = new Rectangle( -1, highest, 2, -highest + lowest);
		trace(this._heightRect);
		return this._heightRect;
	}
	
	
	
	
}

