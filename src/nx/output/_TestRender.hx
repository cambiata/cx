package nx.output;
import cx.NmeTools;
import haxe.unit.TestCase;
import nme.display.Sprite;
import nme.Lib;
import nx.core._TO;

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
	
	
	public function xtestDNoteOutput() {
		assertTrue(true);
		render.dnote(200, 100, _TO.dNoteNv4_1_p0);		
		render.dnote(300, 100, _TO.dNoteNv4_2_m1p1);		
		render.dnote(400, 100, _TO.dNoteNv4_2_p0p1);		
	}
	
	public function testDPlexOutput() {
		assertTrue(true);
		render.dplex(200, 300, _TO.dplex_2_m1_UP_p1_DN);		
	}
	
	override public function tearDown() {
		_output();		
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}

	
}