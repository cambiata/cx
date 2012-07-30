package nx.core.display;
import cx.ArrayTools;
import nx.core.element.Part;

/**
 * ...
 * @author Jonas Nyström
 */

class DPart 
{
	public var part(default, null):Part;
	

	public var _dvoices:Array<DVoice>;
	private var _dplexs:Array<DPlex>;	
	private var _positions:Array<Int>;
	private var _distancesX:Array<Float>;
	
	public function new(part:Part=null) {		
		this.part = (part != null) ? part : new Part();		
		
		this._dvoices = [];
		for (voice in this.part.voices) {
			this._dvoices.push(new DVoice(voice, voice.direction));
		}
		
		
		/*
		
		// calculate positions and dplexs
		var posDNotes = new IntHash<Array<DNote>>();
		for (dvoice in this.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!posDNotes.exists(pos)) posDNotes.set(pos, []); 				
				posDNotes.get(pos).push(dnote);
				pos += dnote.notevalue.value;
			}
		}
		this.positions = ArrayTools.fromIterator(posDNotes.keys());
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );
		for (pos in this.positions) {
			var dnotes = posDNotes.get(pos);
			trace([pos, dnotes.length]);
			this.dplexs.push(new DPlex(dnotes));			
		}		
		*/
	}

	private function get_dplexs():Array<DPlex> {
		if (this._dplexs != null) return this._dplexs;		
		var posDNotes = new IntHash<Array<DNote>>();
		for (dvoice in this._dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!posDNotes.exists(pos)) posDNotes.set(pos, []); 				
				posDNotes.get(pos).push(dnote);
				pos += dnote.notevalue.value;
			}
		}
		this._positions = ArrayTools.fromIterator(posDNotes.keys());
		this._positions.sort(function(a, b) { return Reflect.compare(a, b); } );
		this._dplexs = [];
		for (pos in this._positions) {
			var dnotes = posDNotes.get(pos);
			this._dplexs.push(new DPlex(dnotes));			
		}				
		
		
		return this._dplexs;
	}
	public var dplexs(get_dplexs, null):Array<DPlex>;
	
	public function dplex(idx:Int):DPlex {
		return this.dplexs[idx];
	}
	
	public var positions(get_positions, null):Array<Int>;
	private function get_positions():Array<Int> 	{
		if (this._positions != null ) return this._positions;
		
		// inovke calculation of dplexs to get positions:
		this.get_dplexs();
		return this._positions;
	}
	
	
	private function get_distancesX():Array<Float> {
		if (this._distancesX != null) return this._distancesX;
		this._distancesX = [];
		
		// this.positions will invoke positions and dplexs calculation:
		var length = this.positions.length;
		
		this._distancesX.push(0);
		for (i in 0...length-1) {
			var plex = this._dplexs[i];
			var plexNext = this._dplexs[i + 1];	
			var distanceX = plex.distanceX(plexNext);
			this._distancesX.push(distanceX);
		}
		
		return this._distancesX;
	}
	
	public var distancesX(get_distancesX, null):Array<Float>;
	
	
	
	


	
	
}