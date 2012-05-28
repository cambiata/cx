package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class MathTools 
{

	static public function inRange(min:Float, value:Float, max:Float):Bool {
		if (value < min) return false;
		if (value > max) return false;
		return true;
	}
	
	static public function intRange(min:Int, value:Int, max:Int):Int {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}	
	
	static public function floatRange(min:Float, value:Float, max:Float):Float {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}	
	
	static public function round2(number:Float, precision:Int=2): Float {
		number = number * Math.pow(10, precision);
		number = Math.round( number ) / Math.pow(10, precision);
		return number;
	}
	
}