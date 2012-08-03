package nx.core.display;
import cx.ArrayTools;
import nx.core.element.Part;
import nme.ObjectHash;

/**
 * ...
 * @author Jonas Nyström
 */

class DPart 
{
	private var _posDNotes:IntHash<Array<DNote>>;

	public var part			(default, null)		:Part;
	public var dvoices		(default, null)		:Array<DVoice>;
	public var complexes	(default, null)		:Array<Complex>;	
	public var positions		(default, null)		:Array<Int>;
	public var complexPosition(default, null)		:ObjectHash<Complex, Int>;
	public var complexDistance(default, null)	:ObjectHash<Complex, Float>;
	public var positionComplex(default, null)	:IntHash<Complex>;
	

	
	public function dplex(idx:Int)  return this.complexes[idx]
	
	public function new(part:Part=null) {		
		this.part = (part != null) ? part : new Part();		
		
		this.dvoices = [];
		for (voice in this.part.voices) {
			this.dvoices.push(new DVoice(voice, voice.direction));
		}

		this._calcPositions();
		this._calcDComplexs();
		this._calcDistances();
	}
	
	
	private var _value:Int;
	public var value(get_value, null):Int;
	private function get_value():Int 
	{
		if (this._value != null) return this._value;
		this._value = 0;
		for (dvoice in this.dvoices) {
			this._value = Std.int(Math.max(this._value, dvoice.value));
		}
		return this._value;
	}

	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/
	
	private function _calcPositions() {
		this._posDNotes = new IntHash<Array<DNote>>();
		for (dvoice in this.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!_posDNotes.exists(pos)) _posDNotes.set(pos, []); 				
				_posDNotes.get(pos).push(dnote);
				pos += dnote.notevalue.value;
			}
		}		
		this.positions = ArrayTools.fromIterator(_posDNotes.keys());
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );		
	}

	private function _calcDComplexs() {
		this.complexes = [];
		this.complexPosition = new ObjectHash<Complex, Int>();
		this.positionComplex = new IntHash<Complex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new Complex(dnotes);
			this.complexes.push(dplex);			
			this.complexPosition.set(dplex, pos);
			this.positionComplex.set(pos, dplex);
		}								
	}
	
	private function _calcDistances() {
		this.complexDistance = new ObjectHash<Complex, Float>();
		var length = this.complexes.length;
		
		this.complexDistance.set(this.dplex(0), 0);
		for (i in 0...length-1) {
			var plex = this.complexes[i];
			var plexNext = this.complexes[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this.complexDistance.set(plexNext, distanceX);
		}			
	}
}