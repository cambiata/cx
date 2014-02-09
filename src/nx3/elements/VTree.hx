package nx3.elements;
import cx.ArrayTools;
import haxe.ds.IntMap.IntMap;
import nx3.Constants;
import nx3.elements.VTree.Partbeamgroups;
import nx3.elements.VTree.VBarColumnsGenerator;
import nx3.elements.VTree.VBeamframe;
import nx3.elements.VTree.VBeamgroup;
import nx3.elements.VTree.VBeamgroupDirectionCalculator;
import nx3.elements.VTree.VBeamgroupFrameCalculator;
import nx3.elements.VTree.VColumns;
import nx3.elements.VTree.VComplex;
import nx3.elements.VTree.VComplexes;
import nx3.elements.VTree.VComplexSignsCalculator;
import nx3.elements.VTree.VCreateBeamgroups;
import nx3.elements.VTree.VHeadPlacementCalculator;
import nx3.elements.VTree.VHeadPlacements;
import nx3.elements.VTree.VNoteConfig;
import nx3.elements.VTree.VNoteHeadsRectsCalculator;
import nx3.elements.VTree.VNoteInternalDirectionCalculator;
import nx3.elements.VTree.VPartbeamgroupsDirectionCalculator;
import nx3.geom.Rectangle;
import nx3.geom.Rectangles;

