package nx3.elements;
import haxe.ds.IntMap.IntMap;
import nx3.elements.VTree.VBeamframe;
import nx3.elements.VTree.VBeamgroup;
import nx3.elements.VTree.VBeamgroupDirectionCalculator;
import nx3.elements.VTree.VBeamgroupFrameCalculator;
import nx3.elements.VTree.VColumns;
import nx3.elements.VTree.VComplex;
import nx3.elements.VTree.VComplexes;
import nx3.elements.VTree.VComplexSignsCalculator;
import nx3.elements.VTree.VCreateBeamgroups;

using nx3.elements.VTree.VMapTools;
/**
 * ...
 * @author Jonas Nyström
 */

class VTree { } // Just the module name...

typedef VBars = Array<VBar>;

 class VBar
 {
	 public var nbar(default, null):NBar;
	 public function new(nbar:NBar) this.nbar = nbar;
	 
	 var vparts:VParts;
	 public function getVParts():VParts
	 {
		 if (this.vparts != null) return this.vparts;
		 this.vparts = [];
		 for (npart in this.nbar.nparts)  this.vparts.push(new VPart(npart));
		 return this.vparts;
	 }	 
	 
	 public function getVColumns():VColumns
	 {
		 return null;
	 }
 }
 
 class VBarColumnsGenerator 
 {
	 var vparts:VParts;
	 public function new(vparts:VParts) 
	 { 
		this.vparts = vparts;
	 }
	 
	 var positions:Array<Int>;
	 var columns:VColumns;
	 public function getColumns():VColumns
	 {
		this.positions =  calcPositions(this.vparts);
		this.columns = calcColumns(this.positions, this.vparts);
		return this.columns;
	 }
	 
	 function calcColumns(positions:Array<Int>, vparts:VParts)
	 {
		 var partsCount = vparts.length;
		 var vcolumns:VColumns = [];
		 for (pos in positions)
		 {
			 var vcolumn:VColumns = null;
			 var vcomplexes:VComplexes = [];
			 var i = 0;
			 for (vpart in vparts)
			 {
				var complex:VComplex = vpart.getPositionsVComplexes().get(pos);
				vcomplexes.push(complex);
				i++;
			 }
			 var vcolumn = new VColumn(vcomplexes);
			vcolumns.push(vcolumn);
		 }
		 return vcolumns;
		 
	 }
	 
	 function calcPositions(vparts:VParts)
	 {
		 var positionsMap = new IntMap<Bool>();
		for (vpart in vparts)
		{
			var poss = vpart.getPositionsVComplexes().keys().keysToArray();
			for (pos in poss) positionsMap.set(pos, true);
		}
		var positions:Array<Int> = positionsMap.keys().keysToArray();
		positions.sort(function(a, b) { return Reflect.compare(a, b); } );
		return positions;
	 }
	 
 }
 
 typedef VColumns = Array<VColumn>;
 
 class VColumn 
 {
	 public var vcomplexes(default, null):VComplexes;
	 public function new(vcomplexes:VComplexes) 
	 { 
		this.vcomplexes = vcomplexes;
	 }
 }
 
 
 typedef VParts = Array<VPart>;
 
class VPart
{
	public var npart(default, null):NPart;
	public function new(npart:NPart) this.npart = npart;
	
	var vvoices:VVoices;
	public function getVVoices(): VVoices
	{
		if (this.vvoices != null) return this.vvoices;
		this.vvoices = [];
		for (nvoice in this.npart.nvoices) this.vvoices.push(new VVoice(nvoice));
		return this.vvoices;
	}
	
	var vcomplexes:VComplexes;
	var vcomplexesPositions:Map<VComplex,Int>;
	var positionsVComplexes:IntMap<VComplex>;
	
	var generator: VPartComplexesGenerator;
	public function getComplexes():VComplexes
	{
		if (this.vcomplexes != null) return this.vcomplexes;
		this.generator = new  VPartComplexesGenerator(this.getVVoices());
		this.vcomplexes = generator.getComplexes();
		this.vcomplexesPositions = generator.getComplexesPositions();
		this.positionsVComplexes = generator.getPositionsComplexes();
		return this.vcomplexes;
	}

	public function getPositionsVComplexes():IntMap<VComplex>
	{
		if (this.vcomplexes == null) this.getComplexes();
		return this.positionsVComplexes;
	}
}

typedef VVoices = Array<VVoice>;

class VVoice 
{
	public var nvoice(default, null):NVoice;
	public function new(nvoice:NVoice) this.nvoice = nvoice;

	var vnotes:VNotes ;	
	public function getVNotes(): VNotes
	{
		if (this.vnotes != null) return this.vnotes;
		this.vnotes = [];
		for (nnote in this.nvoice.nnotes) 
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
	
	var beamgroups:VBeamgroups;
	var beampattern: ENoteValues;
	public function getBeamgroups(pattern:ENoteValues=null):VBeamgroups
	{
		// if new pattern, recreate beamgroups
		if (pattern != beampattern) this.beamgroups = null;
		
		if (this.beamgroups != null) return this.beamgroups;
		
		this.beamgroups = new VCreateBeamgroups(this.getVNotes(), pattern).getBeamgroups();
		
		return this.beamgroups;
	}
}

typedef VNotes = Array<VNote>;

class VNote
{
	public var nnote(default, null):NNote;
	public function new(nnote:NNote) this.nnote = nnote;
	
