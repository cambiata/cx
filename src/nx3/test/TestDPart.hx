package nx3.test;
import haxe.unit.TestCase;
import nx3.elements.DPart;
import nx3.elements.NPart;
import nx3.test.QHead.QHeadSharp;
import nx3.test.QVoice;
/**ele
 * ...
 * @author Jonas Nyström
 */
class TestDPart extends TestCase
{
	public function testPartNew() 
	{
		var dpart:DPart = new DPart(new NPart([new QVoiceUp(2, [-1], 2), new QVoiceDown(4, [1], 4)]));
		this.assertTrue(Std.is(dpart, DPart));
		this.assertEquals(dpart.dvoices.length, 2);
	}

	public function testPositions()
	{
		var dpart:DPart = new DPart(new NPart([new QVoiceUp(2, [-1], 2), new QVoiceDown(4, [1], 4)]));
		this.assertEquals(dpart.positions.toString(), [0, 3024, 6048, 9072].toString());
		var dpart:DPart = new DPart(new NPart([new QVoiceUp(2, [-1], 2), /* new QVoiceDown(4, [1], 4)*/]));
		this.assertEquals(dpart.positions.toString(), [0,  6048].toString());
		var dpart:DPart = new DPart(new NPart([new QVoiceDown(4, [1], 4)]));
		this.assertEquals(dpart.positions.toString(), [0, 3024, 6048, 9072].toString());
	}
	
	public function testComplexes()
	{
		var dpart:DPart = new DPart(new NPart([new QVoiceUp(2, [ -1], 2), new QVoiceDown(4, [1], 4)]));
		
		this.assertEquals(dpart.dcomplexes.length, 4);
		this.assertEquals(dpart.dcomplexes[0].dnotes.length, 2);
		this.assertEquals(dpart.dcomplexes[1].dnotes.length, 1);
		this.assertEquals(dpart.dcomplexes[2].dnotes.length, 2);
		this.assertEquals(dpart.dcomplexes[3].dnotes.length, 1);
	}
		
}