package ;

import neko.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		var runner = new haxe.unit.TestRunner();
		runner.add(new Test());
		var success = runner.run();		
	}
	
}