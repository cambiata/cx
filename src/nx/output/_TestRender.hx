package nx.output;
import cx.NmeTools;
import haxe.unit.TestCase;
import nme.display.Sprite;
import nme.Lib;
import nx.core._TO;
import nx.core.display.DNote;
import nx.core.display.DPlex;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.enums.EDirectionUAD;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.SpriteTools;
class _TestRender extends TestCase
{
	private var render:Render;
	private var scaling:TScaling;
	private var target:Sprite;
	
	override public function setup() {
		this.target = new Sprite();
		this.render = new Render(this.target, Scaling.getBig());
		render.lines(0, 100, 800);
		render.clef(20, 100);
		render.lines(0, 300, 800);
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	public function testDNoteOutput() {
		assertTrue(true);
		render.dnote(200, 100, _TO.dNoteNv4_1_p0);		
		render.dnote(300, 100, _TO.dNoteNv4_2_m1p1);		
		render.dnote(400, 100, _TO.dNoteNv4_2_p0p1);
		
		render.dnote(500, 100, new DNote(new Note([new Head( -1), new Head(0), new Head(1)])));
	}
	
	public function testDPlexOutput() {
		assertTrue(true);
		
		render.dplex(200, 300, _TO.dplex_2_m1_UP_p1_DN);		
		render.dplex(300, 300, _TO.dplex_2_m1_UP_p0_DN);		
		render.dplex(400, 300, _TO.dplex_2_p0_UP_p0_DN);		
		
		var dp = new DPlex([
			new DNote(new Note([new Head( -1), new Head( -2)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0)], null, EDirectionUAD.Down)),
		]);
		render.dplex(500, 300, dp);		
		
		var dp = new DPlex([
			new DNote(new Note([new Head( -1), new Head( -2)], null, EDirectionUAD.Down)),
			new DNote(new Note([new Head(0)], null, EDirectionUAD.Down)),
		]);
		render.dplex(600, 300, dp);		
		
		
		var dp = new DPlex([
			new DNote(new Note([new Head( -1, ESign.Sharp)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.dplex(700, 300, dp);				
		
		
	}
	
	override public function tearDown() {
		_output();		
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}

	
}