package nx3.test;
import cx.ArrayTools;

import haxe.unit.TestCase;
import haxe.unit.TestRunner;


/**
 * ...
 * @author Jonas Nyström
 */

 using cx.ArrayTools;
 
class Main
{
	static public function main() 
	{
		var runner = new  TestRunner(); 
		runner.add(new TestQ());
		runner.add(new TestN());
		runner.add(new TestV());
		
		//runner.add(new TestDVoice());
		//runner.add(new TestDPart());
		var success = runner.run();
	}
}

	
