package nx3.xamples.main.openfl;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;

import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;
import nx3.xamples.Examples;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.display.DNote;
import nx3.enums.EDirectionUD;
import nx3.enums.ENoteType;
import nx3.io.NoteXML;

/**
 * ...
 * @author 
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
		
		var target = Examples.basic1();
		this.addChild(target );
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
