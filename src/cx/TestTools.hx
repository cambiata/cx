package cx;
import haxe.unit.TestCase;
import haxe.unit.TestResult;
import haxe.unit.TestRunner;

/**
 * ...
 * @author Jonas Nyström
 */
class TestTools 
{
	static var output:String;
	
	static public function runTests(cases:Iterable<TestCase>):String {
		if (cases == null) return 'No tests to run';
		output = '';
		var cases = Lambda.array(cases);
		TestRunner.print = myPrint;
		var r:TestRunner = new TestRunner();
		for (c in cases) {
			r.add(c);
		}
		r.run();
		return output;
	}	
	
	static public  function myPrint(v:Dynamic)  {
		output += Std.string(v);
	}
}