using nx3.elements.VTree.VMapTools;
using nx3.elements.ENoteValTools;
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
	 
	 var vcolumns:VColumns;
	 public function getVColumns():VColumns
	 {
		 if (this.vcolumns != null) return this.vcolumns;
		 if (this.vparts == null) this.getVParts();
		 var generator = new VBarColumnsGenerator(this.vparts);
		 this.vcolumns = generator.getColumns();
		 this.positionsVColumns = generator.getPositionsColumns();
		 return this.vcolumns;
	 }
	 
	 var positionsVColumns:IntMap<VColumn>;
	 public function getPositionsColumns():IntMap<VColumn>
	 {
		 if (this.positionsVColumns == null) this.getVColumns();
		 return this.positionsVColumns;
	 }
	
	 var vcolumnsPositions:Map<VColumn, Int>;
	 public function getVColumnsPositions():Map<VColumn, Int>
	 {
		 if (this.positionsVColumns == null) this.getVColumns();
		 
		 this.vcolumnsPositions = new Map<VColumn, Int>();
		 
		 for (pos in this.positionsVColumns.keys())
		 {
			 var vcolumn = this.positionsVColumns.get(pos);
			 this.vcolumnsPositions.set(vcolumn, pos);
		 }
		 
		 return this.vcolumnsPositions;
	 }
	 
	 
	var value:Null<Int>;
	public function getValue():Int
	{
		if (this.value != null) return this.value;
		var value = .0;
		for (vpart in this.getVParts())
		{
			value = Math.max(value, vpart.getValue());
		}
		this.value = Std.int(value);
		return this.value;
	}
	
	var vnotesVColumns:Map<VNote, VColumn>;
	 public function getVNotesVColumns(): Map<VNote, VColumn>
	 {
		 if (this.vnotesVColumns != null) return this.vnotesVColumns;
		 this.vnotesVColumns = new Map<VNote, VColumn>();
		 for (vpart in this.getVParts())
		 {
			 for (vvoice in vpart.getVVoices())
			 {
				for (vnote in vvoice.getVNotes())
				{
					var pos = vvoice.getVNotePositions().get(vnote);
					var vcolumn = this.getPositionsColumns().get(pos);
					this.vnotesVColumns.set(vnote, vcolumn);
				}
			 }
		 }
		 return this.vnotesVColumns;
	 }
	 
	 var vcomplexesVColumns:Map<VComplex, VColumn>;
	 public function getVComplexesVColumns():Map<VComplex, VColumn>
	 {
		 if (this.vcomplexesVColumns != null) return this.vcomplexesVColumns;
		 this.vcomplexesVColumns = new Map<VComplex, VColumn>();
		 for (vpart in this.getVParts())
		 {
			 //vpart.getPositionsVComplexes().get(
			 for (vcomplex in vpart.getVComplexes())
			 {
				 var pos = vpart.getVComplexesPositions().get(vcomplex);
				 var vcolumn = this.getPositionsColumns().get(pos);
				 this.vcomplexesVColumns.set(vcomplex, vcolumn);
			 }
		 }
		 return this.vcomplexesVColumns;
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
	 var positionsColumns:IntMap<VColumn>;
	 
	 public function getColumns():VColumns
	 {
		if (this.columns != null) return this.columns;
		 this.positions =  calcPositions(this.vparts);
		calcColumns(this.positions, this.vparts);
		return this.columns;
	 }
	 
	 public function getPositionsColumns():IntMap<VColumn>
	 {
		 if (this.columns == null) this.getColumns();
		 return this.positionsColumns;
	 }
	 
	 var vcomplexesVColumns: Map<VComplex, VColumn>;
	 public function getVComplexesVColumns():Map<VComplex, VColumn>
	 {
		 if (this.columns == null) this.getColumns();
		 return this.vcomplexesVColumns;
	 }
	 
	 function calcColumns(positions:Array<Int>, vparts:VParts)
	 {
		 var partsCount = vparts.length;
		this.columns = [];
		this.positionsColumns = new IntMap<VColumn>();
		
		 for (pos in positions)
		 {
			// var vcolumn:VColumns = null;
			 var vcomplexes:VComplexes = [];
			 for (vpart in vparts)
			 {
				var complex:VComplex = vpart.getPositionsVComplexes().get(pos);
				vcomplexes.push(complex);
			 }
			 
			var vcolumn = new VColumn(vcomplexes);
			this.columns.push(vcolumn);
			this.positionsColumns.set(pos, vcolumn);
		 }
		 
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
	public function getVComplexes():VComplexes
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
		if (this.vcomplexes == null) this.getVComplexes();
		return this.positionsVComplexes;
	}
	
	public function getVComplexesPositions():Map<VComplex,Int>
	{
		if (this.vcomplexes == null) this.getVComplexes();
		return this.vcomplexesPositions;
	}
	
	var value:Null<Int>;
	public function getValue():Int
	{
		if (this.value != null) return this.value;
		if (this.getVVoices().length == 1) 
		{
			this.value = this.vvoices[0].getValue();
		}
		var value = .0;
		for (vvoice in this.vvoices)
		{
			value = Math.max(value, vvoice.getValue());
		}
		this.value = Std.int(value);
		return this.value;
	}
	
	var partbeamgroups:Partbeamgroups;
	public function getPartbeamgroups(): Partbeamgroups
	{
		if (this.partbeamgroups != null) return this.partbeamgroups;
		this.partbeamgroups = new Partbeamgroups();
		for (vvoice in this.getVVoices())
		{
			this.partbeamgroups.push(vvoice.getBeamgroups());
		}
		return this.partbeamgroups;
	}
	
	var beamgroupsDirections:Map<VBeamgroup, EDirectionUD>;
	public function getBeamgroupsDirections():Map<VBeamgroup, EDirectionUD>
	{
		if (this.beamgroupsDirections != null) return this.beamgroupsDirections;
		if (this.partbeamgroups == null) this.getPartbeamgroups();
		
		var calculator = new VPartbeamgroupsDirectionCalculator(this);
		this.beamgroupsDirections = calculator.getBeamgroupsDirections();
		return this.beamgroupsDirections;
	}
	
	var vnotesVVoices:Map<VNote, VVoice>;
	public function getVNotesVVoices():Map<VNote, VVoice>
	{
		if (this.vnotesVVoices != null) return this.vnotesVVoices;
		
		this.vnotesVVoices = new Map<VNote, VVoice>();
		
		for (vvoice in this.getVVoices())
		{
			for (vnote in vvoice.getVNotes())
			{
				this.vnotesVVoices.set(vnote, vvoice);
			}
		}
		return this.vnotesVVoices;
	}
	
}

typedef Partbeamgroups = Array<VBeamgroups>;

class VPartbeamgroupsDirectionCalculator 
{
	
	var vpart:VPart;
	public function new (vpart:VPart)
	{
		this.vpart = vpart;
	}
	
