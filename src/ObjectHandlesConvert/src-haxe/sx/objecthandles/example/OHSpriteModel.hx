package sx.objecthandles.example;
import flash.events.EventDispatcher;
import sx.objecthandles.IMovable;
import sx.objecthandles.IResizable;

/**
 * ...
 * @author Jonas Nyström
 */

class OHSpriteModel extends EventDispatcher, implements IResizable, implements IMovable
{
	public var x:Float;
	public var y:Float;
	public var height:Float;
	public var width:Float;
	public var rotation:Float;
	public var isLocked:Bool;
	
	public function new(x:Float=10, y:Float=10, width:Float=40, height:Float=40, rotation:Float=0, isLocked:Bool=false)
	{
		super();
		this.x 			= x;
		this.y 			= y;
		this.height 	= height;
		this.width 		= width;
		this.rotation 	= rotation;
		this.isLocked 	= isLocked;
	}
	
	public function getX() : Float {
		return this.x;
	}
	public function getY() : Float {
		return this.y;
	}
	
	public function setX(val : Float):Float {
		return this.x = val;
	}
	public function setY(val : Float):Float {
		return this.y = val;
	}	
	
	/* INTERFACE sx.objecthandles.IResizable */
	
	public function getWidth():Float 
	{
		return this.width;
	}
	
	public function getHeight():Float 
	{
		return this.height;
	}
	
	public function setWidth(val:Float):Float 
	{
		return this.width = val;
	}
	
	public function setHeight(val:Float):Float 
	{
		return this.height = val;
	}
	
	
}