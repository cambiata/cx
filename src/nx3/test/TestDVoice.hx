package nx3.test;

import haxe.unit.TestCase;
import nx3.elements.BGroup;
import nx3.elements.BSingle;
import nx3.elements.BProcessor_2Eights;
import nx3.elements.BProcessor_3Eights;
import nx3.elements.ConfigDVoice;
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
	/*
	public function testValue()
	{
		var dvoice:DVoice = new DVoice(new QVoice(4, [0]));
		this.assertEquals(dvoice.value, ENoteValue.Nv4.value);
			
	}
	*/
	
	public function testBeamGroupsLength()
	{
		var configNv4: ConfigDVoice = { beaming:[ENoteValue.Nv4] };
		var configNv4Dot: ConfigDVoice = { beaming:[ENoteValue.Nv4dot] };
		
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), configNv4);
		this.assertEquals(dvoice.beamGroups.length, 2);

		
		var dvoice:DVoice  = new DVoice(new QVoice(8, [0], 3), configNv4Dot);
		this.assertEquals(dvoice.beamGroups.length, 1);
		
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 6), configNv4);
		this.assertEquals(dvoice.beamGroups.length, 3);		
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 6), configNv4Dot);
		this.assertEquals(dvoice.beamGroups.length, 2);
		
		var dvoice:DVoice = new DVoice(new QVoice(16, [0], 12), configNv4);
		this.assertEquals(ENoteValue.Nv8.value * 6, ENoteValue.Nv16.value * 12);
		this.assertEquals(dvoice.getValue(), ENoteValue.Nv16.value * 12);
		this.assertEquals(3, dvoice.beamGroups.length);
		
		var dvoice:DVoice = new DVoice(new QVoice(16, [0], 12), configNv4Dot);
		this.assertEquals(2, dvoice.beamGroups.length);
		
	}
		
	/*
	public function testBeamGroupsTypes()
	{
		var configNv4: ConfigDVoice = { beaming:[ENoteValue.Nv4] };
		var configNv4Dot: ConfigDVoice = { beaming:[ENoteValue.Nv4dot] };
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), configNv4);
		this.assertEquals(dvoice.beamGroups.length, 2);
		this.assertEquals(dvoice.beamGroups[0].count(), 2);
		this.assertTrue(Std.is(dvoice.beamGroups[0], BGroup));
		this.assertEquals(dvoice.beamGroups[1].count(), 1);
		this.assertTrue(Std.is(dvoice.beamGroups[1], BSingle));
		
		var dvoice:DVoice = new DVoice(new QVoice(8, [0], 3), configNv4);
		this.assertEquals(dvoice.beamGroups.length, 1);
		this.assertTrue(Std.is(dvoice.beamGroups[0], BGroup));		
	}
	*/
}
