package nx.test;
import haxe.unit.TestCase;
import nx.display.DisplayBar;
import nx.element.Bar;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;

/**
 * ...
 * @author Jonas Nyström
 */

class TestDisplayBar extends TestCase
{

	public function test() {
		
		var b = Bar.getNew([Part.getNew([Voice.getNew([Note.getNew([Head.getNew(0)])])])]);
		assertTrue(b != null);
		//var db = new DisplayBar(
		
		
	}
	
}