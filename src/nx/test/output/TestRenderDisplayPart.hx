package nx.test.output;
import cx.ObjectHash;
import nx.display.DisplayNote;
import nx.display.DisplayPart;
import nx.display.DisplayVoice;
import nx.element.Part;
import nx.element.Voice;
import nx.element.Note;
import nx.element.Head;
import nx.enums.EDirectionUAD;
import nx.enums.ESign;
import nx.output.Render;
import nx.test.base.RenderBase;
import nx.test.TO;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
using nx.output.Scaling;
class TestRenderDisplayPart extends RenderBase
{
	public function test0() {
		assertTrue(true);
		//Render.drawRects = true;
		
		var v0 = Voice.getNew([
				Note.getNew([Head.getNew(-1), Head.getNew(-2)]),
				Note.getNew([Head.getNew(-1, ESign.Flat)]),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(0), Head.getNew(1)]),
			]).setDirection(EDirectionUAD.Up);

		var v1 = Voice.getNew([
				Note.getNew([Head.getNew(1)]),
				Note.getNew([Head.getNew(0/*, ESign.Sharp*/)]),
				Note.getNew([Head.getNew(1)]),
				Note.getNew([Head.getNew(1), Head.getNew(3)]),
			]).setDirection(EDirectionUAD.Down);
			
		var dp = new DisplayPart(Part.getNew([v0, v1]));		
		
		var x = 100.0;
		var y = 100;
		
		var x2 = 0;
		for (dn in dp.getDisplayNotesSequence()) {			
			var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
			render.note(x2, y, dn);
		}		

		x = 500;
		x2 = 0;
		for (dn in dp.getDisplayNotesSequence()) {			
			var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
			render.note(x2, y, dn);
		}
			
	}
	
	
}