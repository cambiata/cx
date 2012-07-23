package nx.core.element;
import haxe.unit.TestCase;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class _TestElement extends TestCase
{
	
	/*
	 * *********************************************************
	 * Test nx.core.element.Head
	 * *********************************************************
	 *
	*/		
	public function testHead() {		
		
		var h = new Head();
		assertEquals(h.level, 0);
		assertEquals(h.sign, ESign.None);
		
		h = new Head( -1);
		assertEquals(h.level, -1);
		
		h = new Head(1, ESign.Sharp);
		assertEquals(h.level, 1);
		assertEquals(h.sign, ESign.Sharp);				
	}
	
	public function testNote() {
		var n = new Note([new Head()]);
		assertEquals(n.heads.length, 1);
		assertEquals(n.notevalue, ENoteValue.Nv4);
	}

	
}