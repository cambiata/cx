package nx.display.beam;

import nx.core.display.DNote;
import nx.core.display.DVoice;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nme.ObjectHash;
import nx.enums.ERectCorrection;
/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;

class BeamingProcessorBase {
	public var valuePattern:Array<ENoteValue>;
	public var dVoice:DVoice; 
	public var forceDirection:EDirectionUAD;
	private var patternValuePos:Array<Int>;
	private var patternValueEnd: Array<Int>;	
	
	public function beam(dVoice:DVoice, valuePattern:Array<ENoteValue>, ?forceDirection:EDirectionUAD=null) {
		this.valuePattern = valuePattern;
		this.dVoice = dVoice;
		this.forceDirection = forceDirection;
		
		this.clearBeamlist()
		.adjustPatternLength()
		.preparePatternCalculation()
		.createBeamGroups()
		.calcLevelWeight()
		.setGroupDirection()
		.setDisplayNoteDirections()		
		.setFlagCorrections()
		//.trBeamGroups()
		;
	}	
	
	
	private function clearBeamlist():BeamingProcessorBase { 
		//trace('clearBeamlist');
		//this.dVoice.setBeamGroups([]);
		this.dVoice.beamGroupsClear();
		return this;
	}	
	
	private function adjustPatternLength():BeamingProcessorBase { //(dVoice:DisplayVoice) {
		//trace('adjustPatternLength');
		var vpValue:Int = 0;
		for (value in valuePattern) vpValue += value.value;
		
		while (vpValue <= dVoice.value) {
			this.valuePattern = Lambda.array(Lambda.concat(this.valuePattern, this.valuePattern));
			vpValue = 0;
			for (value in valuePattern) vpValue += value.value;
			//trace([vpValue, dVoice.value]);
		}
		return this;
	}	
	
	private function preparePatternCalculation() {
		
		patternValuePos = [];
		patternValueEnd = [];		
		
		var vPos = 0;
		var i = 0;
		for (v in valuePattern) {			
			var vValue = v.value;
			var vEnd = vPos + vValue;
			patternValuePos.push(vPos);
			patternValueEnd.push(vEnd);			
			vPos = vEnd;
			i++;
		}
		
		return this;
	}	
	
	private function createBeamGroups() {
		
		var dnoteGroupIdx = new ObjectHash<DNote, Int>();
		
		for (dnote in dVoice.dnotes) {
			var dnotePos = dVoice.dnotePosition.get(dnote);
			var dnoteEnd = dVoice.dnotePositionEnd.get(dnote);
			
			var groupIdx = -111;
			if (dnote.notetype != ENoteType.Normal) {
				groupIdx = -2;
			} else if (dnote.notevalue.beamingLevel < 1) {
				groupIdx = -1;
			} else {
				groupIdx = _findBeamGroupIndex(dnotePos, dnoteEnd);				
			}			
			dnoteGroupIdx.set(dnote, groupIdx);			
		}

		var count = 0;
		var prevDnote:DNote = null;
		var arrDnote:Array<DNote> = [];
		var beamgroups:BeamGroups = [];
		
		for (dnote in dVoice.dnotes) {
			if (prevDnote == null) {
				arrDnote.push(dnote);
				prevDnote = dnote;				
				continue;
			}
			
			var prevIdx = dnoteGroupIdx.get(prevDnote);
			var groupIdx = dnoteGroupIdx.get(dnote);
			
			if ((prevIdx != groupIdx) || (prevIdx == -1)) {
				
				var newBeamGroup = _getBeamGroupFromArray(arrDnote);
				this.dVoice.beamGroups.push(newBeamGroup);
				count = 0;				
				arrDnote = [dnote];
			} else {
				count++;
				arrDnote.push(dnote);
			}
			prevDnote = dnote;
		}
		var newBeamGroup = _getBeamGroupFromArray(arrDnote);
		this.dVoice.beamGroups.push(newBeamGroup);
		
		//this.dVoice.beamGroups = beamgroups;
		
		trBeamGroups(beamgroups);
		return this;
	}	
	
