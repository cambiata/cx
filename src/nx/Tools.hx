package nx;

/**
 * ...
 * @author Jonas Nyström
 */

class Tools 
{
	static public function intRange(min:Int, value:Int, max:Int): Int {
		return (value < min) ? min : ((value > max) ? max: value);
	}
	
}


class TestTools extends haxe.unit.TestCase {
	public function testIntRange1() {
		assertEquals(4, Tools.intRange(3, 4, 5));
		assertEquals(3, Tools.intRange(3, 3, 5));
		assertEquals(3, Tools.intRange(3, 2, 5));
		assertEquals(3, Tools.intRange(3, 0, 5));
		assertEquals(3, Tools.intRange(3, -321, 5));
		
		assertEquals(5, Tools.intRange(3, 5, 5));
		assertEquals(5, Tools.intRange(3, 6, 5));
		assertEquals(5, Tools.intRange(3, 7, 5));
		assertEquals(5, Tools.intRange(3, 999999, 5));
		
	}
}