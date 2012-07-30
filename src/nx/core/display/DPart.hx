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
	public var dplexs			(default, null)		:Array<DPlex>;	
	public var positions		(default, null)		:Array<Int>;
	public var dplexPosition(default, null)		:ObjectHash<DPlex, Int>;
	public var dplexDistance(default, null)	:ObjectHash<DPlex, Float>;
	public var positionDplex(default, null)	:IntHash<DPlex>;
	
	public function dplex(idx:Int)  return this.dplexs[idx]
	
	public function new(part:Part=null) {		
		this.part = (part != null) ? part : new Part();		
		
		this.dvoices = [];
		for (voice in this.part.voices) {
			this.dvoices.push(new DVoice(voice, voice.direction));
		}

		this._calcPositions();
		this._calcDPlexs();
		this._calcDistances();
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

	private function _calcDPlexs() {
		this.dplexs = [];
		this.dplexPosition = new ObjectHash<DPlex, Int>();
		this.positionDplex = new IntHash<DPlex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new DPlex(dnotes);
			this.dplexs.push(dplex);			
			this.dplexPosition.set(dplex, pos);
			this.positionDplex.set(pos, dplex);
		}								
	}
	
	private function _calcDistances() {
		this.dplexDistance = new ObjectHash<DPlex, Float>();
		var length = this.dplexs.length;
		
		this.dplexDistance.set(this.dplex(0), 0);
		for (i in 0...length-1) {
			var plex = this.dplexs[i];
			var plexNext = this.dplexs[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this.dplexDistance.set(plexNext, distanceX);
		}			
	}
}