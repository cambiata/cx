package cx.nme.display;
#if flash
import nme.events.Event;
import nme.geom.Rectangle;
# else
import flash.events.Event;
import flash.geom.Rectangle;
# end


/**
 * ...
 * @author Jonas Nyström
 */

class ResizeSpriteEvent extends Event
{
	static public var RESIZE = 'resize';
	
	public  var rect:Rectangle;
	
	public function new(type:String, rect:Rectangle) 
	{
		this.rect = rect;
		super(type);
	}	
}