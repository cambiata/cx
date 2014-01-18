package nx3.elements;
import cx.ArrayTools;
import haxe.ds.IntMap.IntMap;
import nx3.elements.DNote;
/**
 * ...
 * @author Jonas Nyström
 */
@:access(DPart)
class CalcDPart
{
	static public function calcPositions(dpart:DPart)
	{
		var result:Array<Int> = [];
		var posDnotes = new IntMap<Array<DNote>>();
		for (dvoice in dpart.dvoices) {
			var pos = 0;
			for (dnote in dvoice.dnotes) {
				if (!posDnotes.exists(pos)) posDnotes.set(pos, []); 				
				posDnotes.get(pos).push(dnote);
				pos += dnote.value.value;
			}
		}		
		result = ArrayTools.fromIterator(posDnotes.keys());
		result.sort(function(a, b) { return Reflect.compare(a, b); } );				
		return result;
	}
	
	static public function calcDComplexs(dpart:DPart) {
		dpart.dcomplexes = [];
		dpart.complexPosition = new Map<DComplex, Int>();
		dpart.positionComplex = new IntMap<Complex>();
		
		for (pos in this.positions) {
			var dnotes = this._posDNotes.get(pos);
			var dplex = new Complex(dnotes, this);
			dpart.dcomplexes.push(dplex);			
			dpart.complexPosition.set(dplex, pos);
			dpart.positionComplex.set(pos, dplex);
		}								
	}
	
	
	
}