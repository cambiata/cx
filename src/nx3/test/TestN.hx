package nx3.test;
import haxe.unit.TestCase;
import nx3.elements.EDirectionUAD;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.io.HeadXML;
import nx3.io.NoteXML;

/**
 * ...
 * @author Jonas Nyström
 */
class TestN extends TestCase
{
	public function test1()
	{
		var item1 = new NHead(2, ESign.Flat);
		var xmlstr1= HeadXML.toXml(item1).toString();
		var item2 = HeadXML.fromXmlStr(xmlstr1);
		var xmlstr2 = HeadXML.toXml(item2).toString();
		this.assertEquals(Std.string(item1), Std.string(item2));
		this.assertEquals(xmlstr1, xmlstr2);
	}
	
	public function test2()
	{

		var item1 = new NNote([ new NHead(-3), new NHead(-2, ESign.Flat), new NHead(4, ESign.Natural), new NHead(1)], ENoteValue.Nv2dot, EDirectionUAD.Down);
		var xmlstr1= NoteXML.toXml(item1).toString();
		var item2 = NoteXML.fromXmlStr(xmlstr1);
		var xmlstr2 = NoteXML.toXml(item2).toString();
		this.assertEquals(Std.string(item1), Std.string(item2));
		this.assertEquals(xmlstr1, xmlstr2);		
		
		// verify head level sorting...
		this.assertEquals([ -3, -2, 1, 4].toString(), item1.getHeadLevels().toString());
	}
	
		
}