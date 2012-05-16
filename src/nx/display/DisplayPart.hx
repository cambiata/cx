package nx.display;
import cx.ObjectHash;
import nx.Constants;
import nx.display.beam.BeamGroups;
import nx.display.beam.BeamGroupSingle;
import nx.display.beam.IBeamingProcessor;
import nx.element.Part;
import nx.element.Voice;
import nx.element.Note;
import nx.element.Head;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayPart {
	function getPart():Part<Voice<Note<Head<Dynamic>>>>;
	function getDisplayVoice(index:Int):DisplayVoice;
	function getDisplayVoices():Array<DisplayVoice>;
	function getDisplayVoiceIndex(displayVoice:DisplayVoice):Int;
	function getDisplayVoicesCount():Int;
	function getDisplayNotesMatrix():IntHash<Array<DisplayNote>>;
	function getDisplayNotesSequence():Array<DisplayNote>;
	function getPrevDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote;
	function getNextDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote;
	function getDisplayNoteDisplayVoice(displayNote:DisplayNote): DisplayVoice;
	function getDisplayNotePositionsXPositions():IntHash<Float>;
	function getValue():Int;
	function getDisplayNoteAvoidVoiceXDistances(): ObjectHash<Float>;
	function getDisplayNotePosition(displayNote:DisplayNote):Int;
	function getDisplayNotePositionsArray(): Array<Int>;
	function getDisplayNoteXDistances(): ObjectHash<Float>;
	
	function getBeamGroups(): BeamGroups;
}

using Lambda;
class DisplayPart implements IDisplayPart {
	private var part:Part<Voice<Note<Head<Dynamic>>>>;
	public function getPart():Part<Voice<Note<Head<Dynamic>>>> {
		return this.part;		
	}
	
	private var displayNoteMatrix: IntHash<Array<DisplayNote>>;
	private var displayVoices:Array<DisplayVoice>;
	
	private var dNotePositions:ObjectHash<Int>;
	public function getDisplayNotePosition(displayNote:DisplayNote):Int {
		return this.dNotePositions.get(displayNote);
	}	
	
	private var displayNotePositionsArray: Array<Int>;
	public function getDisplayNotePositionsArray(): Array<Int> {
		return this.displayNotePositionsArray;
	}	
	
	private var beaming:IBeamingProcessor;
	
	public function new(part:Part<Voice<Note<Head<Dynamic>>>>, beaming:IBeamingProcessor=null) {
		this.part = part;
		this.beaming = beaming;
		
		this.displayVoices = new Array<DisplayVoice>();		
		this.displayNoteMatrix = new IntHash<Array<DisplayNote>>(); 
		this.dNotePositions = new ObjectHash<Int>();
		this.displayNotePositionsArray = new Array<Int>();
		
		for (voice in part.children) {
			var displayVoice = new DisplayVoice(voice, voice.getDirection(), this.beaming);
			this.displayVoices.push(displayVoice);			
			for (displayNote in displayVoice.getDisplayNotes()) {
				var positionKey = displayVoice.getDisplayNotePosition(displayNote);
				if (!displayNoteMatrix.exists(positionKey)) displayNoteMatrix.set(positionKey, new Array<DisplayNote>());				
				displayNoteMatrix.get(positionKey).push(displayNote);	
				
				this.dNotePositions.set(displayNote, positionKey);
				
				if (!Lambda.has(this.displayNotePositionsArray, positionKey)) this.displayNotePositionsArray.push(positionKey);
			}			
		}
	}

	public function getDisplayVoice(index:Int):DisplayVoice {
		return this.displayVoices[index];
	}
	
	public function getDisplayVoices():Array<DisplayVoice> {
		return this.displayVoices;
	}
	
	public function getDisplayVoiceIndex(displayVoice:DisplayVoice):Int {
		return this.displayVoices.indexOf(displayVoice);
	}
	
	public function getDisplayVoicesCount():Int {
		return this.displayVoices.length;
	}	
	
	public function getDisplayNotesMatrix():IntHash<Array<DisplayNote>> {
		return this.displayNoteMatrix;
	}
	
	private var displayNoteSequence:Array<DisplayNote>;
	public function getDisplayNotesSequence():Array<DisplayNote> {
		if (this.displayNoteSequence != null) return this.displayNoteSequence;
		this.displayNoteSequence = new Array<DisplayNote>();
		
		var keys = Iterators.array(this.displayNoteMatrix.keys());
		keys.sort(function(a, b) { return Reflect.compare(a, b); } );
		for (key in keys) {
			var dna = this.displayNoteMatrix.get(key);
			for (dn in dna) {
				displayNoteSequence.push(dn);
			}
		}
		return this.displayNoteSequence;
	}

	public function getPrevDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote {
		if (this.displayNoteSequence == null) this.getDisplayNotesSequence();
		var idx = this.displayNoteSequence.indexOf(displayNote);
		if (idx > 0) return this.displayNoteSequence[idx - 1];
		return null;
	}
	public function getNextDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote {
		if (this.displayNoteSequence == null) this.getDisplayNotesSequence();
		var idx = this.displayNoteSequence.indexOf(displayNote);
		if (idx < this.displayNoteSequence.length) return this.displayNoteSequence[idx + 1];
		return null;
	}
	
