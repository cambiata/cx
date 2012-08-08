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
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.SpriteTools;
using nx.output.Scaling;
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
	
	public function xtestDPlexOutputStaves() {
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
	
	public function xtestComplexOutput() {
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
	
	public function xtestDPlexOutputSigns() {
		assertTrue(true);
		var y = 350; 
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
	
	public function xtestDPlexOutputSpacing() {
		assertTrue(true);
		
		var y = 500; 
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
	
	public function testPause() {
		assertTrue(true);
		
		var y = 650; 
		
		/*
		var dp = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv1, EDirectionUAD.Up, ENoteType.Pause)),
		]);				
		var dpNext = new Complex([
			new DNote(new Note([new Head(0, ESign.None)], ENoteValue.Nv4, EDirectionUAD.Down)),
		]);		
		*/
				
		var db = new DBar(new Bar([
			new Part([
				new Voice([
				

					/*
					new Note([new Head(1)], ENoteValue.Nv1) ,		
					new Note([new Head(1)], ENoteValue.Nv1, null, ENoteType.Pause) ,									
					
					new Note([new Head(1), new Head(0)], ENoteValue.Nv2dot) ,
					new Note([new Head(1)], ENoteValue.Nv4) ,						
					new Note([new Head(0)], ENoteValue.Nv2dot) ,
					new Note([new Head(-1)], ENoteValue.Nv4) ,					

					new Note([new Head(1)], ENoteValue.Nv2) ,									
					new Note([new Head(1)], ENoteValue.Nv2, null, ENoteType.Pause) ,						
					*/

					/*
					new Note([new Head(3)], ENoteValue.Nv16) ,
					new Note([new Head(3)], ENoteValue.Nv16) ,
					new Note([new Head(3)], ENoteValue.Nv16) ,
					new Note([new Head(3)], ENoteValue.Nv16) ,							
					*/
					
					new Note([new Head(1)], ENoteValue.Nv4) ,
					
					new Note([new Head(1)], ENoteValue.Nv8) ,
					new Note([new Head(1)], ENoteValue.Nv8, null, ENoteType.Pause) ,

					new Note([new Head(1)], ENoteValue.Nv4dot) ,
					new Note([new Head(1)], ENoteValue.Nv8) ,
					
					
					
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(2)], ENoteValue.Nv16) ,
					
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(2)], ENoteValue.Nv8) ,

					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(5)], ENoteValue.Nv16) ,
					
					
					/*
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(1)], ENoteValue.Nv8) ,
					new Note([new Head(2)], ENoteValue.Nv16) ,					
					*/
					
					/*
					new Note([new Head(5)], ENoteValue.Nv16) ,
					new Note([new Head(2)], ENoteValue.Nv16) ,
					new Note([new Head(1)], ENoteValue.Nv8) ,
					
					
					new Note([new Head(-1)], ENoteValue.Nv8) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(-3)], ENoteValue.Nv16) ,
					
					//new Note([new Head(-3), new Head(-1)], ENoteValue.Nv16) ,
					//new Note([new Head(0)], ENoteValue.Nv16) ,

					new Note([new Head(2)], ENoteValue.Nv16) ,
					new Note([new Head(3)], ENoteValue.Nv8) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,

					new Note([new Head(-1)], ENoteValue.Nv16) ,
					new Note([new Head(-3)], ENoteValue.Nv16) ,
					new Note([new Head(-2)], ENoteValue.Nv8) ,
				
					new Note([new Head(0)], ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,					

					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					*/
					
					/*
					new Note([new Head(1)], ENoteValue.Nv1dot) ,									
					new Note([new Head(1)], ENoteValue.Nv1, null, ENoteType.Pause) ,									
					
					new Note([new Head(1), new Head(0)], ENoteValue.Nv2dot) ,
					new Note([new Head(1)], ENoteValue.Nv4) ,						
					new Note([new Head(0)], ENoteValue.Nv2dot) ,
					new Note([new Head(-1)], ENoteValue.Nv4) ,					

					new Note([new Head(1)], ENoteValue.Nv2) ,									
					new Note([new Head(1)], ENoteValue.Nv2, null, ENoteType.Pause) ,						
				
				
					new Note(null, ENoteValue.Nv4, null, ENoteType.Pause) ,					
					new Note(null, ENoteValue.Nv4) ,					
					new Note(null, ENoteValue.Nv16, null, ENoteType.Pause) ,
					new Note(null, ENoteValue.Nv16) ,
					new Note(null, ENoteValue.Nv16) ,
					new Note(null, ENoteValue.Nv16) ,
					new Note([new Head(10)], ENoteValue.Nv8, null, ENoteType.Normal) ,
					new Note(null, ENoteValue.Nv8, null, ENoteType.Pause) ,				
					new Note([new Head(-10)], ENoteValue.Nv8, null, ENoteType.Normal) ,
					new Note(null, ENoteValue.Nv8, null, ENoteType.Pause) ,				
					*/
					
					/*
					new Note([new Head(1)], ENoteValue.Nv8) ,									
					new Note([new Head(1)], ENoteValue.Nv4) ,				
					new Note([new Head(1)], ENoteValue.Nv16) ,				
					new Note([new Head(1)], ENoteValue.Nv4) ,
					
					new Note([new Head(-1)], ENoteValue.Nv8) ,				
					new Note([new Head(-1)], ENoteValue.Nv4) ,				
					new Note([new Head(-1)], ENoteValue.Nv16) ,				
					new Note([new Head(-1)], ENoteValue.Nv4) ,			
					*/

					/*
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					*/
					/*
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(-5)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		
					
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(-4)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		
					
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(-3)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		
					
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(-2)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		
					
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(-1)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		
					
					new Note([new Head(6)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,		

					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(6)], ENoteValue.Nv16) ,		

					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(-1)], ENoteValue.Nv16) ,					
					new Note([new Head(6)], ENoteValue.Nv16) ,		

					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(-2)], ENoteValue.Nv16) ,					
					new Note([new Head(6)], ENoteValue.Nv16) ,		

					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(-3)], ENoteValue.Nv16) ,					
					new Note([new Head(6)], ENoteValue.Nv16) ,		
					*/
					/*
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(5)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(4)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(3)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(2)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(1)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					
					new Note([new Head(-6)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					*/
					/*
					new Note([new Head(-1)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,					
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(1)], ENoteValue.Nv16) ,							
					
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(0)], ENoteValue.Nv16) ,						
					new Note([new Head(-1)], ENoteValue.Nv16) ,						
					
					new Note([new Head(10)], ENoteValue.Nv16) ,						
					new Note([new Head(10)], ENoteValue.Nv16) ,						
					new Note([new Head(10)], ENoteValue.Nv16) ,						
					new Note([new Head(10)], ENoteValue.Nv16) ,			
					
					new Note([new Head(10)], ENoteValue.Nv4) ,							
					
					new Note([new Head(-10)], ENoteValue.Nv16) ,						
					new Note([new Head(-10)], ENoteValue.Nv16) ,						
					new Note([new Head(-10)], ENoteValue.Nv16) ,						
					new Note([new Head(-10)], ENoteValue.Nv16) ,							
					
					new Note([new Head(-10)], ENoteValue.Nv4) ,	
					*/
					
				], EDirectionUAD.Auto), 
				])]));
		
		
		render.dbar(100, y, db, 0, false);
		render.lines(0, y, 1200);				
		
	}
	
	override public function tearDown() {
		_output();		
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}

	
}