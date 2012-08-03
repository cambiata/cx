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
class _TestRender extends TestCase
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
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	public function XtestDNoteOutput() {
		assertTrue(true);
		render.dnote(200, 100, _TO.dNoteNv4_1_p0);		
		render.dnote(300, 100, _TO.dNoteNv4_2_m1p1);		
		render.dnote(400, 100, _TO.dNoteNv4_2_p0p1);
		
		render.dnote(500, 100, new DNote(new Note([new Head( -1), new Head(0), new Head(1)])));
	}
	
	public function XtestDPlexOutputStaves() {
		assertTrue(true);
		var y = 50; 
		render.lines(0, y, 1200);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( 0, null)], null, null)),
		]);				
		render.complex(100, y, dp, rect);				
		
		var dp = new Complex([
			new DNote(new Note([new Head( 0, null)], null, EDirectionUAD.Up)),
		]);				
		render.complex(200, y, dp, rect);				
		
		var dp = new Complex([
			new DNote(new Note([new Head( 0, null)], null, EDirectionUAD.Down)),
		]);				
		render.complex(300, y, dp, rect);				
	}
	
	public function XtestComplexOutput() {
		assertTrue(true);
		var y = 200; 
		render.lines(0, y, 1200);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -3, null)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head( 2, null)], null, EDirectionUAD.Down)),
		]);				
		render.complex(200, y, dp, rect);		

		var dp = new Complex([
			new DNote(new Note([new Head(-1)], null, EDirectionUAD.Up)), 
			new DNote(new Note([new Head()], null, EDirectionUAD.Down)),
			]);
		render.complex(300, y, dp, rect);		
		
		var dp = new Complex([
			new DNote(new Note([new Head()], null, EDirectionUAD.Up)), 
			new DNote(new Note([new Head()], null, EDirectionUAD.Down)),
			]);
		render.complex(400, y, dp, rect);
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null), new Head( -2, ESign.Flat)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(2, null), new Head(4, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.complex(500, y, dp, rect);			
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null), new Head( -2, ESign.Flat)], null, EDirectionUAD.Down)),
			new DNote(new Note([new Head(2, null), new Head(4, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.complex(600, y, dp, rect);		
		
		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1), new Head( -2)], null, EDirectionUAD.Down)),
			new DNote(new Note([new Head(-1)], null, EDirectionUAD.Down)),
		]);
		render.complex(700, y, dp, rect);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0, null)], null, EDirectionUAD.Down)),
		]);
		render.complex(780, y, dp, rect);			
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null)], ENoteValue.Nv4dot, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0, null)], null, EDirectionUAD.Down)),
		]);
		render.complex(860, y, dp, rect);				
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null)], ENoteValue.Nv4ddot, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0, null)], null, EDirectionUAD.Down)),
		]);
		render.complex(940, y, dp, rect);			
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, null)], ENoteValue.Nv4dot, EDirectionUAD.Up)),
			new DNote(new Note([new Head(1, null)], null, EDirectionUAD.Down)),
		]);
		render.complex(1020, y, dp, rect);				
	}
	
	public function testDPlexOutputSigns() {
		assertTrue(true);
		var y = 50; 
		render.lines(0, y, 1200);
		
		var dp = new Complex([
			new DNote(new Note([new Head( -3, ESign.Flat)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head( 2, ESign.Sharp)], null, EDirectionUAD.Down)),
		]);				
		render.complex(200, y, dp, rect);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, ESign.Sharp), new Head( -2, ESign.Flat)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(2, ESign.Sharp), new Head(4, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.complex(400, y, dp, rect);			
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, ESign.Sharp), new Head( -2, ESign.Flat)], null, EDirectionUAD.Down)),
			new DNote(new Note([new Head(2, ESign.Sharp), new Head(4, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.complex(600, y, dp, rect);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1), new Head( -2)], null, EDirectionUAD.Down)),
			new DNote(new Note([new Head(-1)], null, EDirectionUAD.Down)),
		]);
		render.complex(800, y, dp, rect);		
		
		var dp = new Complex([
			new DNote(new Note([new Head( -1, ESign.Sharp)], null, EDirectionUAD.Up)),
			new DNote(new Note([new Head(0, ESign.Flat)], null, EDirectionUAD.Down)),
		]);
		render.complex(1000, y, dp, rect);				
	}	
	
	public function testDPlexOutputSpacing() {
		assertTrue(true);
		
		var y = 200; 
		render.lines(0, y, 1200);	
		
		var dp = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Down)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Down)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(100, y, dp, rect);				
		render.complex(100, y, dpNext, rect, distanceX);				
		
		var dp = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Down)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(200, y, dp, rect);				
		render.complex(200, y, dpNext, rect, distanceX);				
		
		var dp = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(1, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Down)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(300, y, dp, rect);				
		render.complex(300, y, dpNext, rect, distanceX);			
		
		var dp = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(1, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(400, y, dp, rect);				
		render.complex(400, y, dpNext, rect, distanceX);			
		
		var dp = new Complex([
			new DNote(new Note([new Head(-2, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(1, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(500, y, dp, rect);				
		render.complex(500, y, dpNext, rect, distanceX);				
		
		var dp = new Complex([
			new DNote(new Note([new Head(-2, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(3, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);		
		var distanceX = dp.distanceX(dpNext);
		render.complex(600, y, dp, rect);				
		render.complex(600, y, dpNext, rect, distanceX);				
		
		var dp = new Complex([
			new DNote(new Note([new Head(-1, ESign.None)], ENoteValue.Nv4dot, EDirectionUAD.Up)),
		]);			
		var dpNext = new Complex([
			new DNote(new Note([new Head(1, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var distanceX = dp.distanceX(dpNext);
		render.complex(700, y, dp, rect);	
		render.complex(700, y, dpNext, rect, distanceX);			
		
		var dp = new Complex([
			new DNote(new Note([new Head(-1, ESign.None)], ENoteValue.Nv4ddot, EDirectionUAD.Up)),
		]);			
		var dpNext = new Complex([
			new DNote(new Note([new Head(1, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var distanceX = dp.distanceX(dpNext);
		render.complex(800, y, dp, rect);	
		render.complex(800, y, dpNext, rect, distanceX);	
		
		var dp = new Complex([
			new DNote(new Note([new Head(-1, ESign.None)], ENoteValue.Nv4ddot, EDirectionUAD.Up)),
		]);			
		var dpNext = new Complex([
			new DNote(new Note([new Head(4, ESign.Sharp)], ENoteValue.Nv4, EDirectionUAD.Up)),
		]);				
		var distanceX = dp.distanceX(dpNext);
		render.complex(900, y, dp, rect);	
		render.complex(900, y, dpNext, rect, distanceX);			
		
		var dp = new Complex([
			new DNote(new Note([new Head(1)], ENoteValue.Nv4dot)),
			new DNote(new Note([new Head(2)], null, EDirectionUAD.Down)),
			
		]);			
		var dpNext = new Complex([
			new DNote(new Note([new Head(4)], null, EDirectionUAD.Down)),
		]);				
		var distanceX = dp.distanceX(dpNext);
		render.complex(1000, y, dp, rect);	
		render.complex(1000, y, dpNext, rect, distanceX);			
	}
	
	/*
	public function testDPart() {
		assertTrue(true);		
		var y = 650; 
		render.lines(0, y, 1200);	
		
		
		var da = new DPart(new Part([Voice._test2Up(), Voice._test0Down()]));
		render.dpart(100, y, da, rect);
		
		
		var da = new DPart(new Part([Voice._test3Up(), Voice._test2Down()]));
		render.dpart(400, y, da, rect);
				
	}
	*/
	
	public function testDBar() {
		assertTrue(true);
		var y = 350; 
		
		var db = new DBar(new Bar([
			
		/*
			new Part([new Voice([
				new Note() ,
				new Note() ,
				new Note([new Head(0,ESign.Sharp)]) ,
				new Note() ,
			])]),

			new Part([new Voice([
				new Note() ,
				new Note([new Head(0,ESign.Flat)]) ,
				new Note() ,
				new Note() ,
			])]),			
		*/	
			
			
			new Part([
				new Voice([
					new Note() ,
					new Note([new Head(1, ESign.Sharp)]) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note(null, ENoteValue.Nv8tri) ,
					new Note() ,
				], EDirectionUAD.Up), 
				new Voice([
					new Note([new Head(3)], ENoteValue.Nv4dot),
					new Note([new Head(4, ESign.Natural)], ENoteValue.Nv8),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(8)], ENoteValue.Nv16),
					new Note([new Head(3, ESign.Natural)], ENoteValue.Nv16),
					new Note([new Head(3)], ENoteValue.Nv16),
					new Note([new Head(1)]) ,
				], EDirectionUAD.Down),
			]),
			
			
			new Part([
				new Voice([
					new Note([new Head(), new Head(1)], 	ENoteValue.Nv4) ,
					new Note([new Head(1, ESign.Flat)],  		ENoteValue.Nv8) ,
					new Note([new Head(4, ESign.None)],  	ENoteValue.Nv8) ,
					new Note([new Head(1, ESign.Sharp), new Head(2, ESign.Flat)],  		ENoteValue.Nv8) ,
					new Note([new Head(-3, ESign.None)],  	ENoteValue.Nv8) ,
					new Note([new Head(1)]) ,
				])
			]),
			
			/*
			new Part([new Voice([
				new Note([new Head(0, ESign.Flat)], ENoteValue.Nv2) ,
				new Note(null, ENoteValue.Nv2) ,
			])]),		
			*/
			
			/*
			new Part([new Voice([
				new Note(null, ENoteValue.Nv2dot) ,
				new Note() ,
			])]),
			*/			
			
		]));
		
		render.dbar(100, y, db, false);
		
	}
	
	
	
	override public function tearDown() {
		_output();		
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}

	
}