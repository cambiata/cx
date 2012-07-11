package sx.test.grid;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;

/**
 * ...
 * @author Jonas Nyström
 */


class TestGridCoords {
	
	public function new() {
		var r:TestRunner = new TestRunner;
		r.add(new TestGridCoordsCase());
		r.run();
	}
	
}

class TestGridCoordsCase extends TestCase
{

	public function setup() {
		trace(setup);
	}
	
	public function test0() 
	{
		
	}
	
}