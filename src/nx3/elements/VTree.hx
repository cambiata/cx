package nx3.elements;
import nx3.elements.VTree.VBeamframe;
import nx3.elements.VTree.VBeamgroup;
import nx3.elements.VTree.VBeamgroupDirectionCalculator;
import nx3.elements.VTree.VBeamgroupFrameCalculator;
import nx3.elements.VTree.VCreateBeamgroups;
import nx3.test.TestV;

/**
 * ...
 * @author Jonas Nyström
 */

class VTree { } // Just the module name...

 class VBar
 {
	 public var nbar(default, null):NBar;
	 public function new(nbar:NBar) this.nbar = nbar;
	 
	 var vparts:Array<VPart>;
	 public function getVParts():Array<VPart>
	 {
		 if (this.vparts != null) return this.vparts;
		 this.vparts = [];
		 for (npart in this.nbar.parts)  this.vparts.push(new VPart(npart));
		 return this.vparts;
	 }	 
 }
 
class VPart
{
	public var npart(default, null):NPart;
	public function new(npart:NPart) this.npart = npart;
	
	var vvoices:Array<VVoice>;
	public function getVVoices(): Array<VVoice>
	{
		if (this.vvoices != null) return this.vvoices;
		this.vvoices = [];
		for (nvoice in this.npart.voices) this.vvoices.push(new VVoice(nvoice));
		return this.vvoices;
	}
}

class VVoice 
{
	public var nvoice(default, null):NVoice;
	public function new(nvoice:NVoice) this.nvoice = nvoice;

	var vnotes:Array<VNote> ;	
	public function getVNotes(): Array<VNote>
	{
		if (this.vnotes != null) return this.vnotes;
		this.vnotes = [];
		for (nnote in this.nvoice.notes) 
		{
			this.vnotes.push(new VNote(nnote));
		}
		return this.vnotes;
	}
	
	var vnotePositions:Map<VNote, Int>;
	public function getVNotePosition(vnote:VNote):Int
	{
		if (this.vnotePositions != null) return this.vnotePositions.get(vnote);
		if (this.vnotes == null) this.getVNotes();
		
		this.vnotePositions = new Map<VNote, Int>();
		
		var pos = 0;
		for (vnote in this.vnotes) 
		{
			this.vnotePositions.set(vnote, pos);
			pos += vnote.nnote.value.value;
		}
		return this.vnotePositions.get(vnote);
	}
	
	var value:Null<Int>;
	public function getValue():Int
	{
		if (this.value != null) return this.value;
		if (this.vnotes == null) this.getVNotes();
		this.value = 0;
		for (vnote in this.vnotes) this.value += vnote.nnote.value.value;
		return this.value;
	}
	
	var beamgroups:Array<VBeamgroup>;
	var beampattern: Array<ENoteValue>;
	public function getBeamgroups(pattern:Array<ENoteValue>=null):Array<VBeamgroup>
	{
		// if new pattern, recreate beamgroups
		if (pattern != beampattern) this.beamgroups = null;
		
		if (this.beamgroups != null) return this.beamgroups;
		
		this.beamgroups = new VCreateBeamgroups(this.getVNotes(), pattern).getBeamgroups();
		
		return this.beamgroups;
	}
}

class VNote
{
	public var nnote(default, null):NNote;
	public function new(nnote:NNote) this.nnote = nnote;
	
	var vheads:Array<VHead>;
	public function getVHeads():Array<VHead>
	{
		if (this.vheads != null) return this.vheads;
		this.vheads = [];
		for (nhead in this.nnote.heads) this.vheads.push(new VHead(nhead));
		return this.vheads;
	}
}

class VHead
 {
	 public var nhead(default, null):NHead;
	 public function new (nhead:NHead) this.nhead = nhead;
 }
 
 //------------------------------------------------------------------------------------------------------------
 
