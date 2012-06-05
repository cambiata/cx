/**
* ...
* @author Jonas Nyström
*/

package sx.objecthandles;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;

class DragGeometry extends EventDispatcher
{


	
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	public var rotation:Float;
	public var isLocked:Bool;
	
	public function clone() : DragGeometry
	{
		var rv:DragGeometry = new DragGeometry();
		rv.x = x;
		rv.y = y;
		rv.width = width;
		rv.height = height;
		rv.rotation = rotation;
		return rv;
	}
	
	public function copyFrom( other:DragGeometry ) {
		x=other.x;
		y=other.y;
		width=other.width;
		height=other.height;
		rotation=other.rotation;
	}
	
	
	public function getRectangle() : Rectangle
	{
		return new Rectangle(x,y,width,height);
	}
	
	override public function toString() : String
	{
		return "[DragGeometry " + x + "," + y + "+" + width + "x" + height + "]"; 	
	}

}