	public function getDisplayNoteDisplayVoice(displayNote:DisplayNote): DisplayVoice {
		for (dv in this.getDisplayVoices()) {			
			if (Lambda.has(dv.getDisplayNotes(), displayNote)) return dv;			
		}		
		return null;
	}
	
	private var value:Int;
	public function getValue():Int {
		if (this.value > 0) return this.value;
		var maxValue = 0.0;
		for (displayVoice in this.getDisplayVoices()) {
			maxValue = Math.max(displayVoice.getValue(), maxValue);
		}
		return Std.int(maxValue);		
	}
	
	private var displayNoteAvoidVoiceXDistances: ObjectHash<Float>;
	public function getDisplayNoteAvoidVoiceXDistances(): ObjectHash<Float> {
		if (this.displayNoteAvoidVoiceXDistances != null) return this.displayNoteAvoidVoiceXDistances;
		this.getDisplayNoteXPostitions();
		return this.displayNoteAvoidVoiceXDistances;
	}	
	
	private var displayNoteXDistances: ObjectHash<Float>;
	public function getDisplayNoteXDistances(): ObjectHash<Float> {
		if (this.displayNoteXDistances != null) return this.displayNoteXDistances;
		this.getDisplayNoteXPostitions();
		return this.displayNoteXDistances;	
	}
	
	
	private var displayNoteXPostitions: ObjectHash<Float>;
	public function getDisplayNoteXPostitions(): ObjectHash<Float> {
		if (this.displayNoteXPostitions != null) return this.displayNoteXPostitions;		
		
		this.displayNoteXPostitions = new ObjectHash<Float>();
		this.displayNoteXDistances = new ObjectHash<Float>();
		this.displayNoteAvoidVoiceXDistances = new ObjectHash<Float>();
		
		var prevDn:DisplayNote = null;
		var xPos = 0.0;
		var xAvoid = 0.0;
		for (dn in this.getDisplayNotesSequence()) {			
			prevDn = this.getPrevDisplayNotesInSequence(dn);
			if (prevDn != null) {
				var xDistance:Float = 0.0;
				if (this.getDisplayNotePosition(dn) != this.getDisplayNotePosition(prevDn)) {										
					xDistance = prevDn.getNoteDistanceX(dn, true);
					if (this.getDisplayNoteDisplayVoice(dn) != this.getDisplayNoteDisplayVoice(prevDn)) {
						var v = getDisplayNoteDisplayVoice(dn);
						var prevDnSameVoice = v.getPrevDisplayNote(dn);
						var xDistance2 = prevDnSameVoice.getNoteDistanceX(dn);
						xDistance = Math.max(xDistance, xDistance2);						
					}
					this.displayNoteAvoidVoiceXDistances.set(dn, 0.0);					
					xPos += xDistance;
					xAvoid = 0.0;
				} else {
					// Same voice, avoid collision!
					xDistance = prevDn.getNoteDistanceX(dn, false);
					xAvoid = xDistance;
					xPos += xDistance;
				}				
				
				this.displayNoteXPostitions.set(dn, xPos);
				this.displayNoteXDistances.set(dn, xDistance);
				this.displayNoteAvoidVoiceXDistances.set(dn, xAvoid);
			} else {
				this.displayNoteXPostitions.set(dn, 0.0);
				this.displayNoteXDistances.set(dn, 0.0);
				this.displayNoteAvoidVoiceXDistances.set(dn, 0.0);
			}
		}		
		return this.displayNoteXPostitions;
	}
	
	private var displayNotePositionsXPositions:IntHash<Float>;
	public function getDisplayNotePositionsXPositions():IntHash<Float> {
		if (this.displayNotePositionsXPositions != null) return this.displayNotePositionsXPositions;
		this.displayNotePositionsXPositions = new IntHash<Float>();
		var dnPosX:Float = 0;
		for (dn in this.getDisplayNotesSequence()) {
			dnPosX = this.getDisplayNoteXPostitions().get(dn);
			var pos = this.getDisplayNotePosition(dn);			
			if (!this.displayNotePositionsXPositions.exists(pos)) this.displayNotePositionsXPositions.set(pos, dnPosX);
		}				
		//displayNotePositionsXPositions.set(this.getValue(), dnPosX + Constants.HEAD_WIDTH);
		return this.displayNotePositionsXPositions;
	}
	
	private var beamGroups:BeamGroups;
	public function getBeamGroups(): BeamGroups {
		if (this.beamGroups != null) return this.beamGroups;
		this.beamGroups = new BeamGroups();
		for (dv in this.getDisplayVoices()) {
			this.beamGroups = this.beamGroups.concat(dv.getBeamGroups());			
		}
		//trace(this.beamGroups.length);
		return this.beamGroups;
	}
	
	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '...DisplayPart: ' + this.part;
		for (child in this.displayVoices) r += '\n' + child;
		return r;
	}
}

