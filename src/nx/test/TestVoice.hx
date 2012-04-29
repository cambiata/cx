package nx.test;
import nx.element.Voice;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class TestVoice extends haxe.unit.TestCase 
{

	public function test1() {
		var v = TO.getVoice0();
		assertTrue(v != null);
		assertEquals(EDirectionUAD.Auto, v.getDirection());
		var v = TO.getVoice0().setDirection(EDirectionUAD.Down);
		assertEquals(EDirectionUAD.Down, v.getDirection());		
		
	}
	
	
}