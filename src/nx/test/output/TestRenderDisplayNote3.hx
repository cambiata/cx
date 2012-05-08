package nx.test.output;
import nx.display.DisplayNote;
import nx.element.Head;
import nx.element.Note;
import nx.element.pre.PreApoggiatura;
import nx.element.pre.PreArpeggio;
import nx.output.Render;
import nx.test.base.RenderBase;
import nx.enums.EDirectionUD;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;
/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
class TestRenderDisplayNote3 extends RenderBase
{
	public function test3() {
		Render.drawRects = true;
		assertTrue(true);
		var x = 100;
		var y = 100;
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)]));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(1)]));
		
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(100, y, dn1);
		render.note(100+distance, y, dn2);
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(1)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(200, y, dn1);
		render.note(200+distance, y, dn2);
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(2)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(300, y, dn1);
		render.note(300+distance, y, dn2);		
	
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)]));
		dn1.setDirection(EDirectionUD.Up);
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(4, ESign.Natural)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(400, y, dn1);
		render.note(400+distance, y, dn2);			
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)]));
		dn1.setDirection(EDirectionUD.Up);
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(3, ESign.Natural)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(500, y, dn1);
		render.note(500+distance, y, dn2);			
		
		
		var y = 300;	
		render.clef(10, y);
		render.lines(10, y, 900);		
		
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(1, ESign.Flat)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(200, y, dn1);
		render.note(200+distance, y, dn2);
		
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(5, ESign.Flat)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(300, y, dn1);
		render.note(300+distance, y, dn2);
		
		
		dn1.setDirection(EDirectionUD.Up);
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(400, y, dn1);
		render.note(400+distance, y, dn2);		
		
		
		dn1.setDirection(EDirectionUD.Up);
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(3, ESign.Flat)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(500, y, dn1);
		render.note(500+distance, y, dn2);			
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(3)]));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(-1, ESign.Flat)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(600, y, dn1);
		render.note(600+distance, y, dn2);		
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(1)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(700, y, dn1);
		render.note(700 + distance, y, dn2);		
		
		var dn1 = new DisplayNote(Note.getNew([Head.getNew(0)], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([Head.getNew(1, ESign.Flat)]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(800, y, dn1);
		render.note(800+distance, y, dn2);				
		
		var y = 500;	
		render.clef(10, y);
		render.lines(10, y, 900);		
		
		var h1 = Head.getNew(0); h1.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(2); h2.setApoggiatura(new PreApoggiatura());
		var dn1 = new DisplayNote(Note.getNew([h1], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([h2]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(100, y, dn1);
		render.note(100+distance, y, dn2);		
		
		var h1 = Head.getNew(0); h1.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(1); h2.setApoggiatura(new PreApoggiatura());
		var dn1 = new DisplayNote(Note.getNew([h1], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(Note.getNew([h2]));
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(200, y, dn1);
		render.note(200 + distance, y, dn2);	
		
		var h1 = Head.getNew(0); h1.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(1); h2.setApoggiatura(new PreApoggiatura());
		var n2 = Note.getNew([h2]);
		n2.setArpeggio(new PreArpeggio());
		var dn1 = new DisplayNote(Note.getNew([h1], ENoteValue.Nv4dot));
		var dn2 = new DisplayNote(n2);
		var distance = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.note(300, y, dn1);
		render.note(300+distance, y, dn2);				
		
		//this.spriteSave('test3.png');
	}	
	
}