	private function calcLevelWeight():BeamingProcessorBase { 
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BeamGroupSingle)) {
				bg.setLevelTop(bg.getFirstNote().levelTop);
				bg.setLevelBottom(bg.getFirstNote().levelBottom);
			} else {
				for (dNote in bg.getNotes()) {
					if (dNote == bg.getFirstNote()) {
						bg.setLevelTop(dNote.levelTop);
						bg.setLevelBottom(dNote.levelBottom);
					} else {
						bg.setLevelTop(Std.int(Math.min(bg.getLevelTop(), dNote.levelTop)));
						bg.setLevelBottom(Std.int(Math.max(bg.getLevelBottom(), dNote.levelBottom)));
					}
				}
			}
		}

		return this;
	}

	private function setGroupDirection():BeamingProcessorBase { 
		//trace('voice direction: ' + dVoice.voice.direction);
		//trace('force direction: ' + this.forceDirection);
		var useDirection:EDirectionUAD = (this.forceDirection != null) ? this.forceDirection : this.dVoice.direction;
		
		if (useDirection == null) useDirection = EDirectionUAD.Auto;
		//trace('use direction:  ' + useDirection);		
		for (bg in dVoice.beamGroups) {
			if (useDirection == EDirectionUAD.Auto) {
				var levelWeight = bg.getLevelTop() + bg.getLevelBottom();
				var levelWeightDirection:EDirectionUD = (levelWeight > 0) ? EDirectionUD.Up : EDirectionUD.Down;
				
				bg.setDirection(levelWeightDirection);
			} else {
				bg.setDirection(this.directionTranslate(useDirection));
			}
		}
		return this;
	}	
	
	private function directionTranslate(dirUAD:EDirectionUAD):EDirectionUD {
		if (dirUAD == EDirectionUAD.Up) return EDirectionUD.Up;
		return EDirectionUD.Down;
	}	
	
	private function setDisplayNoteDirections():BeamingProcessorBase {
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BeamGroupSingle)) {
				var dNote = bg.getFirstNote();
				//dNote.setDirection(bg.getDirection());
				dNote.direction = bg.getDirection();
			} else {
				for (dNote in bg.getNotes()) {
					//dNote.setDirection(bg.getDirection());
					dNote.direction = bg.getDirection();
				}
			}
		}		
		return this;
	}

	private function setFlagCorrections() {
		for (bg in dVoice.beamGroups) {
			if (!Std.is(bg, BeamGroupSingle)) continue;
			if (bg.getDirection() != EDirectionUD.Up) continue;
			
			var dNote:DNote = bg.getFirstNote();			
			if (dNote.notetype != ENoteType.Normal) continue;
			if (dNote.notevalue.beamingLevel < 1) continue;
			
			// Do the flag rect correction!
			dNote.setFlagCorrection(ERectCorrection.CorrectFlags);
			
			
			/*
			if (Std.is(bg, BeamGroupSingle)) {
				if (bg.getDirection() == EDirectionUD.Up) {
					var dNote:DNote = bg.getFirstNote();
					
					if (dNote.notevalue.beamingLevel >= 2) { // 8ths or 16ths
						trace('CORRECT');
						dNote.setFlagCorrection(ERectCorrection.CorrectFlags);
					}					
				}				
			}			
			*/
			
			
		}
	}
	


	
	private function _getBeamGroupFromArray(dnotes:Array<DNote>):IBeamGroup {
		var beamGroup:IBeamGroup = null;
		if (dnotes.length == 1) {
			beamGroup = new BeamGroupSingle(dnotes.first());			
			beamGroup.firstType = dnotes.first().notetype;
			beamGroup.firstNotevalue =  dnotes.first().notevalue;
			
		} else {
			beamGroup = new BeamGroupMulti(dnotes);			
			beamGroup.firstType = dnotes.first().notetype;
			beamGroup.firstNotevalue =  dnotes.first().notevalue;
		}		
		
		return beamGroup;
	}
	
	private function _findBeamGroupIndex(pos:Int, endPos:Int, countFrom:Int=0) {
		for (idx in countFrom...patternValuePos.length) {			
			if (pos >= patternValuePos[idx] && endPos <= patternValueEnd[idx]) {
				return idx;
			}
		}
		return -1;			
	}

	private function trBeamGroups(beamGroups:BeamGroups=null) {
		
		if (beamGroups == null) beamGroups = this.dVoice.beamGroups;
		
		for (beamGroup in beamGroups) {
			trace(beamGroup);				
		}
		return this;
	}	
	
	
	

}
