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
	static public function runTests(cases:Iterable<TestCase>) {
		if (cases == null) return;
		var cases = Lambda.array(cases);
		
		//TestRunner.print = myPrint;
		
		var r:TestRunner = new TestRunner();
		for (c in cases) {
			r.add(c);
		}
		r.run();
	}	
	
	static public  function myPrint(v:Dynamic)  {
		trace('myPrint');
	}
	
}

/*
import haxe.unit.TestRunner;
class TestRunnerExt extends TestRunner {
	
	private var resultString:String;
	
	public function new() {
		super();
		TestRunner.print = printExt;	
	}
	

	
	public function getResult():String {
		this.run();
		return this.resultString;		
	}
	
	public static function printExt(v:Dynamic) {
		trace('printExt ' + Std.string(v));
	}
	
	
}
*/