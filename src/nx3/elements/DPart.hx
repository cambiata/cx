package nx3.elements;
import cx.ArrayTools;
import haxe.ds.IntMap.IntMap;

/**
 * ...
 * @author Jonas Nyström
 */


class DPart
{
	public var part(default,null):NPart;
	public var sumNoteValue(default,null):Int;
	public var dvoices(default,null):Array<DVoice>;
	
	public function new(part:NPart, beamingProcessor:BProcessor=null) 
	{
		this.part = part;
		
		this.dvoices = [];
		for (nvoice in this.part.voices) 
		{
			this.dvoices.push(new DVoice(nvoice, nvoice.direction, beamingProcessor));
		}
		this.sumNoteValue = 0;
		
		calcPositions();
		calcDComplexs();
	}

	public var dcomplexes(default,null):Array<DComplex>;
	public var positions		(default, null)			:Array<Int>;	
	public var complexPosition(default, null):Map<DComplex, Int>;
	public var complexDistance(default, null):Map<DComplex, Float>;
	public var positionComplex(default, null):IntMap<DComplex>;
	
	private var _posDNotes:IntMap<Array<DNote>>;
	
	private function calcPositions() 
	{
		this._posDNotes = new IntMap<Array<DNote>>();
		for (dvoice in this.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!_posDNotes.exists(pos)) _posDNotes.set(pos, []); 				
				_posDNotes.get(pos).push(dnote);
				pos += dnote.value.value;
			}
		}		
		this.positions = ArrayTools.fromIterator(_posDNotes.keys());
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );		
	}
	
	private function calcDComplexs() {
		this.dcomplexes = [];
		this.complexPosition = new Map<DComplex, Int>();
		this.positionComplex = new IntMap <DComplex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new DComplex(dnotes);
			this.dcomplexes.push(dplex);			
			this.complexPosition.set(dplex, pos);
			this.positionComplex.set(pos, dplex);
		}								
	}	
	
	/*
	private function calcDistances() {
		this.complexDistance = new Map<DComplex, Float>();
		var length = this.dcomplexes.length;
		
		this.complexDistance.set(this.dplex(0), 0);
		for (i in 0...length-1) {
			var plex = this.dcomplexes[i];
			var plexNext = this.dcomplexes[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this.complexDistance.set(plexNext, distanceX);
		}			
	}
	*/
		
	public function dplex(idx:Int)  return this.dcomplexes[idx];
	
	
}
