package nx.app.neko.not;

import cx.FileTools;
import neko.FileSystem;
import neko.Lib;
import nme.display.BitmapData;
import nme.display.Sprite;
import nx.core.display.DHead;
import nx.core.display.DNote;
import nx.core.display.DPart;
import nx.core.display.DVoice;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.core.element.Part;
import nx.core.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
import nx.output.Render;
import nx.output.Scaling;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		
		var s = new Sprite();
		var r = new Render(s, Scaling.getBig());
		
		var dh:DHead = new DHead(new RHead());		
		var n:Note = new Note([new Head(), new RHead()]);
		var dn:DNote = new DNote(n);
		
		var n:Note = new Note([new Head(0), new Head(1), new Head(2), new Head(3)]);
		var dn:DNote = new DNote(n, EDirectionUD.Up);
		trace([dn.headPositions, dn.direction]);

		var n:Note = new Note([new Head(0), new Head(-1), new Head(-2)/*, new Head(3)*/]);
		var dn:DNote = new DNote(n, EDirectionUD.Down);
		trace([dn.headPositions, dn.direction]);
		r.dnote(100, 100, dn);	
		
		dn.direction = EDirectionUD.Up;
		trace([dn.headPositions, dn.direction]);
		r.dnote(200, 100, dn);	
		
		var v:Voice = new Voice([
			new Note([new Head( -1)], ENoteValue.Nv4),
			new Note([new Head( -2)], ENoteValue.Nv4),
			new Note([new Head( -3)], ENoteValue.Nv4),
			new Note([new Head( -4)], ENoteValue.Nv4),
			], EDirectionUAD.Up);

		var v2:Voice = new Voice([
			new Note([new Head(2)], ENoteValue.Nv2), 
			new Note([new RHead()]),
			], EDirectionUAD.Down);
		
		var p:Part = new Part([v, v2]);
		var dp:DPart = new DPart(p);
		
		r.lines(10, 100, 800);
		r.clef(10, 100);
		
		var bitmapData = new BitmapData(800, 600);
		bitmapData.draw(s);		
		var byteArray = bitmapData.encode('png');	
		var filename = 'test.png';
		FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(filename), byteArray.asString());			
		
	}
	
}