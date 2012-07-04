package nx.app.nme.not;

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nx.core.display.DHead;
import nx.core.display.DNote;
import nx.core.display.DPart;
import nx.core.display.DVoice;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.enums.EDirectionUD;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite 
{	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{		
		var dh:DHead = new DHead(new RHead());		
		var n:Note = new Note([new RHead(), new RHead()]);
		var dn:DNote = new DNote(n);
		
		var n:Note = new Note([new Head(0), new Head(1), new Head(2), new Head(3)]);
		var dn:DNote = new DNote(n, EDirectionUD.Up);
		trace([dn.headPositions, dn.direction]);

		var dn:DNote = new DNote(n, EDirectionUD.Down);
		trace([dn.headPositions, dn.direction]);
		
		var v:Voice = new Voice([new Note([new Head(2)])]);
		var dv:DVoice = new DVoice(v);
		
		var p:Part = new Part([v]);
		var dp:DPart = new DPart(p);
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;		
		Lib.current.addChild(new Main());
	}	
}
