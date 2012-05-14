package nx.test;
import haxe.unit.TestCase;
import nx.element.Bar;
import nx.enums.ETime;

/**
 * ...
 * @author Jonas Nyström
 */

class TestBar extends TestCase
{

	public function test0() 
	{
		var b = Bar.getNew([TO.getPart0()]);
		b.setTime(ETime.T4_4);
		var xmlString = b.toXml().toString();
		//trace(xmlString);
		
		var b2 = Bar.fromXml(xmlString);
		//trace(b2.toXml().toString());
		
		assertEquals(b.toXml().toString(), b2.toXml().toString());
		
	}
	
}