typedef VBeamframe = {
	leftOuterY:Int,
	leftInnerY:Int,
	rightOuterY:Int,
	rightInnerY:Int,
}
 
 class VBeamgroup
 {
	 public var vnotes(default, null):Array<VNote>;
	 public function new(vnotes:Array<VNote>)
	 {
		 this.vnotes = vnotes;
	 }
	 
	 var direction:EDirectionUD;
	 public function getDirection():EDirectionUD
	 {
		 if (this.direction != null) return this.direction;
		 this.direction = new VBeamgroupDirectionCalculator(this).getDirection();
		 return this.direction;
	 }
	 public function setDirection(val:EDirectionUD)
	 {
		 return this.direction = val;
	 }
	 
	 
	 var calculator :VBeamgroupFrameCalculator;
	 var frame:VBeamframe;
	 public function getFrame():VBeamframe
	 {
		 if (this.frame != null) return this.frame;
		 if (this.direction == null) this.getDirection();
		
		 this.calculator = new VBeamgroupFrameCalculator(this);
		 this.frame = calculator.getFrame();
		 
		 return this.frame;
		 
		 
	 }
	 
	 
 }
 
 class VBeamgroupFrameCalculator
 {
	 var beamgroup:VBeamgroup;
	 public function new(beamgroup:VBeamgroup)
	 {
		this.beamgroup = beamgroup;
	 }

	 var outerLevels:Array<Int>;
	 var innerLevels:Array<Int>;
	 
	 public function getFrame():VBeamframe
	 { 
		calcLevelArrays();
		var frame:VBeamframe = calcFramePrototype();
		 return frame;
	 }
	 
	 function calcFramePrototype() :VBeamframe
	 {
		 // TODO!
		 var count = this.innerLevels.length;
		return {
			leftInnerY : this.innerLevels[0],
			leftOuterY : this.outerLevels[0],
			rightInnerY : this.innerLevels[count - 1],
			rightOuterY : this.outerLevels[count - 1],
		}
	 }

	 function getTopLevels():Array<Int>
	 {
		 var levels:Array<Int> = [];
		 for (vnote in this.beamgroup.vnotes) levels.push(vnote.nnote.getTopLevel());
		 return levels;
	 }
	 
	 function getBottomLevels():Array<Int>
	 {
		 var levels:Array<Int> = [];
		 for (vnote in this.beamgroup.vnotes) levels.push(vnote.nnote.getBottomLevel());
		 return levels;		 
	 }
	 
	 function calcLevelArrays()
	 {
		 if (this.beamgroup.getDirection() == EDirectionUD.Up)
		 {
			 this.outerLevels = getTopLevels();
			 this.innerLevels = getBottomLevels();
		 } 
		 else
		 {
			 this.outerLevels = getBottomLevels();
			 this.innerLevels = getTopLevels();
		 }
	 }
	 
 }
 
 class VBeamgroupDirectionCalculator
 {
	 var beamgroup:VBeamgroup;
	 public function new(beamgroup:VBeamgroup)
	 {
		this.beamgroup = beamgroup;
	 }
	 
	 public function getDirection():EDirectionUD
	 {
		 this.topLevel = findTopLevel();
		 this.bottomLevel = findBottomLevel();
		 if (this.topLevel + this.bottomLevel <= 0) return EDirectionUD.Down;
		 return return EDirectionUD.Up;
	 }
	 
	 
	 var topLevel:Int;
	 function findTopLevel()
	 {
		var topLevel = this.beamgroup.vnotes[0].nnote.getTopLevel();
		if (this.beamgroup.vnotes.length == 1) return topLevel;
		for (i in 1...this.beamgroup.vnotes.length)
		{
			var level = this.beamgroup.vnotes[i].nnote.getTopLevel();
			topLevel = Std.int(Math.min(topLevel, level));
		}
		return topLevel;
	 }
	 
	 var bottomLevel:Int;
	 function findBottomLevel()
	 {
		 var bottomLevel = this.beamgroup.vnotes[0].nnote.getBottomLevel();
		if (this.beamgroup.vnotes.length == 1) return bottomLevel;
		for (i in 1...this.beamgroup.vnotes.length)
		{
			var level = this.beamgroup.vnotes[i].nnote.getBottomLevel();
			bottomLevel = Std.int(Math.max(bottomLevel, level));
		}
		return bottomLevel;
	 }
 }
 
 
 class VCreateBeamgroups 
 {
	 var vnotes:Array<VNote>;
	 var pattern: Array<ENoteValue>;
	 
	 public function new (vnotes:Array<VNote>, pattern:Array<ENoteValue>=null)
	 {
		 if (pattern == null) pattern = [ENoteValue.Nv4];

		 this.vnotes = vnotes;
		this.pattern = pattern;
		this.adjustPatternLenght();
	 }

	 var beamgropus:Array<VBeamgroup>;
	 public function getBeamgroups():Array<VBeamgroup>
	 {
		this.preparePatternCalculation();
		this.preparePositionMaps();
		this.createBeamGroups();
		return this.beamgropus;
	 }
	 
	 //------------------------------------------------------------------
	 
	 private function adjustPatternLenght()
	 {
		 var notesValue = 0;
		 for (vnote in vnotes) notesValue += vnote.nnote.value.value;
		 
		 var patternValue = 0;
		 for (value in pattern) patternValue += value.value;
		 
		 while (patternValue < notesValue)
		 {
			 this.pattern = this.pattern.concat(this.pattern);
			 patternValue *= 2;
		 }
		 
	 }
	 
	var patternValuePos:Array<Int>;
	var patternValueEnd: Array<Int>;	
	private function preparePatternCalculation() 
	{
		patternValuePos = [];
		patternValueEnd = [];			
		var vPos = 0;
		var i = 0;
		for (v in this.pattern) {			
			var vValue = v.value;
			var vEnd = vPos + vValue;
			patternValuePos.push(vPos);
			patternValueEnd.push(vEnd);			
			vPos = vEnd;
			i++;
		}		
		return this;
	}		 
	
	
	var vnotePosition: Map<VNote, Int>;
	var vnotePositionEnd: Map<VNote, Int>;
	private function preparePositionMaps()
	{
		this.vnotePosition = new Map<VNote, Int>();
		this.vnotePositionEnd = new Map<VNote, Int>();
		var pos = 0;
		for (vnote in this.vnotes)
		{
			this.vnotePosition.set(vnote, pos);
			var endpos = pos + vnote.nnote.value.value;
			this.vnotePositionEnd.set(vnote, pos + vnote.nnote.value.value);
			pos = endpos;
		}			
	}
	
	private function createBeamGroups() 
	{
		this.beamgropus = [];
		var vnoteGroupIdx = new Map<VNote, Int>();	
		
		for (vnote in this.vnotes)
		{
			var vnotePos = vnotePosition.get(vnote);
			var vnoteEnd = vnotePositionEnd.get(vnote);
			var groupIdx = -111;
		
			switch (vnote.nnote.type)
			{
				case ENoteType.Note(heads, variant, articulations, attributes):
					
						if (vnote.nnote.value.beamingLevel < 1) 
						{
							groupIdx = -1;
						}
						else 
						{
							groupIdx = findBeamGroupIndex(vnotePos, vnoteEnd);
						}
				default:
					groupIdx = -2;
			}
			
			vnoteGroupIdx.set(vnote, groupIdx);
		}

		var count = 0;
		var prevVNote:VNote = null;
		var arrVNote:Array<VNote> = [];
		
		for (vnote in vnotes)
		{
			if (prevVNote == null)
			{
				arrVNote.push(vnote);
				prevVNote = vnote;
				continue;
			}

			//---------------------------------------------
			var prevIdx = vnoteGroupIdx.get(prevVNote);
			var groupIdx = vnoteGroupIdx.get(vnote);

			if ((prevIdx != groupIdx) || (prevIdx == -1)) {
				
				var newBeamGroup = new VBeamgroup(arrVNote);
				
				//this.dVoice.beamGroups.push(newBeamGroup);
				this.beamgropus.push(newBeamGroup);
				count = 0;				
				arrVNote = [vnote];
			} else {
				count++;
				arrVNote.push(vnote);
			}
			prevVNote = vnote;
		}

		var newBeamGroup = new VBeamgroup(arrVNote);
		this.beamgropus.push(newBeamGroup);
	}	
	
	private function findBeamGroupIndex(pos:Int, endPos:Int, countFrom:Int = 0) 
	{
		for (idx in countFrom...this.patternValuePos.length) {			
			if (pos >= patternValuePos[idx] && endPos <= patternValueEnd[idx]) {
				return idx;
			}
		}
		return -1;			
	}	
	

	
	
	 
 }
