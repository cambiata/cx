package nx.core.display;
import haxe.unit.TestCase;
import nx.core._TO;
import nx.core.element.Bar;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.core.util.GeomUtils;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.output.Render;
import nx.output.TScaling;
import nme.geom.Rectangle;
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
		assertEquals(_TO.dNoteNv4_2_p0p1.rectHeads.toString(), new Rectangle( -2, -1, 8, 3).toString());
		assertEquals(_TO.dNoteNv4_2_m1p0.rectHeads.toString(), new Rectangle( -6, -2, 8, 3).toString());
	}
	
	public function testDNote2() {
		
		// staves
		
		var dn = new DNote(new Note([new Head()], ENoteValue.Nv4, EDirectionUAD.Up));
		assertEquals(dn.direction, EDirectionUD.Up);
		assertEquals(dn.rectHeads.toString(), new Rectangle(-2, -1, 4, 2).toString());
		//assertEquals(dn.rectStave.toString(), new Rectangle(2, -7, 4, 8+Constants.STAVE_OFFSET).toString());
		
		var dn = new DNote(new Note([new Head()], ENoteValue.Nv4, EDirectionUAD.Down));
		assertEquals(dn.direction, EDirectionUD.Down);
		assertEquals(dn.rectHeads.toString(), new Rectangle(-2, -1, 4, 2).toString());
		//assertEquals(dn.rectStave.toString(), new Rectangle(-2, -1, 4, 8-Constants.STAVE_OFFSET).toString());
		
		// dots
		
		var dn = new DNote(new Note([new Head()], ENoteValue.Nv4dot));
		//trace(dn.rectDots);
	}
	
	public function testDVoice() {
		assertTrue(true);
		var dv = new DVoice(Voice._test0());
	}
	
	public function testDPart() {
		assertTrue(true);		
		var dp = new DPart(new Part([Voice._test0(), Voice._test2()]));
		//trace(dp.positions);
		//race(dp.dplexs);
	}
	
	public function testDBar() {
		assertTrue(true);
		
		var db = new DBar(new Bar([
			new Part([new Voice([
				new Note() ,
				new Note() ,
				new Note() ,
				new Note() ,
			])]),
			new Part([new Voice([
				new Note(null, ENoteValue.Nv2) ,
				new Note(null, ENoteValue.Nv2) ,
			])]),		
			/*
			new Part([new Voice([
				new Note(null, ENoteValue.Nv2dot) ,
				new Note() ,
			])]),
			*/
		]));
		
		assertEquals(db.dparts.length, 2);
		
	}

	public function testDPlex() {
		assertTrue(true);
		assertEquals(_TO.dplex_2_m1_UP_p1_DN.dnoteXshift(1), 0);
		assertEquals(_TO.dplex_2_m1_UP_p0_DN.dnoteXshift(1), 3);
		assertEquals(_TO.dplex_2_p0_UP_p0_DN.dnoteXshift(1), 4);
		assertEquals(new DPlex([new DNote(new Note([new Head(0, ESign.Sharp)]))]).dnote(0).dhead(0).sign, ESign.Sharp);
	}
	
	
}







