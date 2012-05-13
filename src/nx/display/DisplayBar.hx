package nx.display;
import cx.ObjectHash;
import cx.Tools;
import nx.Constants;
import nx.element.Bar;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;

/**
 * ...
 * @author Jonas Nyström
 */

interface IDisplayBar {	
	function getBar():Bar<Part<Voice<Note<Head<Dynamic>>>>>;	
	function getDisplayParts(index:Int):DisplayPart;
	function getDisplayPart(index:Int):DisplayPart;
	function getDisplayPartIndex(index:Int):DisplayPart;
	function getDisplayPartsCount(index:Int):DisplayPart;
	function getValue():Int;
}

using Lambda;

class DisplayBar {
	private var bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>;
	public function getBar():Bar<Part<Voice<Note<Head<Dynamic>>>>> {
		return bar;
	}
	
	private var displayParts:Array<DisplayPart>;
	public function new(bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>) {
		this.bar = bar;
		this.displayParts = new Array<DisplayPart>();
		for (child in bar.children) this.displayParts.push(new DisplayPart(child));
		
		this.displayNoteDisplayPart = new ObjectHash<DisplayPart>();
		this.displayNoteDisplayVocie = new ObjectHash<DisplayVoice>();
		
		for (dp in this.displayParts) {
			for (dv in dp.getDisplayVoices()) {
				for (dn in dv.getDisplayNotes()) {
					this.displayNoteDisplayPart.set(dn, dp);
					this.displayNoteDisplayVocie.set(dn, dv);
				}				
			}			
		}
		
		this.getValue();
	}
	
	public function getDisplayPart(index:Int):DisplayPart {
		return this.displayParts[index];
	}
	
	public function getDisplayParts():Array<DisplayPart> {
		return this.displayParts;
	}
	
	public function getDisplayPartIndex(dPart:DisplayPart): Int {
		return this.displayParts.indexOf(dPart);
	}
	
	public function getDisplayPartsCount():Int {
		return this.displayParts.length;
	}
	
	private var value:Int;	
	public function getValue():Int {
		if (this.value > 0) return this.value;
		var maxValue = 0.0;
		for (displayPart in this.getDisplayParts()) {
			maxValue = Math.max(displayPart.getValue(), maxValue);
		}
		return Std.int(maxValue);
	}
	
	
	private var displayNoteDisplayPart:ObjectHash<DisplayPart>;
	public function getDisplayNoteDisplayPart(displayNote:DisplayNote):DisplayPart {
		return this.displayNoteDisplayPart.get(displayNote);
	}
	
	private var displayNoteDisplayVocie:ObjectHash<DisplayVoice>;
	public function getDisplayNoteDisplayVoice(displayNote:DisplayNote):DisplayVoice {
		return this.displayNoteDisplayVocie.get(displayNote);
		
	}
	
	
	//-----------------------------------------------------------------------------------------------------
	
	private var displayNotePositionsArray:Array<Int>;
	public function getDisplayNotePositionsArray():Array<Int> {
		if (this.displayNotePositionsArray != null) return this.displayNotePositionsArray;
		var ret = new Array<Int>();
		for (dp in this.displayParts) {
			var pos = dp.getDisplayNotePositionsArray();	
			ret = ret.concat(pos);
		}
		this.displayNotePositionsArray = Tools.arrayIntUnique(ret);
		return this.displayNotePositionsArray ;
	}
	
	private var displayNoteValuesArray:Array<Int>;
	public function getDisplayNoteValuesArray():Array<Int> {
		if (displayNoteValuesArray == null) this.getDisplayNotePositionsArray();
		this.displayNoteValuesArray = new Array<Int>();
		var prevNp = 0;
		trace(this.displayNotePositionsArray);
		for (np in this.displayNotePositionsArray) {			
			if (np == 0) continue;
			var value = np - prevNp;			
			this.displayNoteValuesArray.push(value);
			prevNp = np;
		}
		return this.displayNoteValuesArray;
		
	}
	
