package nx.test;
import haxe.unit.TestCase;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;

/**
 * ...
 * @author Jonas Nyström
 */

class TestPart extends TestCase
{
	
	public function test0() {
		var part = TO.getPart4_4_2v_simple(); //Part.getNew([Voice.getNew([Note.getNew([Head.getNew(0)])])]);
		assertTrue(part != null);
	}
	
	public function testXml() {
		var part = TO.getPart0();
		var xmlString = part.toXml().toString();
		var part2 = Part.fromXml(xmlString);
		assertTrue(true);
	}
	
}