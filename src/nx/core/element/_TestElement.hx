package nx.core.element;
import haxe.unit.TestCase;
import nx.enums.EDirectionUAD;
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
		
		
		var n = new Note([new Head( -3, ESign.Flat), new Head( -1), new Head(3, ESign.Natural)], ENoteValue.Nv16dot, EDirectionUAD.Down);
		var xml = n.toXml().toString();
		trace(xml);
		var n2 = Note.fromXmlStr(xml);
		//trace(n2);
		
		//assertEquals(n.toXml().toString(), n2.toXml().toString());
		
		
		
	}

	
}