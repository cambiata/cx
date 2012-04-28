package nx.test;
import nx.element.Head;
import nx.display.DisplayHead;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class TestDisplayHead extends haxe.unit.TestCase {
	public function testDisplayHead1() {
		var dh = new DisplayHead(Head.getNew(2, ESign.Flat));
		assertEquals(2, dh.getLevel());
		assertEquals(ESign.Flat, dh.getSign());
	}
}