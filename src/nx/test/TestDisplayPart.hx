package nx.test;
import haxe.unit.TestCase;
import nx.display.DisplayPart;
import nx.enums.EDirectionUAD;
import nx.element.Part;
/**
 * ...
 * @author Jonas Nyström
 */

class TestDisplayPart extends TestCase
{
	public function test0() {
		var dv0 = TO.getVoiceOneBar4_4_Nv4sLm3 ().setDirection(EDirectionUAD.Up);
		var dv1 = TO.getVoiceOneBar4_4_Nv2sL2().setDirection(EDirectionUAD.Down);		
		var dp = new DisplayPart(Part.getNew([dv0, dv1]));		

		assertEquals(dp.getDisplayNotesSequence().length, 6);
		
		for (dn in dp.getDisplayNotesSequence()) {
			trace(dn.getLevelTop());
			trace(dp.getDisplayVoiceIndex(dp.getDisplayNoteDisplayVoice(dn)));
		}
		
		assertTrue(true);
		
	}
	
}