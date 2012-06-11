package nx.app.neko;

import cx.NmeTools;
import cx.Tools;
import haxe.Stack;
import haxe.unit.TestRunner;
import neko.Lib;
import neko.Sys;
import nme.geom.Rectangle;
import nx.enums.ENoteValue;
import nx.output.Render;
import nx.test.TestAllotment;
import nx.test.output.TestNotesOverlap;
import nx.test.output.TestRenderDisplayBar;
import nx.test.output.TestRenderDisplayNote;
import nx.test.output.TestRenderDisplayNote2;
import nx.test.output.TestRenderDisplayNote3;
import nx.test.output.TestRenderDisplayPart;
import nx.test.TestBar;
import nx.test.TestDisplayBar;
import nx.test.TestDisplayHead;
import nx.test.TestDisplayNote;
import nx.test.TestDisplayPart;
import nx.test.TestDisplayVoice;
import nx.test.TestHead;
import nx.test.TestLayoutBar;
import nx.test.TestNote;
import nx.test.TestPart;
import nx.test.TestVoice;
import nx.test.TestXml;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	static function main() 
	{
		var runner = new TestRunner();
		runner.add(new TestHead());
		runner.add(new TestDisplayHead());		
		runner.add(new TestNote());
		
		runner.add(new TestDisplayNote());	
		
		
		runner.add(new TestVoice());
		runner.add(new TestPart());
		runner.add(new TestBar());
		runner.add(new TestDisplayVoice());
		runner.add(new TestDisplayPart());
		//runner.add(new TestDisplayBar());
		
		
		/*
		runner.add(new TestRenderDisplayNote());
		runner.add(new TestRenderDisplayNote2());
		runner.add(new TestRenderDisplayNote3());
		runner.add(new TestRenderDisplayPart());
		*/
		//runner.add(new TestRenderDisplayBar());
		/*
		runner.add(new TestAllotment());
		runner.add(new TestLayoutBar());
		runner.add(new TestXml());
		*/
		
		runner.run();
	}
}