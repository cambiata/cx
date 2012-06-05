package sx.objecthandles;

/**
 * ...
 * @author Jonas Nyström
 */

class HandleRoles
{
	// NO_ROLE just sends the event out for the click
	public static var NO_ROLE : Int = 0;
	
	public static var RESIZE_UP : Int = 1;
	public static var RESIZE_DOWN : Int = 2;
	public static var RESIZE_LEFT : Int = 4;
	public static var RESIZE_RIGHT : Int = 8;
	public static var ROTATE : Int = 16;
	public static var MOVE : Int = 32;
	
	
	// some convienence methods:
	public static function isResize(val:Int) : Bool
	{
		return isResizeDown(val) || isResizeLeft(val) || isResizeRight(val) || isResizeUp(val);
	}
	public static function isResizeUp( val:Int ) : Bool
	{
		return (val & RESIZE_UP) == RESIZE_UP;
	}
	public static function isResizeDown( val:Int ) : Bool
	{
		return (val & RESIZE_DOWN) == RESIZE_DOWN;
	}
	public static function isResizeLeft( val:Int ) : Bool
	{
		return (val & RESIZE_LEFT) == RESIZE_LEFT;
	}
	public static function isResizeRight( val:Int ) : Bool
	{
		return (val & RESIZE_RIGHT) == RESIZE_RIGHT;
	}
	public static function isRotate( val:Int ) : Bool
	{
		return (val & ROTATE) == ROTATE;
	}
	
	public static function isMove( val:Int ) : Bool
	{
		return (val & MOVE) == MOVE;
	}
}