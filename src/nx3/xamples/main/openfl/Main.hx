package nx3.xamples.main.openfl;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import nx3.elements.DComplex;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.elements.NPart;
import nx3.elements.NVoice;
import nx3.render.FontRenderer;
import nx3.render.MultiRenderer;
import nx3.render.svg.Elements;
import nx3.render.svg.ShapeTools;
import nx3.render.tools.RenderTools;
import nx3.xamples.Examples;

import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;
//import nx3.xamples.Examples;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.DNote;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteType;
import nx3.io.NoteXML;

/**
 * ...
 * @author 
 */
import nx3.io.NoteXML;
import nx3.io.VoiceXML;

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
		
		//this.addChild(Examples.basic2()); 
		var note1:NNote = new NNote([new NHead(-4, ESign.Flat), /*new NHead(0, ESign.Natural),*/ new NHead(0, ESign.Natural)], ENoteValue.Nv4);		
		var dnote1:DNote = new DNote(note1, EDirectionUD.Up);		
		
		var note2:NNote = new NNote([new NHead(0, ESign.Sharp)], ENoteValue.Nv4);
		var dnote2:DNote = new DNote(note2, EDirectionUD.Down);
		
		var dcomplex:DComplex = new DComplex([dnote1, dnote2]);
		//var renderer:FontRenderer = new FontRenderer(this, Scaling.NORMAL);	
		var renderer:MultiRenderer = new MultiRenderer(this, Scaling.PRINT1, [
			FrameRenderer, 
			FontRenderer,
			]);
		renderer.complex(300, 300, dcomplex);
		renderer.notelines(0, 300, 500);
		
		
		

		/*
		this.addChild(target);		
		var note1:NNote = new NNote([
			new NHead( -4, ESign.Flat), 			
			new NHead(0, ESign.Flat),  
			new NHead(2, ESign.Flat)
			], ENoteValue.Nv4, EDirectionUD.Up);
			
		var note2:NNote = new NNote([
			new NHead(-2, ESign.Flat)
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
		
		var render:MultiRenderer = new MultiRenderer(target, Scaling.PRINT1, [
			FrameRenderer,			
			FontRenderer,
			]);

		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		render.notelines(0, 300, 700);		
		render.complex(200, 300, dcomplex);		
		*/
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
