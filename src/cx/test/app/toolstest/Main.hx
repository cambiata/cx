package cx.test.app.toolstest;

import haxe.unit.TestRunner;
import neko.Lib;

import cx.test.StrToolsTest;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		var r = new TestRunner();		
		
		r.add(new StrToolsTest());
		
		r.run();
	}
	
}