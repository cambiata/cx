package nx3.test;

import haxe.unit.TestCase;
import nx3.elements.BGroup;
import nx3.elements.BSingle;
import nx3.elements.BProcessor_2Eights;
import nx3.elements.BProcessor_3Eights;
import nx3.elements.DVoice;
import nx3.elements.ENoteValue;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.NVoice;

/**
 * ...
 * @author Jonas Nyström
 */
class TestDVoice extends TestCase 
{
	
	public function testBeamGroupsLength()
	{

		new QNote(1);
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), new BProcessor_2Eights());
		this.assertEquals(dvoice.beamGroups.length, 2);
	
		var dvoice:DVoice  = new DVoice(new QVoice(8, [0], 3), new BProcessor_3Eights());
		this.assertEquals(dvoice.beamGroups.length, 1);
		
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 6), new BProcessor_2Eights());
		this.assertEquals(dvoice.beamGroups.length, 3);		
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 6), new BProcessor_3Eights());
		this.assertEquals(dvoice.beamGroups.length, 2);
		
		var dvoice:DVoice = new DVoice(new QVoice(16, [0], 12), new BProcessor_2Eights());
		this.assertEquals(ENoteValue.Nv8.value * 6, ENoteValue.Nv16.value * 12);
		this.assertEquals(dvoice.sumNoteValue, ENoteValue.Nv16.value * 12);
		this.assertEquals(3, dvoice.beamGroups.length);
		
		var dvoice:DVoice = new DVoice(new QVoice(16, [0], 12), new BProcessor_3Eights());
		this.assertEquals(2, dvoice.beamGroups.length);
		/*
		*/
	}
		
	public function testBeamGroupsTypes()
	{
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), new BProcessor_2Eights());
		this.assertEquals(dvoice.beamGroups.length, 2);
		this.assertEquals(dvoice.beamGroups[0].count(), 2);
		this.assertTrue(Std.is(dvoice.beamGroups[0], BGroup));
		this.assertEquals(dvoice.beamGroups[1].count(), 1);
		this.assertTrue(Std.is(dvoice.beamGroups[1], BSingle));
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), new BProcessor_3Eights());
		this.assertEquals(dvoice.beamGroups.length, 1);
		this.assertTrue(Std.is(dvoice.beamGroups[0], BGroup));		
	}
	
}
