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
		var an = new NNote();
		an.test();
		var nisse = new Nisse();
	}
}

class Nisse extends Array {
	public function new() {
		
	}
	
}

abstract NNote (ANote) {
	inline public function new() {
		this = new ANote();
	}
	public function test() {
		trace('test');
	}
}



abstract ANote (Array<AHead>) {
	inline public function new() { 
		 this = [];
	}
}

abstract AHead (Array<Int>) {
	inline public function new() { 
		 this = [];
	}
}