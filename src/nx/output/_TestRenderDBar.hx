package nx.output;
import cx.NmeTools;
import haxe.unit.TestCase;
import nme.display.Sprite;
import nme.Lib;
import nx.core._TO;
import nx.core.display.DBar;
import nx.core.display.DNote;
import nx.core.display.DPart;
import nx.core.display.Complex;
import nx.core.element.Bar;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.SpriteTools;
class _TestRenderDBar extends TestCase
{
	private var render:Render;
	private var scaling:TScaling;
	private var target:Sprite;
	private var rect:Bool;
	
	override public function setup() {
		this.target = new Sprite();
		//this.target.width = 1000;
		//this.target.height = 1000;
		this.render = new Render(this.target, Scaling.getBig());
		this.rect = true;		
	}
		

	
	override public function tearDown() {
		_output();		
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	public function testDBar() {
		assertTrue(true);
		var y = 350; 
		
		var db = new DBar(new Bar([
			new Part([
				new Voice([
					//new Note([new Head(2), new Head(0)]) ,
					new Note([new Head(-1), new Head(-3)]) ,
					new Note([new Head(1, ESign.Sharp)]) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note([new Head(-3)], ENoteValue.Nv8tri) ,
					new Note([new Head(-2)], ENoteValue.Nv8tri) ,
					new Note() ,
					
				], EDirectionUAD.Up), 
				
				
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv4dot),
					
					
					new Note([new Head(4, ESign.Natural)], ENoteValue.Nv8),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(8)], ENoteValue.Nv16),
					new Note([new Head(3, ESign.Natural)], ENoteValue.Nv16),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(1, ESign.Flat)]) ,
					new Note([new Head( -6), new Head( -7)]) ,
					
					new Note([new Head(8), new Head(7)], ENoteValue.Nv1) ,
					
					
				], EDirectionUAD.Down),
				
			]),
			
			
			new Part([
				new Voice([
					new Note([new Head(), new Head(-1)], 	ENoteValue.Nv4) ,
					
					
					new Note([new Head(1, ESign.Flat)],  		ENoteValue.Nv8) ,
					new Note([new Head(4, ESign.None)],  	ENoteValue.Nv8) ,
					new Note([new Head(1, ESign.Sharp), new Head(2, ESign.Flat)],  		ENoteValue.Nv8dot) ,
					new Note([new Head(-3, ESign.Flat)],  	ENoteValue.Nv16) ,
					new Note([new Head(1)]) ,
					
					
				])
			]),
			
			
		]));
		
		//render.dbar(100, y, db, null, true);
		
		/*
		var db = new DBar(new Bar([		
			new Part([
				new Voice([
					new Note([new Head(-1), new Head(0), new Head(-2)], ENoteValue.Nv1) ,
				], EDirectionUAD.Up), 
				new Voice([
					new Note([new Head(1)], ENoteValue.Nv1),
				], EDirectionUAD.Down),
			]),		
		]));
		*/
		
		//render.dbar(100, 800, db, null, true);		
		
		/*
		var db = new DBar(new Bar([		
			new Part([new Voice([
				new Note(null, ENoteValue.Nv2) ,				
				new Note(null, ENoteValue.Nv4) ,				
				new Note(null, ENoteValue.Nv4) ,				
				new Note(null, ENoteValue.Nv8) ,				
				new Note(null, ENoteValue.Nv8) ,				
				//new Note([new Head(0, ESign.Flat)], ENoteValue.Nv8) ,
				new Note(null, ENoteValue.Nv16) ,
				new Note(null, ENoteValue.Nv16) ,
				//new Note(null, ENoteValue.Nv16) ,
				new Note([new Head(4, ESign.Sharp)], ENoteValue.Nv16) ,
				new Note(null, ENoteValue.Nv16) ,				
				//new Note(null, ENoteValue.Nv16) ,				
				new Note(null, ENoteValue.Nv4) ,				
				new Note(null, ENoteValue.Nv4) ,				
			], EDirectionUAD.Up)]),			
		]));
		*/
		
		render.lines(0, 100, 1200);
		render.lines(0, 280, 1200);
		
		render.dbar(100, 100, db, 0, false);				
		render.dbar(100, 500, db, 800, false);				
		
		/*
		render.dbar(100, 500, db, 600, true);				
		render.dbar(100, 600, db, 700, true);				
		render.dbar(100, 700, db, 800, true);				
		*/
	}
		
	


	
}