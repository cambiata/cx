package cx.nme.display;
import flash.events.Event;

/**
 * ...
 * @author Jonas Nyström
 */

class ResizeSpriteMouseEvent extends Event
{
	public var x:Float;
	public var y:Float;
	public var xFrac:Float;
	public var yFrac:Float;
	static public var RESIZE_MOUSE_DOWN = 'resizeMouseDown';
	
	public function new(type:String, x:Float, y:Float, xFrac:Float, yFrac:Float) 
	{
		
		this.x = x;
		this.y = y;
		this.xFrac = xFrac;
		this.yFrac = yFrac;
		super(type);
	}
	
}