	var vheads:VHeads;
	public function getVHeads():VHeads
	{
		if (this.vheads != null) return this.vheads;
		this.vheads = [];
		for (nhead in this.nnote.nheads) this.vheads.push(new VHead(nhead));
		return this.vheads;
	}
}

typedef VHeads = Array<VHead>;

class VHead
 {
	 public var nhead(default, null):NHead;
	 public function new (nhead:NHead) this.nhead = nhead;
 }
 
//---------------------------------------------------------------------------------------------------

typedef VSigns = Array<VSign>;

typedef VSign = 
{
	sign:ESign,
	level:Int,	
	position:Int,	
}


class VComplexSignsCalculator 
{
	public var vnotes(default, null):VNotes;
	
	public function new(vnotes:VNotes) 
	{ 
		this.vnotes = vnotes;
	}

	public function getSigns():VSigns
	{
		var signs:VSigns;
		signs = calcUnsortedSigns(this.vnotes);
		signs = calcSortSigns(signs);
		return signs;
	}
	
	var visibleSigns:VSigns;
	public function getVisibleSigns():VSigns
	{
		return calcVisibleSigns(this.getSigns());
	}
	
	//----------------------------------------------------------------------------------
	
	function calcVisibleSigns(signs:VSigns)
	{
		var visibleSigns:VSigns = [];
		for (sign in signs)
		{
			if (sign.sign == ESign.None) continue;
			visibleSigns.push(sign);
		}
		return visibleSigns;
	}
	
	function calcUnsortedSigns(vnotes:VNotes):VSigns
	{
		var vsigns:VSigns = [];
		for (vnote in vnotes)
		{
			for (nhead in vnote.nnote.nheads)
			{
				var tsign:VSign = {
					sign:nhead.sign,
					level:nhead.level,
					position:0,
				}
				vsigns.push(tsign);
			}
		}
		return vsigns;
	}	
	
	function calcSortSigns(vsigns:VSigns):VSigns
	{
		vsigns.sort(function(a:VSign, b:VSign) {
			return Reflect.compare(a.level, b.level);
		});
		return vsigns;
	}
	
}

typedef VComplexes = Array<VComplex>;

class VComplex 
{
	public var vnotes(default, null) :VNotes;
	public function new(vnotes:VNotes)
	{
		if (vnotes.length > 2) throw "VComplex nr of VNote(s) limited to max 2 - for now";
		this.vnotes = vnotes;
	}
	
	
	var signs:VSigns;
	var visibleSigns:VSigns;
	var calculator:VComplexSignsCalculator;
	
	public function getSigns():VSigns
	{
		if (signs != null) return this.signs;
		this.calculator = new VComplexSignsCalculator(this.vnotes);
		this.signs = calculator.getSigns();
		this.visibleSigns = calculator.getVisibleSigns();
		return this.signs;
	}
	
	public function getVisibleSigns():VSigns
	{
		if (visibleSigns != null) return this.visibleSigns;
		this.getSigns();
		return this.visibleSigns;
	}
	
}

typedef VBeamframe = 
{
	leftOuterY:Int,
	leftInnerY:Int,
	rightOuterY:Int,
	rightInnerY:Int,
}
 
typedef VBeamgroups = Array<VBeamgroup>;

 class VBeamgroup
 {
	 public var vnotes(default, null):VNotes;
	 public function new(vnotes:VNotes)
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
	 var vnotes:VNotes;
	 var pattern: ENoteValues;
	 
	 public function new (vnotes:VNotes, pattern:ENoteValues=null)
	 {
		 if (pattern == null) pattern = [ENoteValue.Nv4];

		 this.vnotes = vnotes;
		this.pattern = pattern;
		this.adjustPatternLenght();
	 }

	 var beamgropus:VBeamgroups;
	 public function getBeamgroups():VBeamgroups
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
		var arrVNote:VNotes = [];
		
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

 class VPartComplexesGenerator 
 {
	 public var vvoices(default, null) :VVoices;
	 public function new(vvoices: VVoices) 
	 { 
		this.vvoices = vvoices;
	  }
	  
	  
	  var complexes:VComplexes;
	  public function getComplexes():VComplexes
	  {
		  if (this.complexes != null) return this.complexes;
		  this.positionsMap = calcPositionsMap();
		  calcComplexes(this.positionsMap);
		  return this.complexes;
	  }
	  
	  var positionsComplexes:IntMap<VComplex>;
	  public function getPositionsComplexes():IntMap<VComplex>
	  {
		  if (this.complexes == null) this.getComplexes();
		  return this.positionsComplexes;
	  }
	  
	  var complexesPositions:Map<VComplex, Int>;
	  public function getComplexesPositions():Map<VComplex, Int>
	  {
		  if (this.complexes == null) this.getComplexes();
		  return this.complexesPositions;
	  }
	  
	  function calcComplexes(positions:Map < Int, Array<VNote> > )
	  {
		  this.complexes = [];
		  this.positionsComplexes = new IntMap<VComplex>();
		  this.complexesPositions = new Map<VComplex, Int>();
		  for (pos in positions.keys())
		  {
			  var vnotes = positions.get(pos);
			  var vcomplex = new VComplex(vnotes);
			  this.complexes.push(vcomplex);
			  this.positionsComplexes.set(pos, vcomplex);
			  this.complexesPositions.set(vcomplex, pos);
		  }
	  }
	  
	  var positionsMap: Map<Int, VNotes>;
	  function calcPositionsMap()
	  {
		  var positionsMap = new Map<Int, VNotes>();
		  for (vvoice in this.vvoices)
		  {
			  for (vnote in vvoice.getVNotes())
			  {
				  var npos = vvoice.getVNotePosition(vnote);
				  if (!positionsMap.exists(npos)) positionsMap.set(npos, []);
				  positionsMap.get(npos).push(vnote);
			  }
		  }
		  return positionsMap;
	  }
	  
}

class VMapTools
{
	static public function keysToArray<T>(it : Iterator<T>) : Array<T> {
		var result = [];
		for (v in it) result.push(v);
		return result;
	}	

}