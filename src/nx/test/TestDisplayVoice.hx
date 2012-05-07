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
	
	public function test2() {
		var dv = new DisplayVoice(TO.getVoiceOneBar4_4_Mixed1 ());
		assertEquals(dv.getDisplayNotesCount(), 5);
		var firstDN = dv.getDisplayNote(0);
		var nextDN = dv.getDisplayNote(1);
		dv.getNextDisplayNote (firstDN);
		assertEquals(nextDN, dv.getNextDisplayNote(firstDN));		
		assertEquals(dv.getDisplayNote(4), dv.getNextDisplayNote(dv.getDisplayNote(3)));
		assertEquals(null, dv.getNextDisplayNote(dv.getDisplayNote(4)));
		
	}
	
}