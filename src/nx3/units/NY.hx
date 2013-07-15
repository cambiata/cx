package nx3.units;

/**
 * ...
 * @author 
 */
abstract NY(Float)
{
	inline public static var YUNIT:Float = 1;	
	
	inline public function new(value:Float)  this = value;
		
	@:from static public inline function fromFloat(value:Float) return new NY(value);
	@:from static public inline function fromInt(value:Int) return new NY(value);
	@:to public inline function toFloat():Float  return this;
	static public inline function fromX(value:Float) return new NY(value / YUNIT);		
	public inline function toY() return this * YUNIT;
	//--------------------------------------------------------------------------------------------------------------------------------
	@:op(A + B) static public function add (x1:NY, x2:NY):NY return new NY(x1 + x2);
	@:op(A - B) static public function sub (x1:NY, x2:NY):NY return new NY(x1 - x2);
	@:op(A * B) static public function mul (x1:NY, x2:NY):NY return new NY(x1 * x2);
	@:commutative @:op(A * B) static public function mulFloat (x1:NY, x2:Float):NY return new NY(x1 * x2);
	@:commutative @:op(A * B) static public function mulInt (x1:NY, x2:Int):NY return new NY(x1 * x2);
	
	@:op(A / B) static public function div (x1:NY, x2:NY):NY return new NY(x1 / x2);
	@:commutative @:op(A / B) static public function divFloat (x1:NY, x2:Float):NY return new NY(x1 / x2);
	@:commutative @:op(A / B) static public function divInt (x1:NY, x2:Int):NY return new NY(x1 / x2);	
	
	@:op(A >= B) static public function gt_like (x1:NY, x2:NY):Bool return x1 >= x2;
	@:op(A <= B) static public function lt_like (x1:NY, x2:NY):Bool return x1 <= x2;	
	
	@:op(A < B) static public function lt (x1:NY, x2:NY):Bool return x1 < x2;
	@:commutative @:op(A < B) static public function ltFloat (x1:NY, x2:Float):Bool return x1 < x2;
	@:commutative @:op(A < B) static public function ltInt (x1:NY, x2:Int):Bool return x1 < x2;
	
	@:op(A > B) static public function gt (x1:NY, x2:NY):Bool return x1 > x2;
	@:commutative @:op(A > B) static public function gtFloat (x1:NY, x2:Float):Bool return x1 > x2;
	@:commutative @:op(A > B) static public function gtInt (x1:NY, x2:Int):Bool return x1 > x2;	
}
