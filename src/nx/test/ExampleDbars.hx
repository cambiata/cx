package nx.test;
import nx.core.display.DBar;
import nx.core.element.Bar;
import nx.core.element.Bars;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.enums.EAttributeDisplay;
import nx.enums.EBarline;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.enums.EKey;
import nx.enums.ENoteType;
import nx.enums.EPartType;
import nx.enums.ESign;
import nx.enums.ENoteValue;
import nx.enums.ETie;
import nx.enums.ETime;
import nx.enums.EVoiceType;


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
	static public function dbarVoiceEmpty() {
		return new DBar(new Bar([
			new Part([
				new Voice(EVoiceType.Barpause)
			], EClef.ClefG, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),
			
			new Part([
				new Voice(EVoiceType.Barpause, null)
			], EClef.ClefG, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),
			
			new Part([
				new Voice()
			], EClef.ClefG, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),			
			
			
			/*
			new Part(EPartType.Lyrics, [
				new Voice([
					new Note(), 
					new Note(), 
					new Note(), 
					new Note(), 	 					
				])
			], EClef.ClefF, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),
			*/			
			
		], ETime.T3_4, null));				
	}	
	
	
	static public function dbarLyrics() {
		return new DBar(new Bar([
			new Part([
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv8dot), 
					new Note([new Head(0)], ENoteValue.Nv16), 
					new Note([new Head(2)], ENoteValue.Nv8), 
					new Note([new Head(-1)], ENoteValue.Nv8), 
					new Note(ENoteValue.Nv8), 
					new Note(ENoteValue.Nv8), 
				])
			], EClef.ClefG, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),
			
			new Part(EPartType.Lyrics, [
				new Voice([
					new Note(ENoteValue.Nv8dot, ENoteType.Lyric, 'Ut-'), 
					new Note(ENoteValue.Nv16, ENoteType.Lyric, 'i'), 
					new Note(ENoteValue.Nv8, ENoteType.Lyric, 'vår'), 
					new Note(ENoteValue.Nv8, ENoteType.Lyric, 'ha-'), 					
					new Note(ENoteValue.Nv8, ENoteType.Lyric, 'ge'), 					
					new Note(ENoteValue.Nv8, ENoteType.Lyric, 'där'), 					
				])
			]),
		], ETime.T3_4, null));				
	}
	
	
	static public function dbarAttributes() {
		return new DBar(new Bar([
			new Part([
				new Voice([
					new Note(), 
					
					new Note(null, ENoteValue.Nv8),
					new Note(null, ENoteValue.Nv8),
					new Note(null, ENoteValue.Nv16),
					new Note(null, ENoteValue.Nv16),
					new Note(null, ENoteValue.Nv16),
					new Note(null, ENoteValue.Nv16),
					new Note(null, ENoteValue.Nv8dot),
					new Note(null, ENoteValue.Nv16),
					new Note(),
					
				])
			], EClef.ClefG, EAttributeDisplay.Always, EKey.Flat3, EAttributeDisplay.Layout, 'Part1'),
			new Part(null, EClef.ClefC, EAttributeDisplay.Layout, EKey.Sharp5, EAttributeDisplay.Never, 'part two'),
			new Part(null, EClef.ClefF, EAttributeDisplay.Never, EKey.Sharp4, EAttributeDisplay.Always),
		], ETime.T3_4, EAttributeDisplay.Always, EBarline.Double));
	}
	
	
	static public function dbarComplex1() { 
		return new DBar(new Bar([			
			new Part([				
				new Voice([
					new Note([new Head(-1), new Head(-3)]) ,
					new Note([new Head(1, ESign.Sharp)]) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note([new Head(-2, ESign.Sharp)], ENoteValue.Nv8tri) ,
					new Note([new Head(-3)], ENoteValue.Nv8tri) ,
					new Note() ,
				], EDirectionUAD.Up), 
				
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(4, ESign.Natural)], ENoteValue.Nv8),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(9, ESign.Sharp)], ENoteValue.Nv16),
					new Note([new Head(4, ESign.Flat)], ENoteValue.Nv16),
					new Note([new Head(5)], ENoteValue.Nv16),
					new Note([new Head(1, ESign.Flat)]) ,
					new Note([new Head( -6), new Head( -7)]) ,					
					new Note([new Head(8, null, ETie.Tie(EDirectionUAD.Auto)), new Head(7)], ENoteValue.Nv1) ,
					new Note([new Head(8, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv1) ,
				], EDirectionUAD.Down),				
			], EClef.ClefG, null, EKey.Flat3, null),
			
			new Part([
				new Voice([
					new Note([new Head(), new Head(-1)], ENoteValue.Nv4) ,
					new Note([new Head(1, ESign.Flat)], ENoteValue.Nv8) ,
					new Note([new Head(4, ESign.None)], ENoteValue.Nv8) ,
					new Note([new Head(1, ESign.Sharp), new Head(2, ESign.Flat)], ENoteValue.Nv8dot) ,
					new Note([new Head(-3, ESign.Flat)], ENoteValue.Nv16) ,
					new Note([new Head(1)]) ,
				])
			], EClef.ClefC, null, EKey.Sharp2, null),
			
			new Part([
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv4, null, ENoteType.Pause) ,
					new Note([new Head(1)], ENoteValue.Nv4, null, ENoteType.Normal) ,
					new Note([new Head(2)], ENoteValue.Nv4, null, ENoteType.Normal) ,
					new Note([new Head(3)], ENoteValue.Nv4, null, ENoteType.Normal) ,
					
					new Note([new Head(1)], ENoteValue.Nv4, null, ENoteType.Normal) ,
					new Note([new Head(0)], ENoteValue.Nv4, null, ENoteType.Pause) ,
					new Note([new Head(0)], ENoteValue.Nv8, null, ENoteType.Pause) ,
					new Note([new Head(1)], ENoteValue.Nv8, null, ENoteType.Normal) ,
					new Note([new Head(1)], ENoteValue.Nv16, null, ENoteType.Normal) ,
					new Note([new Head(1)], ENoteValue.Nv16, null, ENoteType.Normal) ,
					new Note([new Head(0)], ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note([new Head(1)], ENoteValue.Nv16, null, ENoteType.Normal) ,

				], EDirectionUAD.Up)	,			
				
				new Voice([
					new Note([new Head(6)], ENoteValue.Nv8) ,
					new Note([new Head(2)], ENoteValue.Nv4) ,
					new Note([new Head(3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv8) ,
					new Note([new Head(3, null, null)], ENoteValue.Nv8) ,
					new Note([new Head(4, ESign.None)], ENoteValue.Nv4) ,
					new Note([new Head(5, null, null)], ENoteValue.Nv8) ,
				], EDirectionUAD.Down)
			], EClef.ClefG, null, EKey.Flat4, null),			
			
			
		], ETime.T3_4, null));	
	}
	
	static public function dbarFlags() {
		return new DBar(new Bar([
			new Part([				
				new Voice([
					
					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(0, ESign.Sharp)]) ,
					
					new Note([new Head(-1)], ENoteValue.Nv16) ,
					new Note() ,

					new Note([new Head(1)], ENoteValue.Nv8) ,
					new Note([new Head(0, ESign.Sharp)]) ,
					
					new Note([new Head(-1)], ENoteValue.Nv8) ,
					new Note() ,					
					
					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(4, ESign.Sharp)]) ,					

					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(3, ESign.Sharp)]) ,						

					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(2, ESign.Sharp)]) ,						
					
				], EDirectionUAD.Auto), 
			]),				
		]));			
	}
	
	static public function dbarTestDots() {
		return new DBar(new Bar([
			new Part([				
				new Voice([
				
					new Note([new Head(-2)], ENoteValue.Nv4dot),
					new Note([new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(1)], ENoteValue.Nv4dot),
					new Note([new Head(2)], ENoteValue.Nv4dot),
					new Note([new Head(3)], ENoteValue.Nv4dot),

					new Note([new Head(-1), new Head(-3)], ENoteValue.Nv4dot),
					new Note([new Head(0), new Head(-2)], ENoteValue.Nv4dot),
					new Note([new Head(1), new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(2), new Head(0)], ENoteValue.Nv4dot),

					new Note([new Head(-1), new Head(-2)], ENoteValue.Nv4dot),
					new Note([new Head(0), new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(1), new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(2), new Head(1)], ENoteValue.Nv4dot),
				]),
			]),						
			new Part([					
				new Voice([
						new Note([new Head(-1)], ENoteValue.Nv4dot),
						new Note([new Head(0)], ENoteValue.Nv4dot),
						new Note([new Head(1)], ENoteValue.Nv4dot),
						new Note([new Head(2)], ENoteValue.Nv4dot),

						new Note([new Head(-1), new Head(-3)], ENoteValue.Nv4dot),
						new Note([new Head(0), new Head(-2)], ENoteValue.Nv4dot),
						new Note([new Head(1), new Head(-1)], ENoteValue.Nv4dot),
						new Note([new Head(2), new Head(0)], ENoteValue.Nv4dot),

						new Note([new Head(-1), new Head(-2)], ENoteValue.Nv4dot),
						new Note([new Head(0), new Head(-1)], ENoteValue.Nv4dot),
						new Note([new Head(1), new Head(0)], ENoteValue.Nv4dot),
						new Note([new Head(2), new Head(1)], ENoteValue.Nv4dot),
					], EDirectionUAD.Up),
				]),
					
			new Part([							
				new Voice([
					new Note([new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(1)], ENoteValue.Nv4dot),
					new Note([new Head(2)], ENoteValue.Nv4dot),

					new Note([new Head(-1), new Head(-3)], ENoteValue.Nv4dot),
					new Note([new Head(0), new Head(-2)], ENoteValue.Nv4dot),
					new Note([new Head(1), new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(2), new Head(0)], ENoteValue.Nv4dot),

					new Note([new Head(-1), new Head(-2)], ENoteValue.Nv4dot),
					new Note([new Head(0), new Head(-1)], ENoteValue.Nv4dot),
					new Note([new Head(1), new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(2), new Head(1)], ENoteValue.Nv4dot),
				], EDirectionUAD.Down),				
			]),		
		]));
	}
		
	
	static public function dbarTestTies() {
		return new DBar(new Bar([
			new Part([				
				new Voice([
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null)], ENoteValue.Nv4),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null), new Head(-2, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null), new Head(2, null, null)], ENoteValue.Nv4),
					
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null)], ENoteValue.Nv16),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null), new Head(-3, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null), new Head(3, null, null)], ENoteValue.Nv16),
					
					
					
				]),
				
			]),	
			
			new Part([				
				new Voice([
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null)], ENoteValue.Nv4),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null), new Head(-2, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null), new Head(2, null, null)], ENoteValue.Nv4),
					
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null)], ENoteValue.Nv16),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null), new Head(-3, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null), new Head(3, null, null)], ENoteValue.Nv16),
				], EDirectionUAD.Up),
			]),	
			
			new Part([				
				new Voice([
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null)], ENoteValue.Nv4),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(-1, null, null), new Head(-2, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null)], ENoteValue.Nv4),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(2, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv2dot),
					new Note([new Head(1, null, null), new Head(2, null, null)], ENoteValue.Nv4),
					
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null)], ENoteValue.Nv16),
					new Note([new Head(-1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(-3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(-1, null, null), new Head(-3, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null)], ENoteValue.Nv16),
					new Note([new Head(1, null, ETie.Tie(EDirectionUAD.Auto)), new Head(3, null, ETie.Tie(EDirectionUAD.Auto))], ENoteValue.Nv16),
					new Note([new Head(1, null, null), new Head(3, null, null)], ENoteValue.Nv16),
				], EDirectionUAD.Down),
			]),				
			
		]));
	}
	
	static public function dbarTestFlagCorrection() {
		return new DBar(new Bar([
			new Part([				
				new Voice([					
				
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note([new Head(1)], ENoteValue.Nv16) ,					
					new Note([new Head(1)], ENoteValue.Nv16) ,
					
					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note([new Head(1)], ENoteValue.Nv16) ,					
					new Note([new Head(1)], ENoteValue.Nv16) ,	
					
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0, ESign.Sharp)], ENoteValue.Nv4), 
					
					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(0, ESign.Sharp)], ENoteValue.Nv4),

					new Note([new Head(1)], ENoteValue.Nv16) ,
					new Note([new Head(4, ESign.Sharp)], ENoteValue.Nv4),		
					
					new Note([new Head(6, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(5, ESign.Flat)], ENoteValue.Nv16) ,					
					new Note([new Head(4, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(3, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(2, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(1, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(0, ESign.Sharp)], ENoteValue.Nv16) ,					
					new Note([new Head(-1, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(-2, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(-3, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(-4, ESign.None)], ENoteValue.Nv16) ,					
					new Note([new Head(-5, ESign.Flat)], ENoteValue.Nv16) ,					
					new Note([new Head(-6, ESign.None)], ENoteValue.Nv16) ,					
					
				], EDirectionUAD.Auto), 
			]),				
		]));			
	}	
	
	static public function barsComplex():Bars {
		return new Bars([ExampleDbars.barComplex1()]);
	}
	
	
	static public function barComplex1():Bar {
		return new Bar([			
			new Part([				
				new Voice([
					new Note([new Head(-1), new Head(-3)]) ,
					new Note([new Head(1, ESign.Sharp)]) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note([new Head(-2, ESign.Sharp)], ENoteValue.Nv8tri) ,
					new Note([new Head(-3)], ENoteValue.Nv8tri) ,
					new Note() ,
				], EDirectionUAD.Up), 
				
				new Voice([
					new Note([new Head(0)], ENoteValue.Nv4dot),
					new Note([new Head(4, ESign.Natural)], ENoteValue.Nv8),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(9, ESign.Sharp)], ENoteValue.Nv16),
					new Note([new Head(4, ESign.Flat)], ENoteValue.Nv16),
					new Note([new Head(5)], ENoteValue.Nv16),
					new Note([new Head(1, ESign.Flat)]) ,
					new Note([new Head( -6), new Head( -7)]) ,					
					new Note([new Head(8), new Head(7)], ENoteValue.Nv1) ,
					new Note([new Head(8)], ENoteValue.Nv1) ,
				], EDirectionUAD.Down),				
				
			]),
			
			new Part([
				new Voice([
					new Note([new Head(), new Head(-1)], ENoteValue.Nv4) ,
					new Note([new Head(1, ESign.Flat)], ENoteValue.Nv8) ,
					new Note([new Head(4, ESign.None)], ENoteValue.Nv8) ,
					new Note([new Head(1, ESign.Sharp), new Head(2, ESign.Flat)], ENoteValue.Nv8dot) ,
					new Note([new Head(-3, ESign.Flat)], ENoteValue.Nv16) ,
					new Note([new Head(1)]) ,
				])
			]),
			
		]);
		
		
	}
}