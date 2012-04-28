package nx.test;

import nx.element.Head;
import nx.element.Note;

/**
 * ...
 * @author Jonas Nyström
 */


class TestNote extends haxe.unit.TestCase {
	public function testNote1() {
		var n = Note.getNew([Head.getNew(1), Head.getNew(2)]);
		assertTrue(n != null);
		assertEquals(1, n.getLevelTop());
		assertEquals(2, n.getLevelBottom());
		
		var n = Note.getNew([Head.getNew(4), Head.getNew(3)]);
		assertEquals(3, n.getLevelTop());
		assertEquals(4, n.getLevelBottom());
		
	}
}