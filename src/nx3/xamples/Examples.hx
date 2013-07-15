package nx3.xamples;

#if neko
import nme.display.Sprite;
import nx3.render.FrameRenderer;
#else
import flash.display.Sprite;
#end

import nx3.render.scaling.Scaling;
import nx3.render.FrameRenderer;

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
class Examples
{
	static public function basic1(target:Sprite=null): Sprite
	{
		if (target == null) target = new Sprite();
		
		var note = new Note(ENoteType.Note([new Head(0), new Head(1), new Head(-1)]));
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
	
}