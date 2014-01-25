package nx3.test;
import haxe.unit.TestCase;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;

/**
 * ...
 * @author Jonas Nyström
 */
class TestQ extends TestCase
{

	public function test1() 
	{
		var qnote = new QNote(-2);
		this.assertEquals(1,  qnote.heads.length);
		this.assertEquals( -2,  qnote.heads[0].level);
		this.assertEquals(ENoteValue.Nv4, qnote.value);
		
		var qnote = new QNote([-3, 0, 3], '# b');
		this.assertEquals(ESign.Sharp, qnote.heads[0].sign);
		this.assertEquals(ESign.None, qnote.heads[1].sign);
		this.assertEquals(ESign.Flat, qnote.heads[2].sign);
		
		
	}
	
	public function test2()
	{
		var qvoice = new QVoice([4, 8, 8, 2]);
		this.assertEquals(4, qvoice.notes.length);
	}
	
}