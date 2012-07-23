package nx.core.display;
import haxe.unit.TestCase;
import nme.geom.Rectangle;
import nx.core._TO;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
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
		assertEquals(_TO.dNoteNv4_1_m1.direction, EDirectionUD.Down);
		assertEquals(_TO.dNoteNv4_1_p1.direction, EDirectionUD.Up);
		assertEquals(_TO.dNoteNv4_1_m1_UP.direction, EDirectionUD.Up);
		assertEquals(_TO.dNoteNv4_1_p1_DN.direction, EDirectionUD.Down);

		
		assertEquals(_TO.dNoteNv4_2_p0p1.direction, EDirectionUD.Up);
		assertEquals(_TO.dNoteNv4_2_p0p1_DN.direction, EDirectionUD.Down);
		assertEquals(_TO.dNoteNv4_2_m1p0.direction, EDirectionUD.Down);
		assertEquals(_TO.dNoteNv4_2_m1p0_UP.direction, EDirectionUD.Up);
		
		
		assertEquals(_TO.dNoteNv4_1_p0.rectHeads.toString(), new Rectangle( -2, -1, 4, 2).toString());
		assertEquals(_TO.dNoteNv4_2_p0p1.rectHeads.toString(), new Rectangle( -2, -1, 6, 3).toString());
		assertEquals(_TO.dNoteNv4_2_m1p0.rectHeads.toString(), new Rectangle( -4, -2, 6, 3).toString());
	}

	public function testDPlex() {
		assertTrue(true);
		var dp = new DPlex([_TO.dNoteNv4_1_m1_UP, _TO.dNoteNv4_1_p1]);
	}
	
	
}