	public function getBeamgroupsDirections():Map<VBeamgroup, EDirectionUD>
	{
		var beamgroupsDirections = new Map<VBeamgroup, EDirectionUD>();
		
		var partbeamgroups = this.vpart.getPartbeamgroups();
		
		var beamgroups0 = partbeamgroups[0];
		var voiceDirection0 = this.vpart.getVVoices()[0].nvoice.direction;
		if (voiceDirection0 == null) voiceDirection0 = EDirectionUAD.Auto;
		
		if (partbeamgroups.length == 1)
		{
			for (beamgroup in beamgroups0)
			{
				var direction:EDirectionUD = null;
				switch voiceDirection0
				{
					case EDirectionUAD.Up:
						direction = EDirectionUD.Up;
					case  EDirectionUAD.Down:
						direction = EDirectionUD.Down;
					case EDirectionUAD.Auto:
						var calculator = new VBeamgroupDirectionCalculator(beamgroup);
						direction = calculator.getDirection();
						
				}
				beamgroupsDirections.set(beamgroup, direction);
			}
		}
		else if (partbeamgroups.length == 2)
		{
			var beamgroups1 = partbeamgroups[1];
			var voiceDirection1 = this.vpart.getVVoices()[1].nvoice.direction;
			if (voiceDirection1 == null) voiceDirection0 = EDirectionUAD.Auto;
			
			var voice0 = this.vpart.getVVoices()[0];
			var voice1 = this.vpart.getVVoices()[1];			
			
			if ((voiceDirection0 == EDirectionUAD.Auto) && (voiceDirection1 == EDirectionUAD.Auto))
			{

				var voice0value = voice0.getValue();
				var voice1value = voice1.getValue();
				
				var direction:EDirectionUD = null;
				
				var bgPosition = 0;
				for (beamgroup in beamgroups0)
				{
					if (bgPosition < voice1value) 
					{
						direction = EDirectionUD.Up;
					}
					else
					{
						var calculator = new VBeamgroupDirectionCalculator(beamgroup);
						direction = calculator.getDirection();						
					}
					beamgroupsDirections.set(beamgroup, direction);
					bgPosition += beamgroup.getValue();
				}

				var bgPosition = 0;
				for (beamgroup in beamgroups1)
				{
					if (bgPosition < voice0value) 
					{
						direction = EDirectionUD.Down;
					}
					else
					{
						var calculator = new VBeamgroupDirectionCalculator(beamgroup);
						direction = calculator.getDirection();						
					}
					beamgroupsDirections.set(beamgroup, direction);
					bgPosition += beamgroup.getValue();
				}
			}
			else 
			{
				for (beamgroup in beamgroups0)
				{
					beamgroupsDirections.set(beamgroup, EDirectionTools.uadToUd(voice0.nvoice.direction));
				}

				for (beamgroup in beamgroups1)
				{
					beamgroupsDirections.set(beamgroup, EDirectionTools.uadToUd(voice1.nvoice.direction));
				}
			}
		}
		else
		{
			throw "SHOULDN'T HAPPEN";
		}
		
		return beamgroupsDirections;
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
	public function getVNotePositions():Map<VNote, Int>
	{
		if (this.vnotePositions != null) return this.vnotePositions;
		if (this.vnotes == null) this.getVNotes();
		this.vnotePositions = new Map<VNote, Int>();
		
		var pos = 0;
		for (vnote in this.vnotes) 
		{
			this.vnotePositions.set(vnote, pos);
			pos += vnote.nnote.value.value();
		}		
		return this.vnotePositions;
		
	}

	var value:Null<Int>;
	public function getValue():Int
	{
		if (this.value != null) return this.value;
		if (this.vnotes == null) this.getVNotes();
		this.value = 0;
		for (vnote in this.vnotes) this.value += vnote.nnote.value.value();
		return this.value;
	}
	
	var beamgroups:VBeamgroups;
	var beampattern: ENoteVals;
	public function getBeamgroups(pattern:ENoteVals=null):VBeamgroups
	{
		// if new pattern, recreate beamgroups
		if (pattern != beampattern) this.beamgroups = null;
		
		if (this.beamgroups != null) return this.beamgroups;
		
		this.beamgroups = new VCreateBeamgroups(this.getVNotes(), pattern).getBeamgroups();
		
		return this.beamgroups;
	}
}

typedef VNoteConfig = { direction:EDirectionUD };


typedef VNotes = Array<VNote>;

class VNote
{
	public var nnote(default, null):NNote;
	public function new(nnote:NNote)
	{
		this.nnote = nnote;
		
	}
	
	var vheads:VHeads;
	public function getVHeads():VHeads
	{
		if (this.vheads != null) return this.vheads;
		this.vheads = [];
		for (nhead in this.nnote.nheads) this.vheads.push(new VHead(nhead));
		return this.vheads;
	}
	
