package nx3.xamples.main.neko;

import cx.FileTools;
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
import nx3.xamples.main.openfl.Main.OpenFlMain;
import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;
import nx3.elements.NHead;
import nx3.elements.NNote;
import nx3.elements.DNote;
import nx3.elements.EDirectionUD;
import nx3.elements.ENoteType;
import nx3.io.NoteXML;
import nx3.io.VoiceXML;

/**
 * ...
 * @author Jonas Nyström
 */
class Main 
{	
	
	static function main() 
	{
		
		/*
		var voice:Voice = new Voice([
			new Note(),
			new Note([new Head(2)]),
		]);
		voice.test();
		
		var target:Sprite = new Sprite();
		//this.addChild(target); 
		
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
			//FontRenderer,
			]);
		//var render:FrameRenderer = new FrameRenderer(target, Scaling.MID);
		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		render.notelines(0, 100, 700);
		render.complex(200, 100, dcomplex);		
		
		var shape:Shape = ShapeTools.getShape(Elements.noteBlack, Scaling.MID);				
		target.addChild(shape);			
		*/
		
		var target:Sprite = Examples.basic1();
		var filename =  'render.png';
		RenderTools.spriteToPng(target, filename, 100);
		Sys.command(filename);
		
	}	
}

enum ETest
{
	Values(integers:Array<Int>);
}