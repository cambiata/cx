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
		
		var p0 = Part.getNew([Voice.getNew([
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			])]);
		var p1 = Part.getNew([Voice.getNew([Note.getNew([Head.getNew(0)])])]);
		var db = new DisplayBar(Bar.getNew([p0, p1]));
		assertTrue(db != null);
		
		//db.getNoteXPostitions();
		
		
	}
	
}