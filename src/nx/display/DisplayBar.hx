package nx.display;
import cx.ObjectHash;
import cx.Tools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.display.beam.IBeamingProcessor;
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
	function getDisplayParts():Array<DisplayPart>;
	function getDisplayPart(index:Int):DisplayPart;
	function getDisplayPartIndex(displayPart:DisplayPart):Int;
	function getDisplayPartsCount():Int;
	function getValue():Int;
	
	function getDisplayNoteDisplayPart(displayNote:DisplayNote):DisplayPart;
	function getDisplayNoteDisplayVoice(displayNote:DisplayNote):DisplayVoice;
	function getDisplayNotePosition(displayNote:DisplayNote):Int;
	function getDisplayNotePositionsXPositions():IntHash<Float>;
	function getValuesArray():Array<Int>;
	function getExcessArray():Array<Float>;	
	function getPositionsArray():Array<Int>;
	function getDisplayNoteXPostitions(): ObjectHash<Float>;
	function getDisplayNotesSequence():Array<DisplayNote>;
	function getPrevDisplayNotesInSequence(displayNote:DisplayNote):DisplayNote;
	function getEndXPosition():Float;
}

using Lambda;

class DisplayBar implements IDisplayBar {
	private var bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>;
	public function getBar():Bar<Part<Voice<Note<Head<Dynamic>>>>> {
		return bar;
	}
	
	private var displayParts:Array<DisplayPart>;
	
	private var beaming:IBeamingProcessor;
	
	public function new(bar:Bar<Part<Voice<Note<Head<Dynamic>>>>>, beaming:IBeamingProcessor=null) {
		this.bar = bar;
		this.beaming = beaming;
		this.displayParts = new Array<DisplayPart>();
		for (child in bar.children) this.displayParts.push(new DisplayPart(child, beaming));
		
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
	
	public function getDisplayPartIndex(displayPart:DisplayPart): Int {
		return this.displayParts.indexOf(displayPart);
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
	
	private var positionsArray:Array<Int>;
	public function getPositionsArray():Array<Int> {
		if (this.positionsArray != null) return this.positionsArray;
		var ret = new Array<Int>();
		for (dp in this.displayParts) {
			var pos = dp.getDisplayNotePositionsArray();	
			ret = ret.concat(pos);
		}
		this.positionsArray = Tools.arrayIntUnique(ret);
		return this.positionsArray ;
	}
	
	private var valuesArray:Array<Int>;
	public function getValuesArray():Array<Int> {
		if (valuesArray == null) this.getPositionsArray();
		this.valuesArray = new Array<Int>();
		var prevNp = 0;
		//trace(this.positionsArray);
		for (np in this.positionsArray) {			
			if (np == 0) continue;
			var value = np - prevNp;			
			this.valuesArray.push(value);
			prevNp = np;
		}
		return this.valuesArray;
		
	}
	
	private var excessArray:Array<Float>; 
	public function getExcessArray():Array<Float> {
		if (excessArray == null) this.getDisplayNotePositionsXPositions();
		return this.excessArray;
	}
	
	private var widthArray:Array<Float>; 
	public function getWidthArray():Array<Float> {
		if (this.widthArray == null) this.getDisplayNotePositionsXPositions();
		return this.widthArray;
	}
	
	
	private var displayNotePositionsXPositions:IntHash<Float>;
	public function getDisplayNotePositionsXPositions():IntHash<Float> {
		if (this.displayNotePositionsXPositions != null) return this.displayNotePositionsXPositions;
		this.displayNotePositionsXPositions = new IntHash<Float>();
		
		this.widthArray = new Array<Float>();
		this.excessArray = new Array<Float>();
		
		var above:DisplayNote; 
		var posX = 0.0;
		for (pos in this.getPositionsArray()) {
			this.displayNotePositionsXPositions.set(pos, posX);
			posX += Constants.HEAD_WIDTH;
		}
		
		// END POSITION!:
		this.displayNotePositionsXPositions.set(this.getValue(), posX);
		//trace(this.displayNotePositionsXPositions);
		for (part in this.getDisplayParts()) {			
			var partPosXPos = part.getDisplayNotePositionsXPositions();
		}
		
		var positions = this.getPositionsArray();
		

		
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
			
			this.excessArray.push(increaseDistance);
			this.widthArray.push(Constants.HEAD_WIDTH + increaseDistance);
		}
	
		this.endXPosition = this.displayNotePositionsXPositions.get(this.getValue());
		this.excessArray.shift();
		this.widthArray.shift();
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
		for (pos in this.getPositionsArray()) {
			
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
	
	private var firstNoteLeftWidth:Float;
	public function getFirstNoteLeftWidth():Float {
		if (this.firstNoteLeftWidth != null) return firstNoteLeftWidth;		
		var r:Rectangle = null;		
		var pos = 0;
		for (dp in this.getDisplayParts()) {		
			if (dp.getDisplayNotesMatrix().exists(pos)) {
				for (dn in dp.getDisplayNotesMatrix().get(pos)) {
					trace(dn.getTotalRect());
					r = (r == null) ? dn.getTotalRect() : r.union(dn.getTotalRect());
				}
			}			
		}
		this.firstNoteLeftWidth = -r.x;
		return this.firstNoteLeftWidth;
	}
	
	private var lastNoteRightWidth:Float;
	public function getLastNoteRightWidth():Float {
		if (this.lastNoteRightWidth != null) return lastNoteRightWidth;		
		var r:Rectangle = null;		
		var pos = this.getPositionsArray()[this.getPositionsArray().length - 2];
		trace(pos);
		for (dp in this.getDisplayParts()) {		
			if (dp.getDisplayNotesMatrix().exists(pos)) {
				for (dn in dp.getDisplayNotesMatrix().get(pos)) {
					//trace(dn.getTotalRect());
					r = (r == null) ? dn.getTotalRect() : r.union(dn.getTotalRect());
				}
			}			
		}
		this.lastNoteRightWidth = r.x + r.width;
		return this.lastNoteRightWidth;				
	}
	
	public function getContentWidth():Float {
		return this.getFirstNoteLeftWidth() + this.getEndXPosition() + this.getLastNoteRightWidth();		
	}
	
	
	//-----------------------------------------------------------------------------------------------------
	
	
	
	
	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '..DisplayBar: ' + this.bar;
		for (displayPart in this.displayParts) r += '\n' + displayPart;
		return r;
	}
}