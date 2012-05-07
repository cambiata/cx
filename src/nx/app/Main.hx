package nx.app;

import cx.NmeTools;
import cx.Tools;
import haxe.Stack;
import haxe.unit.TestRunner;
import neko.Lib;
import neko.Sys;
import nme.geom.Rectangle;
import nx.enums.ENoteValue;
import nx.test.TestDisplayHead;
import nx.test.TestDisplayNote;
import nx.test.TestDisplayVoice;
import nx.test.TestHead;
import nx.test.TestNote;
import nx.test.TestVoice;
import nx.test.TestRenderDisplayNote;
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
		runner.add(new TestDisplayVoice());
		runner.add(new TestRenderDisplayNote());
		runner.add(new TestXml());
		runner.run();
	}
}