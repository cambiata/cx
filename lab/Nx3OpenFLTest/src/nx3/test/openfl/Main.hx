package nx3.test.openfl;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.unit.TestRunner;
import nx3.test.TestN;
import nx3.test.TestQ;
import nx3.test.TestV;
import nx3.test.TestVRender;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		var runner = new  TestRunner();
		runner.add(new TestQ());
		runner.add(new TestN());
		runner.add(new TestV());
		runner.add(new TestVRender());
		
		var success = runner.run();		
		
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
