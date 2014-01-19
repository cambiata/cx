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
	public var beamgroups	(default, null)			: Array<BItem>;
	
	
	public var direction			(default, null)			: EDirectionUAD;
	public var beaming			(default, null)			: BProcessor;
	
	public function new(voice:NVoice, config:ConfigDVoice) 
	{
		this.nvoice = voice;	
		
		this.config = (config == null) ? ConfigDVoiceDefaults.getDefaults();
		
		this.type = config.type;
		this.direction = config.direction;
		this.beaming = config.beaming;
		
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
		
		this.beamgroups = new GenerateBeaming(this.dnotes, [ENoteValue.Nv4]).execute();
		
	}
	
	
	
	
	public function dnote(idx:Int) return this.dnotes[idx];
	public var sumNoteValue(default, null):Int;

	public var dnotePosition(default, null):Map<DNote, Int>;
	public var dnotePositionEnd(default, null):Map<DNote, Int>;
	public var dnoteBeamgroup(default, null):Map<DNote, BItem>;	
	
	
	private function prepareClassHelperStuff()
	{
		this.dnotePosition = new Map<DNote, Int>();
		this.dnotePositionEnd = new Map<DNote, Int>();
		this.dnoteBeamgroup = new Map<DNote, BItem>();		

		var sum = 0;
		for (note in this.nvoice.notes) 
		{
			this.dnotes.push(new DNote(note, this.direction.toUD()));
			sum += note.value.value;
		}	
		this.sumNoteValue = sum;

		var pos = 0;
		for (dnote in this.dnotes)
		{
			this.dnotePosition.set(dnote, pos);
			this.dnotePositionEnd.set(dnote, pos + dnote.value.value);
			pos += dnote.value.value;
		}	
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//---------------------------------------------------------------------------------------------------------------
	// beaming stuff...
	
	private var beamingProcessor:BProcessor;
	private function doBeaming()  
	{
		if (this.beamingProcessor != null) 
		{			
			this.beamingProcessor.doBeaming(this, this.direction);
		}		
	}	
	
	public function beamGroupsClear() 
	{
		this._beamGroups = [];
	}
	
	public function beamGroupsAdd(beamGroup:BItem) {
		this._beamGroups.push(beamGroup);
	}
	
	private var _beamGroups:BItems;
	private function get_beamGroups():BItems {
		return _beamGroups;
	}
	public var beamGroups(get_beamGroups, null):BItems;	
	
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



