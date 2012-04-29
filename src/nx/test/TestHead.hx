package nx.test;
import nx.element.Head;
import nx.enums.ESign;
import nx.const.NConst;
/**
 * ...
 * @author Jonas Nyström
 */

class TestHead extends haxe.unit.TestCase {
	public function testHead1() {
		
		var h = Head.getNew(1, ESign.Natural);
		assertTrue(h.getLevel() == 1);
		h.setLevel(NConst.HEAD_MAX_LEVEL + 1);
		assertEquals(NConst.HEAD_MAX_LEVEL, h.getLevel());
		
		

	}
}