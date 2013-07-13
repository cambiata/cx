package nx3.units;
import haxe.io.Error;

/**
 * ...
 * @author Jonas Nyström
 */

 
abstract Level(Int)
{
	static var MAX_LEVEL = 15;
	static var MIN_LEVEL = -15;
	
	inline public function new(value:Int) {
		// if ((value > MAX_LEVEL) || (value < MIN_LEVEL)) throw  'Level range error: $value is outside $MIN_LEVEL...$MAX_LEVEL';
		trace('create');
		this = inRange(value);
	}
	@:from static public inline function fromInt(value:Int) 
	{
		trace('from...');
		return new Level(value);
	}
	
	@:to public inline function toInt():Int  // <-- needed for example to run...
	{
		trace('to...');													// <-- but this is never called!
		return this;
	}
	
	@:op(A + B) static public function add (l:Level, h:Level):Level
	{
		trace('add');
		return new Level(l + h);
	}

	@:op(++A) static public function addPlusPlus (l:Level):Level
	{
		trace('addPlusPlus');
		return new Level(l );
	}

	@:op(A++) static public function addPlusPlusAfter (l:Level):Level
	{
		trace('addPlusPlusAfter');
		return new Level(l );
	}	
	
	@:commutative @:op(A + B) static public function addInteger(l:Level, r:Int):Level
	{
		trace('addInteger');
		return new Level(l + r);
	}
	
	
	
	
	static private function inRange(value:Int) return Std.int(Math.min(Math.max(value, MIN_LEVEL), MAX_LEVEL));
}