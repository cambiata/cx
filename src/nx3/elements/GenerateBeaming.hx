package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
 

 class GenerateBeaming
{
	var dVoice:DVoice;
	var valuePattern:Array<ENoteValue>;
	var forceDirection :EDirectionUAD;
	
	//var beamgroups:Array<BItem>;
	
	
	public function new(dvoice:DVoice, pattern: Array<ENoteValue>, forceDirection:EDirectionUAD = null) 
	{
		this.dVoice = dvoice;
		this.valuePattern = pattern;
		this.forceDirection = forceDirection;
	}
	
	public function execute()
	{
		this.clearBeamlist()
		.adjustPatternLength()
		.preparePatternCalculation()
		.createBeamGroups()
		.calcLevelWeight()
		.setGroupDirection()
		.setDisplayNoteDirections()		
		.setFlagCorrections()		
		;
	}
	
	private function clearBeamlist() { 
		this.dVoice.beamGroups = [];
		return this;
	}	
	
	private function adjustPatternLength()
	{  
		//trace('adjustPatternLength');
		var vpValue:Int = 0;
		for (value in this.valuePattern) vpValue += value.value;
		
		while (vpValue < dVoice.getValue()) 
		{
			this.valuePattern = Lambda.array(Lambda.concat(this.valuePattern, this.valuePattern));
			vpValue = 0;
			for (value in valuePattern) vpValue += value.value;
			//trace([vpValue, dVoice.value]);
		}
		
		return this;
	}	
	
	
	var patternValuePos:Array<Int>;
	var patternValueEnd: Array<Int>;
	
	private function preparePatternCalculation() 
	{
		
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
	
	private function createBeamGroups() 
	{
		
		var dnoteGroupIdx = new Map<DNote, Int>();
		
		for (dnote in dVoice.dnotes) 
		{
			var dnotePos = dVoice.getDNotePosition(dnote);
			var dnoteEnd = dVoice.getDNotePositionEnd(dnote);
			
			var groupIdx = -111;

			switch (dnote.type)
			{
				case ENoteType.Note(heads, variant, articulations, attributes):
						if (dnote.value.beamingLevel < 1) 
						{
							groupIdx = -1;
						}
						else 
						{
							groupIdx = _findBeamGroupIndex(dnotePos, dnoteEnd);
						}
				default:
					groupIdx = -2;
			}
			
			dnoteGroupIdx.set(dnote, groupIdx);			
		}

		var count = 0;
		var prevDnote:DNote = null;
		var arrDnote:Array<DNote> = [];
		var beamgroups:BItems = [];
		
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
	
	private function calcLevelWeight() { 
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BSingle)) {
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

	private function setGroupDirection()
	{ 
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
	
	private function setDisplayNoteDirections() {
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BSingle)) {
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

	private function setFlagCorrections() 
	{
		for (bg in dVoice.beamGroups) {
			if (!Std.is(bg, BSingle)) continue;
			if (bg.getDirection() != EDirectionUD.Up) continue;
			
			var dNote:DNote = bg.getFirstNote();			
			//if (dNote.type != ENoteType.Normal) continue;
			switch(dNote.type)
			{
				case ENoteType.Note(heads, variant, articulations, attributes):
					continue;
				default: 
					//
			}
			
			if (dNote.value.beamingLevel < 1) continue;
			
			// Do the flag rect correction!
			
			trace('TODO!'); // dNote.setFlagCorrection(ERectCorrection.CorrectFlags);
			
			
			
			// if (Std.is(bg, BeamGroupSingle)) {
			// 	if (bg.getDirection() == EDirectionUD.Up) {
			// 		var dNote:DNote = bg.getFirstNote();
			// 		
			// 		if (dNote.notevalue.beamingLevel >= 2) { // 8ths or 16ths
			// 			trace('CORRECT');
			// 			dNote.setFlagCorrection(ERectCorrection.CorrectFlags);
			// 		}					
			// 	}				
			// }			
			
		}
	}
	

	private function _getBeamGroupFromArray(dnotes:Array<DNote>):BItem {
		var beamGroup:BItem = null;
		if (dnotes.length == 1) {
			beamGroup = new BSingle(dnotes.first());			
			beamGroup.firstType = dnotes.first().type;
			beamGroup.firstNotevalue =  dnotes.first().value;
			
		} else {
			beamGroup = new BGroup(dnotes);			
			beamGroup.firstType = dnotes.first().type;
			beamGroup.firstNotevalue =  dnotes.first().value;
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
	
	private function trBeamGroups(beamGroups:BItems=null) {
		
		if (beamGroups == null) beamGroups = this.dVoice.beamGroups;
		
		for (beamGroup in beamGroups) {
			trace(beamGroup);				
		}
		return this;
	}		
	
	/*
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
	*/
	
	
	
}