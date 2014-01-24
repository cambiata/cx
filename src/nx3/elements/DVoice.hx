package nx3.elements;
import nx3.elements.ConfigDVoice;
/**
 * ...
 * @author Jonas Nyström
 */

 using nx3.elements.EDirectionUAD.EDirectionUADTools;
 
class DVoice
{
	
	public var nvoice				(default, null)			: NVoice;
	public var config 			(default, null) 			: ConfigDVoice;
	public var dnotes			(default, null)			: Array<DNote>;
	//public var beamgroups	(default, default)			: Array<BItem>;
	
	
	public var type				(default, null)			: EVoiceType;
	public var direction			(default, null)			: EDirectionUAD;
	public var beaming			(default, null)			: Array<ENoteValue>;
	
	public function new(nvoice:NVoice, config:ConfigDVoice=null) 
	{
		this.nvoice = nvoice;	
		this.config = (config == null) ? ConfigDVoiceDefaults.getDefaults(): config;
		this.beaming = (this.config.beaming != null) ? this.config.beaming : [ENoteValue.Nv4];
		this.createChildren();
		
		/*
		this.direction = (direction == null) ? EDirectionUAD.Auto : direction;
		this.beamingProcessor = (beamingProcessor == null) ? new BProcessor_2Eights() : beamingProcessor ;
		this.dnotes = [];
		
		switch(this.voice.type) {
			case EVoiceType.Normal:
			//case EVoiceType.Barpause:
				//var emptyNoteLevel = this.voice.notes.first().heads.first().level;
				//var emptyNote:Note = new Note([new Head(emptyNoteLevel)], ENoteValue.Nv1, null, ENoteType.BarPause);
				//this.dnotes.push(new DNote(emptyNote, this.direction.toUD()));
			default:
				throw "Unimplemented Voicetype";
		}		
		
		
		this.prepareClassHelperStuff();
		this.doBeaming();
		//this._setConnectionPoints();		
		*/
	}
	
	public function createChildren()
	{
		this.dnotes = [];
		for (nnote in this.nvoice.notes)
		{
			this.dnotes.push(new DNote(nnote));
		}
		new GenerateBeaming(this,  this.beaming).execute();
	}
	
	
	
	
	public function dnote(idx:Int) return this.dnotes[idx];


	//public var dnotePosition(default, null):Map<DNote, Int>;
	//public var dnotePositionEnd(default, null):Map<DNote, Int>;
	public var dnoteBeamgroup(default, null):Map<DNote, BItem>;	
	//this.dnoteBeamgroup = new Map<DNote, BItem>();
	
	/*
	private function prepareClassHelperStuff()
	{
		this.dnotePosition = new Map<DNote, Int>();
		this.dnotePositionEnd = new Map<DNote, Int>();

		var pos = 0;
		for (dnote in this.dnotes)
		{
			this.dnotePosition.set(dnote, pos);
			this.dnotePositionEnd.set(dnote, pos + dnote.value.value);
			pos += dnote.value.value;
		}	
	}
	*/

	private var _dnotePosition : Map<DNote, Int>;
	private var _dnotePositionEnd: Map<DNote, Int>;
	public function getDNotePosition(dnote:DNote):Int
	{
		if (_dnotePosition != null ) return _dnotePosition.get(dnote);
		calcDnotePositions();
		return _dnotePosition.get(dnote);
	}
	
	public function getDNotePositionEnd(dnote:DNote):Int
	{
		if (_dnotePositionEnd != null ) return _dnotePositionEnd.get(dnote);
		calcDnotePositions();
		return _dnotePositionEnd.get(dnote);
	}
	
	private function calcDnotePositions()
	{
		this._dnotePosition = new Map<DNote, Int>();
		this._dnotePositionEnd = new Map<DNote, Int>();
		var pos = 0;
		for (dnote in this.dnotes)
		{
			this._dnotePosition.set(dnote, pos);
			this._dnotePositionEnd.set(dnote, pos + dnote.value.value);
			pos += dnote.value.value;
		}			
	}
	
	
	private var _value:Int = 0;
	public function getValue():Int
	{
		if (this._value > 0) return this._value;
		for (note in this.nvoice.notes) this._value += note.value.value;
		return this._value;
	}
	
	
	
	//---------------------------------------------------------------------------------------------------------------
	//---------------------------------------------------------------------------------------------------------------
	// beaming stuff...
	
	/*
	public function beamGroupsClear() 
	{
		this.beamGroups = [];
	}
	
	public function beamGroupsAdd(beamGroup:BItem) {
		this._beamGroups.push(beamGroup);
	}
	
	private var _beamGroups:BItems;
	private function get_beamGroups():BItems {
		return _beamGroups;
	}
	*/
	public var beamGroups(default, default):BItems;	
	
	
	private function _setConnectionPoints() 	{
		trace('_setConnectionPoints');
		
		for (beamGroup in this.beamGroups) {
			var noteIndex = 0;
			for (dnote in beamGroup.getNotes()) {
				if (beamGroup.count() == 1) {
					trace('single');
				} else {
					if (dnote == beamGroup.getFirstNote()) trace('multi first ' + beamGroup.getValuePosition(noteIndex) + ' ' + beamGroup.getValue())
					else if (dnote == beamGroup.getLastNote()) trace('multi last ' + beamGroup.getValuePosition(noteIndex))
					else trace('multi mid ' + beamGroup.getValuePosition(noteIndex));
				}
				noteIndex++;
			}
		}
	}	
}



