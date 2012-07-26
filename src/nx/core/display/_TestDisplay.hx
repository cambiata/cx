package nx.core.display;
import haxe.unit.TestCase;
import nme.geom.Rectangle;
import nx.core._TO;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ESign;
import nx.output.Render;
import nx.output.TScaling;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.core.util.RectangleUtils;
class _TestDisplay extends TestCase 
{

	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	
	
	public function testDNote() {		
		
		assertEquals(new DNote(new Note([new Head(0, ESign.Sharp)])).dheads[0].sign, ESign.Sharp);
		
		
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
		/*
		var dp = _TO.dplex_2_m1_UP_p1_DN; // new DPlex([_TO.dNoteNv4_1_m1_UP, _TO.dNoteNv4_1_p1_DN]);
		var dp = _TO.dplex_2_m1_UP_p0_DN;
		
		assertEquals(_TO.dplex_2_m1_UP_p1_DN.dnoteX(1), 0);
		assertEquals(_TO.dplex_2_m1_UP_p0_DN.dnoteX(1), 3);
		assertEquals(_TO.dplex_2_p0_UP_p0_DN.dnoteX(1), 4);
		*/
		
		assertEquals(new DPlex([new DNote(new Note([new Head(0, ESign.Sharp)]))]).dnote(0).dhead(0).sign, ESign.Sharp);
		
	}
	
	
}







