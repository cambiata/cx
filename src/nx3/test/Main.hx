package nx3.test;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;
import nx3.elements.beams.BeamingProcessor_4dot;
import nx3.elements.beams.BeamingProcessor_4;
import nx3.elements.DVoice;
import nx3.elements.ENoteValue;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.NVoice;

/**
 * ...
 * @author Jonas Nyström
 */
class Main
{

	static public function main() 
	{
		trace('test');
		var runner = new TestRunner();
		runner.add(new TestDVoice());
		var success = runner.run();
		
		
	}
}

class TestDVoice extends TestCase 
{
	var voice6eights: NVoice;
	var voice12sixteenths: NVoice;
	public function new()
	{
		super();
		this.voice6eights = new NVoice( [ for (i in 0...6) new NNote([new NHead(0)], ENoteValue.Nv8) ] );
		this.voice12sixteenths = new NVoice( [ for (i in 0...12) new NNote([new NHead(0)], ENoteValue.Nv16) ] );
	}
	
	/*
	public function test1()
	{
		var dvoice:DVoice = new DVoice(this.voice6eights, new BeamingProcessor_4());
		this.assertEquals(dvoice.voice.notes.length, 6);
		this.assertEquals(dvoice.dnotes.length, 6);
		//this.assertEquals(dvoice.beamGroups.length, 0);
		this.assertEquals(dvoice.sumNoteValue, ENoteValue.Nv8.value * 6);
		
		
	}
	*/
	
	public function testBeamGroups1()
	{
		
		var dvoice:DVoice = new DVoice(this.voice6eights, new BeamingProcessor_4());
		this.assertEquals(dvoice.beamGroups.length, 3);		
		var dvoice:DVoice = new DVoice(this.voice6eights, new BeamingProcessor_4dot());
		this.assertEquals(dvoice.beamGroups.length, 2);
		var dvoice:DVoice = new DVoice(this.voice12sixteenths, new BeamingProcessor_4());
		this.assertEquals(ENoteValue.Nv8.value * 6, ENoteValue.Nv16.value * 12);
		this.assertEquals(dvoice.sumNoteValue, ENoteValue.Nv16.value * 12);
		this.assertEquals(3, dvoice.beamGroups.length);
		var dvoice:DVoice = new DVoice(this.voice12sixteenths, new BeamingProcessor_4dot());
		this.assertEquals(2, dvoice.beamGroups.length);
		
	}
		
	
	
}
	
