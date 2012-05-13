package nx.test.output;
import nx.display.DisplayBar;
import nx.display.DisplayNote;
import nx.element.post.PostTie;
import nx.element.pre.PreTie;
import nx.enums.ESign;
import nx.test.base.RenderBase;
import nx.element.Bar;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
class TestRenderDisplayBar extends RenderBase
{

	public function test0() {
		
		var p0 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1), Head.getNew(-0)]),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)]),
				//Note.getNew([Head.getNew(-1)]),
				/*
				Note.getNew([Head.getNew(-1), Head.getNew(0)]),
				Note.getNew([Head.getNew(-1, ESign.Flat)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				]).setDirection(EDirectionUAD.Up), 
				
			Voice.getNew([
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),

				/*
				Note.getNew([Head.getNew(2)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv2),
				*/
				
				]).setDirection(EDirectionUAD.Down), 
				
			]);
			
		var p1 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(0)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(0, ESign.Flat)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(0)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(0)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(0)]),
				/*
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				//Note.getNew([Head.getNew(-1)]),
				//Note.getNew([Head.getNew(-1)], ENoteValue.Nv8dot),
				]).setDirection(EDirectionUAD.Up), 
			/*	
			Voice.getNew([
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)]),				
				Note.getNew([Head.getNew(2)]),				
				]).setDirection(EDirectionUAD.Down), 
				*/
				
			]);		
			
		var h = Head.getNew( -2);
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew( -1);
		h2.setTieTo(new PreTie());
		
		var p2 = Part.getNew([Voice.getNew([
			Note.getNew([h], ENoteValue.Nv2),
			//Note.getNew([Head.getNew(-3)], ENoteValue.Nv2),
			Note.getNew([h2], ENoteValue.Nv2),
			
			/*
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)]),
			*/
			])]);		
			
			
		var db = new DisplayBar(Bar.getNew([p0,/* p1, p2*/]));
		trace(db.getEndXPosition());
		assertTrue(db != null);
		
		trace(db.getDisplayNotePositionsArray());
		trace(db.getDisplayNoteValuesArray());
		trace(db.getDisplayNoteXOwingArray());
			
		
		var x = 100;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				render.note(x2, y, dn);
				render.noteRects(x2, y, dn);
			}
			y += 200;
		}	
		
		var x = 500;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + db.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				render.note(x2, y, dn);
				render.noteRects(x2, y, dn);
			}
			y += 200;
		}			
		
		
	}
	
}