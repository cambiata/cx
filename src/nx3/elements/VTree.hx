package nx3.elements;
import nx3.test.TestVTree;

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
	
	var beamgroups:Array<BItem>;
	public function getBeamgroups():Array<BItem>
	{
		if (this.beamgroups != null) return this.beamgroups;
		
		
		
		
		
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
 
 class VCreateBeamgroups 
 {
	 var vnotes:Array<VNote>;
	 var pattern: Array<ENoteValue>;
	 
	 public function new (vnotes:Array<VNote>, pattern:Array<ENoteValue>)
	 {
		this.vnotes = vnotes;
		this.pattern = pattern;
	 }

	 var beamgropus:Array<BItem>;
	 public function getBeamgroups():Array<BItem>
	 {
		 
		 
	 }
	 
	 
	 
	 //------------------------------------------------------------------
	 
	 private function adjustPatternLenght()
	 {
		 var notesValue = 0;
		 
		 
	 }
	 
	 
	 
	 
 }
