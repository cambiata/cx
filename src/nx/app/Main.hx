package nx.app;
import cx.FileTools;
import haxe.unit.TestRunner;
import nme.display.BitmapData;
import nme.display.Sprite;
import nx.enums.EDirectionUD;
import nx.test.TO;
import nx.display.DisplayNote;
import nx.element.Head;
import nx.element.Note;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.geom.Scaling;
import nx.output.Render;
import nx.test.TestDisplayHead;
import nx.test.TestDisplayNote;
import nx.test.TestDisplayVoice;
import nx.test.TestHead;
import nx.test.TestNote;
import nx.test.TestVoice;
import nx.Tools.TestTools;
/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{

	static function main() 
	{
		trace('');
		var runner = new TestRunner();
		runner.add(new Tools.TestTools());
		runner.add(new TestHead());
		runner.add(new TestDisplayHead());		
		runner.add(new TestNote());
		runner.add(new TestDisplayNote());	
		runner.add(new TestVoice());
		runner.add(new TestDisplayVoice());
		runner.run();
		
		var v = TO.getVoice0();
		trace(v.toStringExt());
		
		var s = new Sprite();
		s.graphics.beginFill(0xFF0000);
		s.graphics.drawRect(10, 10, 30, 30);
		
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		var y = 100;
		var render = new Render(s, Scaling.getBig());		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(300, y, dn);	
		
		
		dn.setDirection(EDirectionUD.Down);
		render.note(460, y, dn);	
		
		

		var y = 200;
		var render = new Render(s, Scaling.getNormal());		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(300, y, dn);	

		var y = 300;
		var render = new Render(s, Scaling.getSmall());		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(300, y, dn);			
		
		var bitmapData = new BitmapData(500, 500);
		bitmapData.draw(s);
		var byteArray = bitmapData.encode('png');	
		var pngFilename = 'test.png';
		FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(pngFilename), byteArray.asString());	
		
	}
	
}