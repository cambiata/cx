package nx.test;
import haxe.Stack;
import nx.display.DisplayNote;
import nx.display.utils.DisplayNoteUtils;
import nx.element.Note;
import nx.element.Head;
import nx.test.base.TestBasePng;
import nx.enums.ESign;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
import nx.output.Scaling;
import nx.output.Render;

/**
 * ...
 * @author Jonas Nyström
 */

class TestRenderDisplayNote extends TestBasePng
{
	public function test0() {
		var y = 100;
		var x = 150;
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		
		var scaling = Scaling.getBig();
		var render = new Render(this.sprite, scaling);		
		render.clef(10, y);
		render.lines(10, y, 900);
		render.note(x, y, dn);	
		render.noteRects(x, y, dn);
		
		dn.setDirection(EDirectionUD.Down);		
		var x = 300;
		render.note(x, y, dn);	
		render.noteRects(x, y, dn);
		
		var y = 200;
		var render = new Render(this.sprite, Scaling.getNormal());		
		render.clef(10, y);
		render.lines(10, y, 900);
		render.note(x, y, dn);	

		var y = 300;
		var render = new Render(this.sprite, Scaling.getSmall());		
		render.clef(10, y);
		render.lines(10, y, 900);
		render.note(x, y, dn);			

		
		var y = 100;		
		var render = new Render(this.sprite, Scaling.getBig());

		var x = 500;
		var dnOver = new DisplayNote(Note.getNew([Head.getNew(2)]), EDirectionUD.Up);
		//render.note(x, y, dnOver);	
		render.noteRects(x, y, dnOver);
		
		var x = 600;
		var dnUnder = new DisplayNote(Note.getNew([Head.getNew(2)]), EDirectionUD.Down);
		//render.note(x, y, dnUnder);	
		render.noteRects(x, y, dnUnder);
		//DisplayNoteUtils.overlapHeads(dnOver, dnUnder);
		
		assertTrue(true);
	}
	

}