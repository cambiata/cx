package nx3.neko.nme;

import haxe.unit.TestRunner;
import neko.Lib;
import nx3.test.TestN;
import nx3.test.TestQ;
import nx3.test.TestV;
import nx3.test.TestVRender;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		
		var runner = new  TestRunner();
		runner.add(new TestQ());
		runner.add(new TestN());
		runner.add(new TestV());
		runner.add(new TestVRender());		
		runner.run();
		
		
	}
	
}