	var vheadsPlacements:VHeadPlacements;
	public function getVHeadsPlacements():VHeadPlacements
	{
		if (this.vheadsPlacements != null) return this.vheadsPlacements;
		if (this.vheads == null) this.getVHeads();
		
		var calculator:VHeadPlacementCalculator = new VHeadPlacementCalculator(this.vheads, this.getDirection());
		this.vheadsPlacements = calculator.getHeadsPlacements();
		return this.vheadsPlacements;
	}
	
	var vheadsRectangles:Rectangles;
	public function getVHeadsRectangles():Rectangles
	{
		if (this.vheadsRectangles != null) return this.vheadsRectangles;
		if (this.vheads == null) this.getVHeads();
		
		var calculator = new VNoteHeadsRectsCalculator(this);
		this.vheadsRectangles = calculator.getHeadsRects();
		return this.vheadsRectangles;
	}
	
	/*
	var directionNNote:EDirectionUAD;
	var directionHeads:EDirectionUD;
	var directionConfig:EDirectionUD;
	
	public function getDirectionHeads()
	{
		if (this.directionHeads != null) return this.directionHeads;
		if (this.vheads == null) this.getVHeads();
		
		var calculator  = new VNoteInternalDirectionCalculator(this.vheads);
		this.directionHeads = calculator.getDirection();
		return this.directionHeads;
	}
	*/
	//var externalDirection:EDirectionUD;
	/*
	public function setDirection(val:EDirectionUD)
	{
		if (this.externalDirection != val)
		{
			this.vheadsPlacements = null;
		}
		
		this.externalDirection = val;
	}
	*/
	
	var config:VNoteConfig;
	public function setConfig(newConfig:VNoteConfig)
	{
		if (Std.string(config) == Std.string(newConfig))
		{
			return;
		}
		else
		{
			// reset stuff...
			this.direction = null;
			this.vheadsPlacements = null;
		}
		
		this.config = newConfig;
	}
	
	var direction:EDirectionUD;
	public function getDirection():EDirectionUD
	{
		if (this.direction != null) return this.direction;
		var calculator = new VNoteDirectionCalculator(this);
		
		var configDirection = (this.config != null) ? config.direction : null;
		this.direction = calculator.getDirection(configDirection);
		return this.direction;
	}
}

class VNoteDirectionCalculator
{
	var vnote:VNote;
	public function new (vnote:VNote)
	{
		this.vnote = vnote;
	}
	
	public function getDirection(directionConfig:EDirectionUD): EDirectionUD
	{
		// always return down if not ENoteType == Note
		if (this.vnote.nnote.type.getIndex() != Type.enumIndex(ENoteType.Note(null))) return EDirectionUD.Down;
		
		var direction:EDirectionUD;
		// prio 1: NNote direction
		if (this.vnote.nnote.direction != null) 
		{
			switch (this.vnote.nnote.direction)
			{
				case EDirectionUAD.Up: 
						direction = EDirectionUD.Up; 
						return direction ;
				case EDirectionUAD.Down: 
						direction = EDirectionUD.Down; 
						return direction ;
				default: //
			}
		}
		
		// prio 2: from external configuration
		if (directionConfig != null) return directionConfig;
		
		// prio 3: calculate internal direction from heads
		var calculator = new VNoteInternalDirectionCalculator(this.vnote.getVHeads());
		return calculator.getDirection();
	}
	
	
}

class VNoteInternalDirectionCalculator
{
	var vheads:VHeads;
	public function new(vheads:VHeads)
	{
		this.vheads = vheads;
	}
	
	public function getDirection():EDirectionUD
	{
		var headsCount = this.vheads.length;
		switch headsCount
		{
			case 0: return EDirectionUD.Down; // Pause etc...		
			case 1: return this.weightToDirection(this.vheads[0].nhead.level);
			default: 
				//
		}
		var weight = this.vheads[0].nhead.level + this.vheads[headsCount - 1].nhead.level;
		return this.weightToDirection(weight);
	}
	
	function weightToDirection(weight:Int):EDirectionUD
	{
		return (weight <= 0) ? EDirectionUD.Down : EDirectionUD.Up;
	}
	
}

class VNoteHeadsRectsCalculator
{
	var vnote:VNote;
	public function new(vnote:VNote)
	{
		this.vnote = vnote;		
	}
	
	
	
