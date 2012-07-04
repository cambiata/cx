package nx.app.neko.not;

import neko.Lib;
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

class Main 
{
	
	static function main() 
	{
		var dh:DHead = new DHead(new RHead());		
		var n:Note = new Note([new Head(), new RHead()]);
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
		/*
		*/
	}
	
}