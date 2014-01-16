package nx3.elements;
import haxe.io.Error;

/**
 * ...
 * @author Jonas Nyström
 */

 
abstract ULevel(Int)
{
	static var MAX_LEVEL = 15;
	static var MIN_LEVEL = -15;
	
	inline public function new(value:Int) {
		// if ((value > MAX_LEVEL) || (value < MIN_LEVEL)) throw  'Level range error: $value is outside $MIN_LEVEL...$MAX_LEVEL';
		//trace('create');
		this = inRange(value);
	}
	
	@:from static public inline function fromInt(value:Int) 
	{
		return new ULevel(value);
	}
	
	@:to public inline function toInt():Int  // <-- needed for example to run...
	{
		//trace('to...');													// <-- but this is never called!
		return this;
	}
	
	@:op(A + B) static public function add (l:ULevel, h:ULevel):ULevel
	{
		//trace('add');
		return new ULevel(l + h);
	}

	@:op(++A) static public function addPlusPlus (l:ULevel):ULevel
	{
		//trace('addPlusPlus');
		return new ULevel(l );
	}

	@:op(A++) static public function addPlusPlusAfter (l:ULevel):ULevel
	{
		//trace('addPlusPlusAfter');
		return new ULevel(l );
	}	
	
	@:commutative @:op(A + B) static public function addInteger(l:ULevel, r:Int):ULevel
	{
		//trace('addInteger');
		return new ULevel(l + r);
	}
	
	@:commutative @:op(A + B) static public function addFloat(l:ULevel, r:Float):ULevel
	{
		//trace('addInteger');
		return new ULevel(l + r);
	}	
	
	@:commutative @:op(A > B) static public function gtFloat(l:ULevel, r:Float):Bool return (l > r);
	@:commutative @:op(A > B) static public function gtInt(l:ULevel, r:Int):Bool return (l > r);
	
	@:commutative @:op(A < B) static public function ltFloat(l:ULevel, r:Float):Bool return (l < r);
	@:commutative @:op(A < B) static public function ltInt(l:ULevel, r:Int):Bool return (l < r);	
	
	static private function inRange(value:Int) return Std.int(Math.min(Math.max(value, MIN_LEVEL), MAX_LEVEL));
}