	public function getHeadsRects():Rectangles
	{
		var rects = new Rectangles();
		var headPlacements:VHeadPlacements = vnote.getVHeadsPlacements();
		var value = this.vnote.nnote.value;
		
		for (placement in headPlacements)
		{
			var rect:Rectangle = null;
			var headw:Float = 0;
			switch(value.head())
			{
				case EHeadValuetype.HVT1:					
					headw = Constants.HEAD_HALFWIDTH_WIDE;
				default:
					headw = Constants.HEAD_HALFWIDTH_NORMAL;
			}	
			
			rect =  new Rectangle( -headw, -1, 2 * headw, 2);
			
			var pos = 0.0;
			switch placement.pos
			{
				case EHeadPosition.Left: pos = -2*headw;
				case EHeadPosition.Right: pos = 2*headw;
				default : pos = 0;
			}			
			rect.offset(pos, placement.level);					
			rects.push(rect);
		}

		return rects;
	}
	
	
	
}



class VHeadPlacementCalculator
{
	var vheads:VHeads;
	var direction :EDirectionUD;
	public function new(vheads:VHeads, direction:EDirectionUD)
	{
		this.vheads = vheads;
		this.direction = direction;
	}
	
	public function getHeadsPlacements():VHeadPlacements
	{
		
		if (vheads.length == 1) return [ { level: vheads[0].nhead.level, pos:EHeadPosition.Center } ];
		
		var len:Int = this.vheads.length;

		var placements :VHeadPlacements = [];
		var tempArray:Array<Int> = [];

		for (vhead in this.vheads)
		{
			var placement:VHeadPlacement = { level: vhead.nhead.level, pos: EHeadPosition.Center};
			placements.push(placement);
			tempArray.push(0); 
		}
		
		if (this.direction == EDirectionUD.Up) {
			
			for (j in 0...len - 1) {
				var i = len - j - 1;				
				var vhead = this.vheads[i];
				var vheadNext = this.vheads[i - 1];
				var lDiff = vhead.nhead.level - vheadNext.nhead.level;				
				if (lDiff < 2) {
					if (tempArray[i] == tempArray[i - 1]) {
						tempArray[i - 1] = 1;
						placements[i - 1].pos = EHeadPosition.Right;
					}
				}								
			}			
		} else {
			for (i in 0...len - 1) {				
				var vhead = this.vheads[i];
				var vheadNext = this.vheads[i + 1];
				var lDiff = vheadNext.nhead.level - vhead.nhead.level;
				if (lDiff < 2) {
					if (tempArray[i] == tempArray[i + 1]) {
						tempArray[i + 1] = -1;
						placements[i + 1].pos = EHeadPosition.Left;
					}
				}
			}

		}
		
		return placements;
	}
}

typedef VHeadPlacements = Array<VHeadPlacement>;
typedef VHeadPlacement = { level:ULevel, pos: EHeadPosition};
enum  EHeadPosition
{
	Left;
	Center;
	Right;
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
	
	
	
	public function getVNotes():VNotes
	{
		return this.vnotes;
	}
	
	public function getSigns():VSigns
	{

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
	 
	 var value:Null<Int> = null;
	 public function getValue():Int
	 {
		 if (this.value != null) return this.value;
		 this.value = 0;
		 for (vnote in this.vnotes)
		 {
			this.value += vnote.nnote.value.value();
		 }
		 return this.value;
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
		 return EDirectionUD.Up;
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
	 var pattern: ENoteVals;
	 
	 public function new (vnotes:VNotes, pattern:ENoteVals=null)
	 {
		 if (pattern == null) pattern = [ENoteVal.Nv4];

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
		 for (vnote in vnotes) notesValue += vnote.nnote.value.value();
		 
		 var patternValue = 0;
		 for (value in pattern) patternValue += value.value();
		 
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
			var vValue = v.value();
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
			var endpos = pos + vnote.nnote.value.value();
			this.vnotePositionEnd.set(vnote, pos + vnote.nnote.value.value());
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
					
						if (vnote.nnote.value.beaminglevel() < 1) 
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
		  var poskeys = positions.keys().keysToArray();
		  poskeys = poskeys.sortarray();
		  for (pos in poskeys)
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
				  var npos = vvoice.getVNotePositions().get(vnote);
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
	
	static public function sortarray<T>(a:Array<T>):Array<T>
	{
		a.sort(function (a, b) { return Reflect.compare(a, b); } );
		return a;
	}
	

}