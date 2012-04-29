package nx.test;

import nx.element.Head;
import nx.element.Note;

/**
 * ...
 * @author Jonas Nyström
 */


class TestNote extends haxe.unit.TestCase {
	public function testNote1() {
		
		var n = TO.getNote1();		
		assertTrue(n != null);
		assertEquals(1, n.getLevelTop());
		assertEquals(2, n.getLevelBottom());
		
		var n = TO.getNote2();
		assertEquals(3, n.getLevelTop());
		assertEquals(4, n.getLevelBottom());
		
	}	
	

	
	
}