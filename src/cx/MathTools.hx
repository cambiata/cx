package cx;
using StringTools;

/**
 * ...
 * @author Jonas Nyström
 */

class MathTools 
{

	static  public function  floatFromString(str:String, comma:String = ',')	:Float
	{
		str = str.replace(',', '.');
		return Std.parseFloat(str);
	}
	
	static inline public function  floatToString(val:Float, comma:String = ',')
	{
		var result = Std.string(val);
		if (comma != '.') result = StringTools.replace(result, '.', comma);
		return result;
	}
	
	static inline public function floatEquals(a:Float, b:Float):Bool
	{		
		return (Math.abs(a - b) <= 0.00001);		
	}	
	
	static inline public function inRange(min:Float, value:Float, max:Float):Bool {
		if (value < min) return false;
		if (value > max) return false;
		return true;
	}
	
	static inline public function floatRange(min:Float, value:Float, max:Float):Float {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}	
	
	static inline public function round2(number:Float, precision:Int=8): Float {
		number = number * Math.pow(10, precision);
		number = Math.round( number ) / Math.pow(10, precision);
		return number;
	}

	static inline public function intRange(min:Int, value:Int, max:Int):Int {
		if (value < min) return min;
		if (value > max) return max;
		return value;
	}		
	
	static inline public function intMin(a:Int, b:Int):Int {
		if (a < b) return a;
		return b;
	}
	
	static inline public function intMax(a:Int, b:Int):Int {
		if (a > b) return a;
		return b;
	}
	
	static inline public function ipol(a:Float, b:Float, delta:Float) {
		return delta * (b - a) + a;
	}
	
	
}