package nx3.xamples.main.neko;

import cx.FileTools;
import nme.display.Shape;
import neko.Lib;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nx3.display.DComplex;
import nx3.elements.Voice;
import nx3.render.IRenderer;
import nx3.render.MultiRenderer;
import nx3.render.svg.Elements;
import nx3.render.svg.ShapeTools;
import nx3.render.tools.RenderTools;
import nx3.xamples.Examples;

import nme.display.Sprite;
import nx3.display.DLyric;
import nx3.display.DNote;
import nx3.display.IDNoteRects;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.enums.EClef;
import nx3.enums.EDirectionUAD;
import nx3.enums.EDirectionUD;
import nx3.enums.EHeadType;
import nx3.enums.ELyricContinuation;
import nx3.enums.ELyricFormat;
import nx3.enums.ENoteArticulation;
import nx3.enums.ENoteAttributes;
import nx3.enums.ENoteType;
import nx3.enums.ENoteValue;
import nx3.enums.ENoteVariant;
import nx3.enums.EPosition;
import nx3.enums.ESign;
import nx3.enums.ETie;
import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;
import nx3.units.Fixed16;
import nx3.units.Level;
import nx3.units.NRect;
import nx3.units.NX;


using nx3.io.HeadXML;
using nx3.io.NoteXML;
using nx3.io.VoiceXML;
/**
 * ...
 * @author Jonas Nyström
 */
class Main 
{	
	
	static function main() 
	{
		/*
		var note:Note = new Note(ENoteType.Note([new Head(1)]), ENoteValue.Nv4);
		trace(note);
		var xmlString = note.toXml().toString();
		trace(xmlString);
		*/
		
	
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
		/*
		var render:FrameRenderer = new FrameRenderer(target, Scaling.MID);
		*/
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
		
		/*
		var target:Sprite = Examples.basic1();
		var filename =  'render.png';
		RenderTools.spriteToPng(target, filename, 100);
		Sys.command(filename);
		*/
	}	
}

enum ETest
{
	Values(integers:Array<Int>);
}