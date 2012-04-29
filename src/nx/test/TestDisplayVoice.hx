package nx.test;
import haxe.unit.TestCase;
import nx.display.beam.BeamingProcessor_4;
import nx.display.DisplayVoice;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class TestDisplayVoice extends TestCase
{

	public function test1() 
	{
		
		assertTrue(true);
		
		
		var dv = new DisplayVoice(TO.getVoice0(), EDirectionUAD.Auto, new BeamingProcessor_4());
		/*
		assertTrue(dv != null);
		assertEquals(dv.getDirection(), EDirectionUAD.Auto);
		
		
		var dv = new DisplayVoice(TO.getVoice0().setDirection(EDirectionUAD.Up));
		assertEquals(dv.getDirection(), EDirectionUAD.Up);		
		
		var v = TO.getVoice0().setDirection(EDirectionUAD.Down);
		*/
		
		
		
	}
	
}