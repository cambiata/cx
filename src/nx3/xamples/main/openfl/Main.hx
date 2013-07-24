package nx3.xamples.main.openfl;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import nx3.display.DComplex;
import nx3.enums.ENoteValue;
import nx3.enums.ESign;
import nx3.render.FontRenderer;
import nx3.render.MultiRenderer;
import nx3.render.svg.Elements;
import nx3.render.svg.ShapeTools;
import nx3.render.tools.RenderTools;

import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;
//import nx3.xamples.Examples;
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
		
		//var target = Examples.basic1();
		//this.addChild(target );
		
		var target:Sprite = new Sprite();
		this.addChild(target); 
		this.addChild(target);		
		var note1:Note = new Note([
			new Head( -4, ESign.Flat), 			
			new Head(0, ESign.Flat),  
			new Head(2, ESign.Flat)
			], ENoteValue.Nv4, EDirectionUD.Up);
			
		var note2:Note = new Note([
			new Head(5, ESign.Flat)
			], ENoteValue.Nv2, EDirectionUD.Down);
		
		var render:MultiRenderer = new MultiRenderer(target, Scaling.MID, [
			FrameRenderer,			
			FontRenderer,
			]);

		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		render.notelines(0, 100, 700);
		
		render.complex(200, 100, dcomplex);		


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
