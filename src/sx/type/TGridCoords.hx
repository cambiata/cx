package sx.type;
import cx.MathTools;
import haxe.unit.TestCase;

/**
 * ...
 * @author Jonas Nyström
 */

typedef TGridCoords = Array<TGridCoord>;

typedef TGridCoordPair = {
	first:TGridCoord,
	next:TGridCoord,
}

class GridCoordTools {
	
	static public function getCoordIdx(gridCoords:TGridCoords, pos:Float):Int {				
		for (i in 0...gridCoords.length) {			
			if (pos < gridCoords[i].pos) {				
				return MathTools.intMax(0, i-1);
			}
		}
		return gridCoords.length-1;
	}	
	
	static public function getCoordIdxNext(gridCoords:TGridCoords, pos:Float):Int {
		for (i in 0...gridCoords.length) {			
			if (pos < gridCoords[i].pos) {				
				return i; // MathTools.intMax(0, );
			}
		}
		return gridCoords.length-1;
	}
	
	
	static public function getCoord(gridCoords:TGridCoords, pos:Float):TGridCoord {				
		return gridCoords[getCoordIdx(gridCoords, pos)];
	}	
	
	
	static private function coordsIpol(a:TGridCoord, b:TGridCoord, delta:Float, pos:Float) {
		var ret:TGridCoord = {
			pos : 	pos, 
			x : 		delta * (b.x - a.x) + a.x,
			y : 		delta * (b.y - a.y) + a.y,
			height : delta * (b.height - a.height) + a.height,
		}
		return ret;
	}
	

	static public function getCoordInterpolation(gridCoords:TGridCoords, pos:Float):TGridCoord {		
		var firstIdx = getCoordIdx(gridCoords, pos);
		var nextIdx = getCoordIdxNext(gridCoords, pos);		
		if (firstIdx != nextIdx) {
			var delta:Float = (pos - gridCoords[firstIdx].pos) / (gridCoords[nextIdx].pos - gridCoords[firstIdx].pos);
			return coordsIpol(gridCoords[firstIdx], gridCoords[nextIdx], delta, pos);
		}		
		return gridCoords[firstIdx];
	}
	
	
	
	static public function test() {
		var ret:TGridCoords =  [
		{ pos:0.1, x:100.0, y:100.0, height:100.0 } ,
		{ pos:0.2, x:200.0, y:100.0, height:10.0 }   , 
		{ pos:0.3, x:220.0, y:100.0, height:120.0 } , 
		{ pos:0.4, x:400.0, y:100.0, height:100.0 } ,
		];

		return ret;
	}	
}

using TGridCoords.GridCoordTools;
class GridCoordsTestCase extends TestCase {
	
	private var gcs:TGridCoords;
	
	public static var testGridCoords = [
		{ pos:0.1, x:100.0, y:100.0, height:100.0 } ,
		{ pos:0.2, x:200.0, y:100.0, height:10.0 }   , 
		{ pos:0.3, x:220.0, y:80.0, height:140.0 } , 
		{ pos:0.4, x:400.0, y:100.0, height:100.0 } ,
		];
	
	override public function setup() {
		this.gcs = testGridCoords;
		/*[
		{ pos:0.1, x:100.0, y:100.0, height:100.0 } ,
		{ pos:0.2, x:200.0, y:100.0, height:10.0 }   , 
		{ pos:0.3, x:220.0, y:80.0, height:140.0 } , 
		{ pos:0.4, x:400.0, y:100.0, height:100.0 } ,
		];
		*/
	}
	
	public function test0() {
		assertEquals(4, this.gcs.length);		
		
		
		assertEquals(0, this.gcs.getCoordIdx(0));
		assertEquals(0, this.gcs.getCoordIdx(0.1));
		assertEquals(0, this.gcs.getCoordIdx(0.11));
		assertEquals(1, this.gcs.getCoordIdx(0.2));		
		assertEquals(2, this.gcs.getCoordIdx(0.3));		
		assertEquals(3, this.gcs.getCoordIdx(0.4));
		assertEquals(3, this.gcs.getCoordIdx(0.41));		
		
		
		assertEquals(0, this.gcs.getCoordIdxNext (0));
		assertEquals(0, this.gcs.getCoordIdxNext (0.099));
		assertEquals(1, this.gcs.getCoordIdxNext (0.1));
		assertEquals(1, this.gcs.getCoordIdxNext (0.11));
		assertEquals(2, this.gcs.getCoordIdxNext (0.2));
		assertEquals(3, this.gcs.getCoordIdxNext (0.3));
		assertEquals(3, this.gcs.getCoordIdxNext (0.4));
		assertEquals(3, this.gcs.getCoordIdxNext (0.41));
		
		
		assertEquals(0.1, this.gcs.getCoord(0).pos);
		assertEquals(0.1, this.gcs.getCoord(0.1).pos);
		assertEquals(0.1, this.gcs.getCoord(0.11).pos);
		assertEquals(0.2, this.gcs.getCoord(0.2).pos);		
		assertEquals(0.3, this.gcs.getCoord(0.3).pos);		
		assertEquals(0.4, this.gcs.getCoord(0.4).pos);
		assertEquals(0.4, this.gcs.getCoord(0.41).pos);
		
	}
	
	public function test1() {
		assertTrue(true);
		assertEquals(0.1, this.gcs.getCoordInterpolation(0).pos);
		assertEquals(0.1, this.gcs.getCoordInterpolation(0.1).pos);
		assertEquals(0.2, this.gcs.getCoordInterpolation(0.2).pos);
		
		assertEquals(100.0, this.gcs.getCoordInterpolation(0).x);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.1).x);
		assertEquals(200.0, this.gcs.getCoordInterpolation(0.2).x);
		assertEquals(220.0, this.gcs.getCoordInterpolation(0.3).x);
		assertEquals(400.0, this.gcs.getCoordInterpolation(0.4).x);
		assertEquals(400.0, this.gcs.getCoordInterpolation(0.5).x);

		assertEquals(100.0, this.gcs.getCoordInterpolation(0).y);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.1).y);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.2).y);
		assertEquals(80.0, this.gcs.getCoordInterpolation(0.3).y);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.4).y);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.5).y);		
		
		assertEquals(100.0, this.gcs.getCoordInterpolation(0).height);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.1).height);
		assertEquals(10.0, this.gcs.getCoordInterpolation(0.2).height);
		assertEquals(140.0, this.gcs.getCoordInterpolation(0.3).height);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.4).height);
		assertEquals(100.0, this.gcs.getCoordInterpolation(0.5).height);			
		
	}
	
	public function test2() {
		assertEquals(5.0, MathTools.ipol(0, 10, 0.5));
		assertEquals(4.0, MathTools.ipol(0, 8, 0.5));
		assertEquals(5.0, MathTools.ipol(1, 9, 0.5));
		
		assertEquals(0.0, MathTools.ipol(-10, 10, 0.5));
	}
	
}