	private var displayNoteXOwingArray:Array<Float>; 
	public function getDisplayNoteXOwingArray():Array<Float> {
		if (displayNoteXOwingArray == null) this.getDisplayNotePositionsXPositions();
		return this.displayNoteXOwingArray;
	}
	
	
	private var displayNotePositionsXPositions:IntHash<Float>;
	public function getDisplayNotePositionsXPositions():IntHash<Float> {
		if (this.displayNotePositionsXPositions != null) return this.displayNotePositionsXPositions;
		this.displayNotePositionsXPositions = new IntHash<Float>();
		this.displayNoteXOwingArray = new Array<Float>();
		
		var above:DisplayNote; 
		var posX = 0.0;
		for (pos in this.getDisplayNotePositionsArray()) {
			this.displayNotePositionsXPositions.set(pos, posX);
			posX += Constants.HEAD_WIDTH;
		}
		// END POSITION!:
		this.displayNotePositionsXPositions.set(this.getValue(), posX);
		trace(this.displayNotePositionsXPositions);
		for (part in this.getDisplayParts()) {			
			var partPosXPos = part.getDisplayNotePositionsXPositions();
		}
		
		var positions = this.getDisplayNotePositionsArray();
		positions.push(this.getValue());
		for (pos in positions) {
			var increaseDistance = 0.0;
			for (part in this.getDisplayParts()) {			
				if (part.getDisplayNotePositionsXPositions().exists(pos)) {
					var partPosX = part.getDisplayNotePositionsXPositions().get(pos);
					var defPosX = this.displayNotePositionsXPositions.get(pos);
					if (partPosX > defPosX) {
						increaseDistance = Math.max(increaseDistance, partPosX - defPosX);
					}
				}
			}
			
			if (increaseDistance > 0) {
				var posIdx = positions.indexOf(pos);
				for (j in posIdx...positions.length) {							
					var jPos = positions[j];
					this.displayNotePositionsXPositions.set(jPos, this.displayNotePositionsXPositions.get(jPos) + increaseDistance);
				}
			}
			
			this.displayNoteXOwingArray.push(increaseDistance);
		}
	
		this.endXPosition = this.displayNotePositionsXPositions.get(this.getValue());
		this.displayNoteXOwingArray.shift();
		return this.displayNotePositionsXPositions;
	}
	
	
	
	
	
	private var displayNoteXPositions: ObjectHash<Float>;
	
	public function getDisplayNoteXPostitions(): ObjectHash<Float> {
		if (this.displayNoteXPositions != null) return this.displayNoteXPositions;		
		this.displayNoteXPositions = new ObjectHash<Float>();
		
		var prevDn:DisplayNote = null;
		for (dp in this.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {				
				var pos = dp.getDisplayNotePosition(dn);
				var dv = dp.getDisplayNoteDisplayVoice(dn);
				var posX = this.getDisplayNotePositionsXPositions().get(pos) ;
				var distX = dp.getDisplayNoteAvoidVoiceXDistances().get(dn);
				this.displayNoteXPositions.set(dn, posX + distX);
			}
		}
		return this.displayNoteXPositions;
	}

	private var displayNoteSequence: Array<DisplayNote>;
	
	public function getDisplayNotesSequence():Array<DisplayNote> {
		if (this.displayNoteSequence != null) return this.displayNoteSequence;				
		this.displayNoteSequence = new Array<DisplayNote>();		
		this.displayNotePositions = new ObjectHash<Int>();
		for (pos in this.getDisplayNotePositionsArray()) {
			
			for (dp in this.getDisplayParts()) {				
				
				if (dp.getDisplayNotesMatrix().exists(pos)){
					for (dn in dp.getDisplayNotesMatrix().get(pos)) {
						this.displayNoteSequence.push(dn);
						this.displayNotePositions.set(dn, pos);
					}
				}
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
	
	
	private var displayNotePositions:ObjectHash<Int>;
	public function getDisplayNotePosition(displayNote:DisplayNote):Int {		
		if (this.displayNoteSequence == null) this.getDisplayNotesSequence();		
		return this.displayNotePositions.get(displayNote);
	}	
	
	
	private var endXPosition:Float;
	public function getEndXPosition():Float {
		if (this.endXPosition == null) this.getDisplayNotePositionsXPositions();
		return this.endXPosition;
	}
	
	
	
	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '..DisplayBar: ' + this.bar;
		for (displayPart in this.displayParts) r += '\n' + displayPart;
		return r;
	}
}