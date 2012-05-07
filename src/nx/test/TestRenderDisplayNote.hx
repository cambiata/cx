package nx.test;
import cx.NmeTools;
import haxe.Stack;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.geom.Point;
import nme.geom.Rectangle;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.BeamingProcessor_4dot;
import nx.display.DisplayNote;
import nx.display.DisplayVoice;
import nx.display.utils.DisplayNoteUtils;
import nx.element.Note;
import nx.element.Head;
import nx.element.post.PostTie;
import nx.element.pre.PreApoggiatura;
import nx.element.pre.PreArpeggio;
import nx.element.pre.PreClef;
import nx.element.pre.PreTie;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.output.TScaling;
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
using cx.NmeTools;
using nx.display.utils.DisplayNoteUtils;
using nx.output.Scaling;

class TestRenderDisplayNote extends TestBasePng
{
	private var render:Render;
	private var scaling:TScaling;
	override function setup() {
		super.setup();		
		var y = 100;		
		this.scaling = Scaling.getMid();
		this.render = new Render(this.sprite, this.scaling);	
		Render.drawRects = true;
		render.clef(10, y);
		render.lines(10, y, 980);		
		render.clef(10, 300);
		render.lines(10, 300, 980);		
		render.clef(10, 500);
		render.lines(10, 500, 980);		
	}
	
	public function test0() {
		var y = 100;
		//var scaling = Scaling.getBig();		
		//var render = new Render(this.sprite, scaling);

		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		
		var x = 150;
		render.note(x, y, dn);	
		
		dn.setDirection(EDirectionUD.Down);		
		var x = 300;
		render.note(x, y, dn);	
		
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

		//this.spriteSave('test0.png');
		assertTrue(true);
	}
	
	public function test1() {
		assertTrue(true);
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
		//this.spriteSave('test1.png');
	}
	
	/*
	public function test2() {		
		
		//var render = new Render(this.sprite, Scaling.getBig());
		var x = 100;
		var y = 100;
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		render.note(100, y, dn);
		//Render.drawRects = true;
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)]));
		render.note(200, y, dn);
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)], ENoteValue.Nv4dot));
		render.note(300, y, dn);

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot));
		render.note(400, y, dn);

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot), EDirectionUD.Up);
		render.note(500, y, dn);

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4ddot), EDirectionUD.Up);
		render.note(600, y, dn);
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var dn = new DisplayNote(Note.getNew([h]));
		render.note(700, y, dn);
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(800, y, dn);
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(-2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(900, y, dn);
		
		
		var y = 300;		
		render.clef(10, y);
		render.lines(10, y, 980);			
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		render.note(100, y, dn);
		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)]));
		render.note(200, y, dn);
		
		var h = Head.getNew(0); // 
		h.setApoggiatura(new PreApoggiatura());		
		var dn = new DisplayNote(Note.getNew([h]));		
		render.note(300, y, dn);

		var h = Head.getNew(0, ESign.Sharp); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3, ESign.Natural); h2.setApoggiatura(new PreApoggiatura());
		var h3 = Head.getNew(-4); h3.setApoggiatura(new PreApoggiatura());				
		var dn = new DisplayNote(Note.getNew([h, h2, h3, Head.getNew(1)]));
		render.note(400, y, dn);
		
		var h = Head.getNew(0); 
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew(-4); h3.setApoggiatura(new PreApoggiatura());
		var dn = new DisplayNote(Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]));
		render.note(500, y, dn);

		var h = Head.getNew(0); 
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(650, y, dn);
		
		var h = Head.getNew(0); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(750, y, dn);
		
		var h = Head.getNew(0); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(900, y, dn);
		
		var y = 500;		
		render.clef(10, y);
		render.lines(10, y, 980);			
		
		var h = Head.getNew(0, ESign.Flat);
		h.setTieTo(new PreTie());
		h.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, Head.getNew(3)]);
		n.setClef(new PreClef(EClef.ClefC, -3));
		n.setArpeggio(new PreArpeggio());
		var dn = new DisplayNote(n);
		render.note(300, y, dn);
	
		this.spriteSave('test2.png');
		assertTrue(true);		
	}
	*/
	
	public function test3() {
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
	
	public function test4() {		
		var y = 100;		
		
		var h1 = Head.getNew(0, ESign.Flat);		
		var n1 = Note.getNew([h1], ENoteValue.Nv4dot);		
		var dn1 = new DisplayNote(n1);
		//render.note(300, y, dn1);
		render.noteARects(300, y, dn1);		
		var h2 = Head.getNew(5, ESign.Sharp);		
		var n2= Note.getNew([h2]);		
		var dn2 = new DisplayNote(n2);
		
		render.noteARects(300, y, dn2, 0x00FF00);		
		var move = dn1.getNoteDistanceX(dn2).scaleX(this.scaling);
		render.noteARects(600, y, dn1);
		render.noteARects(600+move, y, dn2, 0x0000FF);
		
		//this.spriteSave('test4.png');
		assertTrue(true);
	}
	
	public function testDisplayVoice() {
		
		var v = TO.getVoiceOneBar4_4_Nv8s_02();

		var y = 100;
		var dv = new DisplayVoice(v);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}
		
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, null, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, null, new BeamingProcessor_4dot ());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}				
		
		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down, new BeamingProcessor_4dot());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}

		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up, new BeamingProcessor_4dot());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}
		
		//trace(dv.getBeamlist());		
		this.spriteSave('displayVoice.png');
		
		assertTrue(true);
		
	}
	
	public function testNme() {		
		var r1 = new Rectangle(0, 0, 2, 2);
		var r2 = new Rectangle(1, 1, 2, 2);
		var r3 = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 1);
		assertEquals(r3.height, 1);
		
		var r2 = new Rectangle(0, 1, 3, 2);
		var r3 = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 2);
		assertEquals(r3.height, 1);
		
		var r2 = new Rectangle(-1, 1, 4, 2);
		var r3:Rectangle = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 3);
		assertEquals(r3.height, 1);

		var r2 = new Rectangle(0, 1, 1, 2);
		var r3:Rectangle = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 2);
		assertEquals(r3.height, 1);		
		
		var r2 = new Rectangle(-1, 1, 2, 2);
		var r3:Rectangle = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 3);
		assertEquals(r3.height, 1);			

		/*
		var r2 = new Rectangle(-2, 1, 2, 2);
		var r3:Rectangle = NmeTools.intersection2(r1, r2);
		assertEquals(r3.width, 4);
		assertEquals(r3.height, 1);			
		*/
		
	}

}