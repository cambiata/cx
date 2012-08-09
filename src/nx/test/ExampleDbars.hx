package nx.test;
import nx.core.display.DBar;
import nx.core.element.Bar;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.ESign;
import nx.enums.ENoteValue;


/**
 * ...
 * @author Jonas Nyström
 */
/*
 
	private function init(e) {

		var dbar = ExampleDbars.dbarComplex1();
		
		var sprite:Sprite = new Sprite();
		sprite.graphics.beginFill(0xFF0000);
		sprite.graphics.drawRect(0, 0, 50, 50);
		
		var render = new Render(sprite, Scaling.getNormal());
		render.lines(0, 100, 1200);				
		render.dbar(100, 100, dbar, 0, false);
		
		var render = new Render(sprite, Scaling.getMid());
		render.lines(0, 400, 1200);				
		render.dbar(100, 400, dbar, 0, false);
		
		this.addChild(sprite);
	}


*/
 
class ExampleDbars 
{
	static public function dbarComplex1() { 
		return new DBar(new Bar([
			
			new Part([				
				new Voice([
					new Note([new Head(-1), new Head(-3)]) ,
					new Note([new Head(1, ESign.Sharp)]) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note([new Head(-3)], ENoteValue.Nv8tri) ,
					new Note([new Head(-2)], ENoteValue.Nv8tri) ,
					new Note() ,
				], EDirectionUAD.Auto), 
				
				
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(4, ESign.Natural)], ENoteValue.Nv8),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(8)], ENoteValue.Nv16),
					new Note([new Head(4, ESign.Flat)], ENoteValue.Nv16),
					new Note([new Head(5)], ENoteValue.Nv16),
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
	}
}