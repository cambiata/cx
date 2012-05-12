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
	
	//-----------------------------------------------------------------------------------------------------
	
	private var displayNotePositionsArray:Array<Int>;
	public function getDisplayNotePositionsArray():Array<Int> {
		if (this.displayNotePositionsArray != null) return this.displayNotePositionsArray;
		var ret = new Array<Int>();
		for (dp in this.displayParts) {
			var pos = dp.getDisplayNotePositionsArray();	
			ret = ret.concat(pos);
		}
		return Tools.arrayIntUnique(ret);
	}
	
	private var displayNotePositionsXPositions:IntHash<Float>;
	public function getDisplayNotePositionsXPositions():IntHash<Float> {
		if (this.displayNotePositionsXPositions != null) return this.displayNotePositionsXPositions;
		this.displayNotePositionsXPositions = new IntHash<Float>();
		
		var max = new IntHash<Float>();
		var posX = 0.0;
		for (pos in this.getDisplayNotePositionsArray()) {							
			
			// öka på med ett huvud per position...
			var distX:Float = Constants.HEAD_WIDTH;
			

			
			for (dp in this.getDisplayParts()) {
				if (dp.getDisplayNotesMatrix().exists(pos)) {
					var dns = dp.getDisplayNotesMatrix().get(pos);
					
					for (dn in dns) {
						
						var dv = dp.getDisplayNoteDisplayVoice(dn);
						var dvIdx = dp.getDisplayVoiceIndex(dv);
						var dnIdx = dv.getDisplayNoteIndex(dn);
						//trace([pos, dvIdx, dnIdx]);
						
						var prevDn = dp.getPrevDisplayNotesInSequence(dn);						
						if (prevDn != null) {							
							var dist2 = prevDn.getNoteDistanceX(dn, false);
							//trace('has prev in seq: ' + dist2);
							//distX = Math.max(distX, distX1);
							//if (dvIdx == 0) distX += dist2;
						}
						
						
						
					}
					//trace(dns.length);
				}
			}
			
			posX += distX;
			this.displayNotePositionsXPositions.set(pos, posX);
			

			
		}
		//trace(max);
		
		/*
		for (dp in this.getDisplayParts()) {
			var dpXPositions = dp.getDisplayNotePositionsXPositions();
			trace(dpXPositions);
		}
		
		
		var posMinus = new Array<Float>();
		for (dpIdx in 0...this.getDisplayPartsCount()) {
			posMinus[dpIdx] = 0.0; 
		}
		
		
		for (pos in this.getDisplayNotePositions()) {				
			var posMax:Float = null;			
			for (dp in this.getDisplayParts()) {
				var dpIdx = this.getDisplayPartIndex(dp);
				var posX = dp.getDisplayNotePositionsXPositions().get(pos);
				posMax = (posMax == null) ? posX : Math.max(posMax, posX);				
			}
			
			for (dp in this.getDisplayParts()) {
				var dpIdx = this.getDisplayPartIndex(dp);				
				if (dp.getDisplayNotePositionsXPositions().exists(pos)) {
					var posX = dp.getDisplayNotePositionsXPositions().get(pos);
					var pMinus = posMax - posX;
					posMinus[dpIdx] = posMinus[dpIdx] + pMinus;
					var newPos = posX + posMinus[dpIdx];
					this.displayNotePositionsXPositions.set(pos, newPos);
					continue;
				}
			}
		}
		*/

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
				//trace(posX);
				var avoidDistX = dp.getDisplayNoteAvoidVoiceXDistances().get(dn);
				//trace(avoidDistX);
				this.displayNoteXPositions.set(dn, posX + avoidDistX);
			}
		}
		return this.displayNoteXPositions;
	}
	
	
	private var displayNoteSequence: Array<DisplayNote>;
	public function getDisplayNotesSequence():Array<DisplayNote> {
		if (this.displayNoteSequence != null) return this.displayNoteSequence;		
		this.displayNoteSequence = new Array<DisplayNote>();
		this.dNotePositions = new ObjectHash<Int>();
		for (pos in this.getDisplayNotePositionsArray()) {
			for (dp in this.getDisplayParts()) {				
				
				if (dp.getDisplayNotesMatrix().exists(pos)){
					for (dn in dp.getDisplayNotesMatrix().get(pos)) {
						this.displayNoteSequence.push(dn);
						this.dNotePositions.set(dn, pos);
					}
				}
			}
		}
		
		return this.displayNoteSequence;
	}
	
	private var dNotePositions:ObjectHash<Int>;
	public function getDisplayNotePosition(displayNote:DisplayNote):Int {		
		if (this.displayNoteSequence == null) this.getDisplayNotesSequence();
		
		return this.dNotePositions.get(displayNote);
	}	
	
	
	
	//-----------------------------------------------------------------------------------
	public function toString() {
		var r:String = '..DisplayBar: ' + this.bar;
		for (displayPart in this.displayParts) r += '\n' + displayPart;
		return r;
	}
}