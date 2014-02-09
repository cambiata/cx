package;
import cx.ArrayTools;
import nx3.test.TestN;
import nx3.test.TestQ;
import nx3.test.TestV;
import nx3.test.TestVRender;

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
		runner.add(new TestVRender());
		//runner.add(new TestDVoice());
		//runner.add(new TestDPart());
		var success = runner.run();
	}
}

	
