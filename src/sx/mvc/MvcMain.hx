package sx.mvc;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author Jonas Nyström
 */
class MvcMain extends Sprite
{

	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) initApp();
		// else (resize or orientation change)
	}
	
	function initApp() 
	{
		if (inited) return;
		inited = true;
		// (your code here)
		
		init();
	}

	function init():Void
	{
		throw "Should be  overridden";
	}
	/* SETUP */

	public function new() 
	{
		super();	
		trace("new MvcMain()");
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

		addEventListener(Event.ADDED_TO_STAGE, added);
		
		
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(initApp, 100); // iOS 6
		#else
		initApp();
		#end
	}
	
}