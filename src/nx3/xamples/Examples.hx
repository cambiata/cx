package nx3.xamples;

import flash.display.Sprite;
import nx3.elements.DComplex;
import nx3.elements.ENoteValue;
import nx3.elements.ESign;
import nx3.render.FontRenderer;
import nx3.render.MultiRenderer;

import nx3.render.FrameRenderer;
import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;

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
class Examples
{
	static public function basic1(target:Sprite=null): Sprite
	{
		if (target == null) target = new Sprite();
		
		var note = new NNote(ENoteType.Note([new NHead(0), new NHead(1), new NHead(-1)]));
		var dnote:DNote = new DNote(note, EDirectionUD.Up);
		var dnote2:DNote = new DNote(note, EDirectionUD.Down);

		var render:FrameRenderer = new FrameRenderer(target, Scaling.NORMAL);
		render.notelines(0, 100, 700);
		render.note( 100, 100, dnote);
		render.note( 200, 100, dnote2);

		var render:FrameRenderer = new FrameRenderer(target, Scaling.SMALL);					
		render.notelines(0, 200, 700);
		render.note( 100, 200, dnote);
		render.note( 200, 200, dnote2);
		
		var render:FrameRenderer = new FrameRenderer(target, Scaling.MID);					
		render.notelines(0, 300, 700);
		render.note( 100, 300, dnote);
		render.note( 200, 300, dnote2);		
		
		return target;
	}
	
	static public function basic2(target:Sprite=null): Sprite
	{
		
		if (target == null) target = new Sprite();
		
		var note1:NNote = new NNote([
			new NHead( -4, ESign.Flat), 			
			new NHead(0, ESign.Flat),  
			new NHead(2, ESign.Flat)
			], ENoteValue.Nv4, EDirectionUD.Up);
			
		var note2:NNote = new NNote([
			new NHead(-2, ESign.Sharp)
			], ENoteValue.Nv2, EDirectionUD.Down);
			
		//------------------------------------------------------------------------------------------------

		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		var render:MultiRenderer = new MultiRenderer(target, Scaling.MID, [
			FrameRenderer,			
			FontRenderer,
			]);			
		render.notelines(0, 100, 700);		
		render.complex(200, 100, dcomplex);		

		var dnote1:DNote = new DNote(note1);
		var dnote2:DNote = new DNote(note2);
		var dcomplex:DComplex = new DComplex([
			dnote1, 
			dnote2,
			]);
		var render:MultiRenderer = new MultiRenderer(target, Scaling.PRINT1, [
			FrameRenderer,			
			FontRenderer,
			]);			
		render.notelines(0, 300, 700);		
		render.complex(200, 300, dcomplex);				
		
		//-----------------------------------------------------------------------------------------------
		
		trace(NoteXML.toXml(note1).toString());
		
		return target;
	}
	
}