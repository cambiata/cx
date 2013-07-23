package nx3.units;

/**
 * ...
 * @author 
 */
abstract NX(Float)
{
	inline public static var XUNIT:Float = 1;
	
	inline public function new(value:Float)  this = value;
		
	@:from static public inline function fromFloat(value:Float) return new NX(value);
	@:to public inline function toFloat():Float  return this;
	static public inline function fromX(value:Float) return new NX(value / XUNIT);		
	public inline function toX() return this * XUNIT;
	//--------------------------------------------------------------------------------------------------------------------------------
	@:op(-A) static public function sw (x1:NX):NX return new NX(-x1);
	
	@:op(A + B) static public function add (x1:NX, x2:NX):NX return new NX(x1 + x2);
	@:op(A - B) static public function sub (x1:NX, x2:NX):NX return new NX(x1 - x2);
	@:op(A * B) static public function mul (x1:NX, x2:NX):NX return new NX(x1 * x2);
	@:commutative @:op(A * B) static public function mulFloat (x1:NX, x2:Float):NX return new NX(x1 * x2);
	@:commutative @:op(A * B) static public function mulInt (x1:NX, x2:Int):NX return new NX(x1 * x2);
	@:op(A / B) static public function div (x1:NX, x2:NX):NX return new NX(x1 / x2);
	@:commutative @:op(A / B) static public function divFloat (x1:NX, x2:Float):NX return new NX(x1 / x2);
	@:commutative @:op(A / B) static public function divInt (x1:NX, x2:Int):NX return new NX(x1 / x2);
	
	
	@:op(A >= B) static public function gt_like (x1:NX, x2:NX):Bool return x1 >= x2;
	@:op(A <= B) static public function lt_like (x1:NX, x2:NX):Bool return x1 <= x2;
	
	@:op(A < B) static public function lt (x1:NX, x2:NX):Bool return x1 < x2;
	@:commutative @:op(A < B) static public function ltFloat (x1:NX, x2:Float):Bool return x1 < x2;
	@:commutative @:op(A < B) static public function ltInt (x1:NX, x2:Int):Bool return x1 < x2;
	
	@:op(A > B) static public function gt (x1:NX, x2:NX):Bool return x1 > x2;
	@:commutative @:op(A > B) static public function gtFloat (x1:NX, x2:Float):Bool return x1 > x2;
	@:commutative @:op(A > B) static public function gtInt (x1:NX, x2:Int):Bool return x1 > x2;	
}
