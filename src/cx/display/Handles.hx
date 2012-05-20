package cx.display;
import nme.display.Sprite;
import nme.events.MouseEvent;

/**
 * ...
 * @author Jonas Nyström
 */

class Handles extends Sprite
{
	private var intWidth:Float;
	private var intHeight:Float;


	public function new(width:Float = 200.0, height:Float = 100.0) 
	{
		super();
		
		intWidth = width;
		intHeight = height;
		//this.width = width;
		//this.height = height;
		this.graphics.lineStyle(1, 0xFF0000);
		this.graphics.drawRect(0, 0, width, height);
		this.createHandles();
	}
	
	private function createHandles() {
		var h = new Handle();
		h.x = 0;
		h.y = 0;
		this.addChild(h);
		h.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMouseDown);
		h.addEventListener(MouseEvent.MOUSE_UP, onHandleMouseUp);
		//h.addEventListener(MouseEvent.MOUSE_MOVE, onHandleMouseMove);
		
		var h = new Handle();
		h.x = this.intWidth;
		h.y = 0;
		this.addChild(h);
		h.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMouseDown);
		h.addEventListener(MouseEvent.MOUSE_UP, onHandleMouseUp);
		//h.addEventListener(MouseEvent.MOUSE_MOVE, onHandleMouseMove);
		
		var h = new Handle();
		h.x = 0;
		h.y = this.intHeight;
		this.addChild(h);
		h.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMouseDown);
		h.addEventListener(MouseEvent.MOUSE_UP, onHandleMouseUp);
		//h.addEventListener(MouseEvent.MOUSE_MOVE, onHandleMouseMove);
		
		var h = new Handle();
		h.x = this.intWidth;
		h.y = this.intHeight;
		this.addChild(h);
		h.addEventListener(MouseEvent.MOUSE_DOWN, onHandleMouseDown);
		h.addEventListener(MouseEvent.MOUSE_UP, onHandleMouseUp);
		//h.addEventListener(MouseEvent.MOUSE_MOVE, onHandleMouseMove);
		MouseEvent.
		
	}
	
	private function onHandleMouseDown(event:MouseEvent) {
		trace('onMouseDown');
		//trace(event.target);
		//cast(event.target, Sprite).addEventListener(MouseEvent.MOUSE_MOVE, onHandleMouseMove);
		cast(event.target, Handle).mouseDown = true;
	}
	
	private function onHandleMouseUp(event:MouseEvent) {
		trace('onMouseUp');
		cast(event.target, Handle).mouseDown = false;
	}

	private function onHandleMouseMove(event:MouseEvent) {
		var handle = cast(event.target, Handle);
		if (!handle.mouseDown) return;
		trace('onHandleMouseMove');
	}
	
	
}