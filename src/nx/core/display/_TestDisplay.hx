package nx.core.display;
import haxe.unit.TestCase;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.output.Render;
import nx.output.TScaling;

/**
 * ...
 * @author Jonas Nyström
 */

class _TestDisplay extends TestCase 
{

	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	public function testDNote() {		
		var dn = _TestDNote.simple0;
		assertTrue(dn != null);
	}
	
}


class _TestDNote {	
	static public var simple0 = new DNote(new Note([new Head()]));
}