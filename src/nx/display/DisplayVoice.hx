package nx.display;
import cx.ObjectHash;
import nx.display.beam.BeamTools;
import nx.display.beam.IBeamingProcessor;
import nx.element.Head;
import nx.element.Note;
import nx.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.utils.EDirectionTools;
import nx.display.beam.IBeamGroup;

/**
 * ...
 * @author Jonas Nyström
 */
 
interface IDisplayVoice {
	function getVoice():Voice<Note<Head<Dynamic>>>;
	function getDirection():EDirectionUAD;
	function getValue():Int;	
	function getDisplayNotes():Array<DisplayNote>;	
	function getDisplayNote(index:Int):DisplayNote;
	function getDisplayNoteFromPosition(position:Int):DisplayNote;
	function getDisplayNoteIndex(displayNote:DisplayNote):Int;
	function getDisplayNotesCount():Int;	
	function getDisplayNotePosition(displayNote:DisplayNote):Int;
	function getDisplayNotePostionEnd(displayNote:DisplayNote):Int;
	function getDisplayNoteValue(displayNote:DisplayNote):Int;
	function getDisplayNotePositions():Array<Int>;
	function getDisplayNoteEnds():Array<Int>;
	function getNextDisplayNote(displayNote:DisplayNote):DisplayNote;
	function getPrevDisplayNote(displayNote:DisplayNote):DisplayNote;
}
 
class DisplayVoice implements IDisplayVoice
{
	public function new(voice:Voice<Note<Head<Dynamic>>>, ?direction:EDirectionUAD, ?beamingProcessor:IBeamingProcessor) {
		this.voice = voice;
		
		if (direction != null) voice.setDirection(direction);
		if (beamingProcessor != null) this.beamingProcessor = beamingProcessor;
		
		this.displayNotes = new Array<DisplayNote>();
		
		this.dNotePositions = new ObjectHash<Int>();
		this.dNotePositionEnds = new ObjectHash<Int>();
		this.dNoteValues = new ObjectHash<Int>();
		this.positionDNotes = new IntHash<DisplayNote>();		
		
		
		//----------------------------------------
		var pos = 0;
		for (child in voice.children) {
			var dNote = new DisplayNote(child, nx.enums.utils.EDirectionTools.UADtoUD(voice.getDirection()));
			this.displayNotes.push(dNote);
			
			this.dNoteValues.set(dNote, child.value.value);
			this.dNotePositions.set(dNote, pos);
			this.positionDNotes.set(pos, dNote);
			this.dNotePositionEnds.set(dNote, child.value.value + pos);
			pos += child.value.value;
		}
		this.value = pos;	
		
		//------------------------------------------
		// should be last, for updating everything...
		this.setDirection(direction);
	}
	
	private var voice:Voice<Note<Head<Dynamic>>>;
	public function getVoice():Voice<Note<Head<Dynamic>>> {
		return this.voice;
	}
	
	private var direction:EDirectionUAD;
	public function getDirection():EDirectionUAD {
		return direction;
	}
	
	public function setDirection(direction:EDirectionUAD) {
		this.voice.setDirection(direction);
		this.direction = direction;
		//trace(this.beamingProcessor);		
		if (this.beamingProcessor != null) {
			//trace('do beaming' + this.direction);
			this.beamingProcessor.doBeaming(this, this.direction);
		}
	
		return this;
	}
	
	private var displayNotes: Array<DisplayNote>;
	public function getDisplayNotes():Array<DisplayNote> {
		return this.displayNotes;
	}
	
	private var value:Int;
	public function getValue():Int {
		return value;
	}
	
	
	private var beamingProcessor:IBeamingProcessor;
	public function setBeamingProcessor(beamingProcessor:IBeamingProcessor) {
		this.beamingProcessor = beamingProcessor;
		return this;
	}
	
	private var beamlist:Array<IBeamGroup>;
	public function getBeamlist():Array<IBeamGroup> {
		return this.beamlist;
	}
	public function setBeamlist(beamlist:Array<IBeamGroup>) {
		this.beamlist = beamlist;
		return this;
	}
	
	public function getDisplayNote(index:Int):DisplayNote {
		return this.displayNotes[index];
	}
	
	public function getDisplayNoteIndex(displayNote:DisplayNote):Int {
		return Lambda.indexOf(this.displayNotes, displayNote);
	}
	
	public function getNextDisplayNote(displayNote:DisplayNote):DisplayNote {
		var i = getDisplayNoteIndex(displayNote);
		if (i >= getDisplayNotesCount()) return null;
		return getDisplayNote(i + 1);
	}	
	
	public function getPrevDisplayNote(displayNote:DisplayNote):DisplayNote {
		var i = getDisplayNoteIndex(displayNote);
		if (i == 0) return null;
		return getDisplayNote(i - 1);
	}
	
	public function getDisplayNotesCount():Int {
		return this.displayNotes.length;
	}

	private var dNotePositions:ObjectHash<Int>;
	public function getDisplayNotePosition(displayNote:DisplayNote):Int {
		return this.dNotePositions.get(displayNote);
	}
	
	private var dNotePositionEnds:ObjectHash<Int>;
	public function getDisplayNotePostionEnd(displayNote:DisplayNote):Int {
		return this.dNotePositionEnds.get(displayNote);
	}	
	
	
	private var dNoteValues:ObjectHash<Int>;
	public function getDisplayNoteValue(displayNote:DisplayNote):Int {
		return this.dNoteValues.get(displayNote);
	}
	
	public function getDisplayNotePositions():Array<Int> {
		var a = Lambda.array(this.dNotePositionEnds);
		a.sort(function(a, b) {return Reflect.compare(a, b);}) ;
		return a;		
	}
	
	public function getDisplayNoteEnds():Array<Int> {
		var a = Lambda.array(this.dNotePositionEnds);
		a.sort(function(a, b) {return Reflect.compare(a, b);}) ;
		return a;		
	}
	
	public function getDisplayNoteFromPosition(position:Int):DisplayNote {
		return this.positionDNotes.get(position);
	}	
	
	private var positionDNotes:IntHash<DisplayNote>;
		
	//------------------------------------------------------------------------------------------
	
	
}