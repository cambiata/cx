package nx3.test;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.test.QNote.QNote4;

/**
 * ...
 * @author Jonas Nyström
 */

 class TestQ extends   haxe.unit.TestCase 
{

	public function test0()
	{
		this.assertTrue(true);
	}
	
	/*
	public function test1() 
	{
		var nnote = new QNote(-2);
		this.assertEquals(1,  nnote.nheads.length);
		this.assertEquals( -2,  nnote.nheads[0].level);
		this.assertEquals(ENoteValue.Nv4, nnote.value);

		var nnote = new QNote4(1, '#');
		this.assertEquals(ESign.Sharp, nnote.nheads[0].sign);		
		
		var nnote = new QNote4([1], '#');
		this.assertEquals(ESign.Sharp, nnote.nheads[0].sign);
		
		var nnote = new QNote([-3, 0, 3], '# b');
		this.assertEquals(ESign.Sharp, nnote.nheads[0].sign);
		this.assertEquals(ESign.None, nnote.nheads[1].sign);
		this.assertEquals(ESign.Flat, nnote.nheads[2].sign);
	}
	
	public function test2()
	{
		var nvoice = new QVoice([4, 8, 8, 2]);
		this.assertEquals(4, nvoice.nnotes.length);
	}
	*/
}