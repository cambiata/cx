package cx.nme.ui;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

/**
 * ...
 * @author Jonas Nyström
 */

class Button extends Sprite
{
	private var down:Bool = false;
	private var w:Float;
	private var h:Float;
	private var callBack: Void -> Void;
	public function new(width:Int = 20, height:Int = 20, callBack:Void -> Void=null) {
		super();
		this.w = width;
		this.h = height;		
		this.callBack = callBack;
		
		this.drawUp();
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		this.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
	}
	
	private function onMouseUp(e:MouseEvent):Void 
	{
		if (this.down) drawUp();
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		if (!this.down) drawDown();
	}
	
	private function drawDown() {
		//trace('down');
		if (this.callBack != null) this.callBack();
		
		this.down = true;
		this.graphics.beginFill(0xFFFFFF);
		this.graphics.lineStyle(1, 0x333333);
		this.graphics.drawRect(0, 0, this.w, this.h); // , 6);		
		this.graphics.beginFill(0x888888);
		this.graphics.drawRect(3, 3, this.w - (3 * 2), this.h - (3 * 2)); // , 10);		
	}
	
	private function drawUp() {
		//trace('up');
		this.down = false;
		this.graphics.beginFill(0xFFFFFF);
		this.graphics.lineStyle(1, 0x333333);
		this.graphics.drawRect(0, 0, this.w, this.h); // , 6);		
		this.graphics.beginFill(0x333333);
		this.graphics.drawRect(3, 3, this.w - (3 * 2), this.h - (3 * 2)); // , 10);				
	}
	
}