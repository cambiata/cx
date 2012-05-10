package nx.display;
import cx.ObjectHash;
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
	
	function getValue():Int;
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
	
	
	public function new(part:Part<Voice<Note<Head<Dynamic>>>>) {
		this.part = part;
		
		this.displayVoices = new Array<DisplayVoice>();		
		this.displayNoteMatrix = new IntHash<Array<DisplayNote>>(); 
		this.dNotePositions = new ObjectHash<Int>();
		
		for (voice in part.children) {
			var displayVoice = new DisplayVoice(voice);
			this.displayVoices.push(displayVoice);			
			for (displayNote in displayVoice.getDisplayNotes()) {
				var positionKey = displayVoice.getDisplayNotePosition(displayNote);
				if (!displayNoteMatrix.exists(positionKey)) displayNoteMatrix.set(positionKey, new Array<DisplayNote>());				
				displayNoteMatrix.get(positionKey).push(displayNote);	
				
				this.dNotePositions.set(displayNote, positionKey);
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
		var idx = this.displayNoteSequence.indexOf(displayNote);
		if (idx > 0) return this.displayNoteSequence[idx - 1];
		return null;
	}
	public function getNextDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote {
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
	
	private var displayNoteXPostitions: ObjectHash<Float>;
	public function getDisplayNoteXPostitions(): ObjectHash<Float> {
		if (this.displayNoteXPostitions != null) return this.displayNoteXPostitions;
		this.displayNoteXPostitions = new ObjectHash<Float>();
		var prevDn:DisplayNote = null;
		var xPos = 0.0;
		for (dn in this.getDisplayNotesSequence()) {			
			prevDn = this.getPrevDisplayNotesInSequence(dn);
			if (prevDn != null) {
				var distance:Float = 0.0;
				if (this.getDisplayNotePosition(dn) != this.getDisplayNotePosition(prevDn)) {										
					distance = prevDn.getNoteDistanceX(dn, true);
					if (this.getDisplayNoteDisplayVoice(dn) != this.getDisplayNoteDisplayVoice(prevDn)) {
						var v = getDisplayNoteDisplayVoice(dn);
						var prevDnSameVoice = v.getPrevDisplayNote(dn);
						var distance2 = prevDnSameVoice.getNoteDistanceX(dn);
						distance = Math.max(distance, distance2);
					}
					xPos += distance;
				} else {
					distance = prevDn.getNoteDistanceX(dn, false);
					xPos += distance;
				}
				this.displayNoteXPostitions.set(dn, xPos);
			} else {
				displayNoteXPostitions.set(dn, 0.0);
			}
		}		
		return this.displayNoteXPostitions;
	}
	
	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '...DisplayPart: ' + this.part;
		for (child in this.displayVoices) r += '\n' + child;
		return r;
	}
}

