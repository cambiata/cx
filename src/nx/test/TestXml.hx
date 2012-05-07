package nx.test;
//import cx.FileTools;
import haxe.unit.TestCase;
import nx.element.Head;
import nx.element.Note;
import nx.element.Voice;
import nx.enums.ENoteValue;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

 
	enum EColor {
		red;
		green;
		blue;
	}
 
class TestXml extends TestCase
{
	public function testHead() {
		var h = Head.getNew(2, ESign.DoubleSharp);
		var xmlStr = h.toXml().toString();
		var h2 = Head.fromXml(xmlStr);
		assertEquals(h.toString(), h2.toString());
	}
	
	public function testNote() {
		var n = Note.getNew([Head.getNew(5, ESign.DoubleSharp), Head.getNew(-3)], ENoteValue.Nv2dot);
		var xmlStr = n.toXml().toString();
		var n2 = Note.fromXml(xmlStr);
		//trace(xmlStr);
		//trace(n.toStringExt());
		//trace(n2.toStringExt());		
		assertEquals(n.toString(), n2.toString());
		//FileTools.putContent('note.xml', n2.toXml().toString());
	}
	
	public function testVoic() {
		
		var v = TO.getVoice0();
		var xmlStr = v.toXml().toString();
		//trace(xmlStr);
		var v2 = Voice.fromXml(xmlStr);
		assertEquals(v.toString(), v2.toString());
		//FileTools.putContent('voice.xml', v2.toXml().toString());
		
	}
}