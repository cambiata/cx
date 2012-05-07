package nx.app;

import cx.NmeTools;
import cx.Tools;
import haxe.Stack;
import haxe.unit.TestRunner;
import neko.Lib;
import neko.Sys;
import nme.geom.Rectangle;
import nx.test.TestDisplayHead;
import nx.test.TestDisplayNote;
import nx.test.TestDisplayVoice;
import nx.test.TestHead;
import nx.test.TestNote;
import nx.test.TestVoice;
import nx.test.TestRenderDisplayNote;

/**
 * ...
 * @author Jonas Nyström
 */
class Main 
{

	static function main() 
	{
		/*
		var r1 = new Rectangle(2, 0, 10, 10);
		var r2 = new Rectangle(0, 5, 5, 5);
		var r3 = NmeTools.rectangleArraysIntersection([r1], [r2]);
		trace(r3);
		*/
		
	
		var runner = new TestRunner();
		runner.add(new TestHead());
		runner.add(new TestDisplayHead());		
		runner.add(new TestNote());
		runner.add(new TestDisplayNote());	
		runner.add(new TestVoice());
		runner.add(new TestDisplayVoice());
		runner.add(new TestRenderDisplayNote());
		runner.run();
		

		
		//(trace(ir);
		
		
		
		
		//trace(Stack.callStack());
		
		/*
		var v = TO.getVoice0();
		trace(v.toStringExt());
		*/
		/*
		var y = 100;
		var x = 300;
		
		var s = new Sprite();
		s.graphics.beginFill(0xFF0000);
		s.graphics.drawRect(10, 10, 30, 30);
		
		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		
		var scaling = Scaling.getBig();
		var render = new Render(s, scaling);		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(x, y, dn);	
		render.noteRects(x, y, dn);
		dn.setDirection(EDirectionUD.Down);
		render.note(460, y, dn);	

		var y = 200;
		var render = new Render(s, Scaling.getNormal());		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(x, y, dn);	

		var y = 300;
		var render = new Render(s, Scaling.getSmall());		
		render.clef(100, y);
		render.lines(100, y, 400);
		render.note(x, y, dn);			
		
		
		var bitmapData = new BitmapData(500, 500);
		bitmapData.draw(s);
		var byteArray = bitmapData.encode('png');	
		var pngFilename = 'test.png';
		FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(pngFilename), byteArray.asString());	
		*/
	}
	
}