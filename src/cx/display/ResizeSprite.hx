package cx.display;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
/**
 * ...
 * @author Jonas Nyström
 */

class ResizeSprite extends Sprite
{

	static private var GRIP_SIZE:Float = 10;
	
	private var _width:Float;
	private var _height:Float;
	private var target:Sprite;
	private var gripRightTop:Sprite;
	private var gripRightBottom:Sprite;
	private var gripMiddle:Sprite;
	private var gripLeftBottom:Sprite;
	private var gripLeftTop:Sprite;
	public function new(target:Sprite, x:Float=100, y:Float=100, width:Float=300, height:Float=100) {
		super();
		this.target = target;
		this._width = width;
		this._height = height;		
		this.createChildren();
		this.draw();
		this.x = x;
		this.y = y;
		target.addChild(this);
		this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		if (!Std.is(e.target, ResizeSprite)) return;
		var x = e.localX;
		var y = e.localY;
		this.dispatchEvent(new ResizeSpriteMouseEvent(ResizeSpriteMouseEvent.RESIZE_MOUSE_DOWN, x, y, x/ this._width, y/ this._height));
	}
	
	private function drawGrip(graphics:Graphics) {
		graphics.lineStyle(1, 0x000000, 0.3);
		graphics.beginFill(0xFFFFFF, 0);
		graphics.drawRect( -GRIP_SIZE/2, -GRIP_SIZE/2, GRIP_SIZE, GRIP_SIZE); 		
	}
	
	private function createChildren() {
		gripRightTop = new Sprite();
		this.drawGrip(gripRightTop.graphics);
		gripRightTop.graphics.endFill();
		gripRightTop.buttonMode = true;
		this.addChild(gripRightTop);
		gripRightTop.addEventListener(MouseEvent.MOUSE_DOWN, onDragRightTop, false, 0, true);		
		
		gripRightBottom = new Sprite();
		this.drawGrip(gripRightBottom.graphics);
		
		gripRightBottom.graphics.endFill();
		gripRightBottom.buttonMode = true;
		this.addChild(gripRightBottom);
		gripRightBottom.addEventListener(MouseEvent.MOUSE_DOWN, onDragRightBottom, false, 0, true);				
		
		gripMiddle = new Sprite();
		this.drawGrip(gripMiddle.graphics);
		gripMiddle.graphics.endFill();
		gripMiddle.buttonMode = true;
		this.addChild(gripMiddle);		
		gripMiddle.addEventListener(MouseEvent.MOUSE_DOWN, onDragMiddle, false, 0, true);			
		
		gripLeftBottom = new Sprite();
		this.drawGrip(gripLeftBottom.graphics);
		gripLeftBottom.graphics.endFill();
		gripLeftBottom.buttonMode = true;
		this.addChild(gripLeftBottom);		
		gripLeftBottom.addEventListener(MouseEvent.MOUSE_DOWN, onDragLeftBottom, false, 0, true);	
		
		gripLeftTop = new Sprite();
		this.drawGrip(gripLeftTop.graphics);
		gripLeftTop.graphics.endFill();
		gripLeftTop.buttonMode = true;
		this.addChild(gripLeftTop);		
		gripLeftTop.addEventListener(MouseEvent.MOUSE_DOWN, onDragLeftTop, false, 0, true);				
	}
	
	public function draw() {
		
		this._width = Math.max(20, this._width);
		this._height = Math.max(20, this._height);
		
		this.graphics.clear();
		this.graphics.beginFill(0xFF0000, 0.2);
		this.graphics.drawRect(0, 0, this._width, this._height);		
		
		gripRightTop.x = this._width;
		gripRightTop.y = 0;
		gripRightBottom.x = this._width;
		gripRightBottom.y = this._height;		
		gripMiddle.x = this._width / 2;
		gripMiddle.y = this._height / 2;
		gripLeftTop.x = 0; // this._width;
		gripLeftTop.y = 0;
		gripLeftBottom.x = 0;
		gripLeftBottom.y = this._height;			
	}
	
	private function dispatchResizeEvent() {
		this.dispatchEvent(new ResizeSpriteEvent(ResizeSpriteEvent.RESIZE, new Rectangle(this.x, this.y, this._width, this._height))); 
	}
	
	//---------------------------------------------------------------------------------------------------------------------------------------
	
	private function onDragLeftTop(e:MouseEvent):Void 
	{
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveLeftTop, false, 0, true);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseLeftTop, false, 0, true);					
	}
	
	private function releaseLeftTop(e:MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveLeftTop);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, releaseLeftTop);	
		this.dispatchResizeEvent();
	}
	
	private function moveLeftTop(e:MouseEvent):Void 
	{
			var changeX =  Lib.current.stage.mouseX - gripLeftTop.x - this.x;
			this.x = this.x + changeX;
			this._width = this._width - changeX;
			var changeY =  Lib.current.stage.mouseY - gripLeftTop.y - this.y;
			this.y = this.y + changeY;
			this._height = this._height - changeY;						
			draw();		
	}
	//---------------------------------------------------------------------------------------------------------------------------------------
	
	private function onDragLeftBottom(e:MouseEvent):Void 
	{
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveLeftBottom, false, 0, true);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseLeftBottom, false, 0, true);				
	}
	
	private function releaseLeftBottom(e:MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveLeftBottom);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, releaseLeftBottom);		
		this.dispatchResizeEvent();
	}
	
	private function moveLeftBottom(e:MouseEvent):Void 
	{
		var changeX =  Lib.current.stage.mouseX - gripLeftBottom.x - this.x;
		this.x = this.x + changeX;
		this._width = this._width - changeX;
			
		this._height = this._height + Lib.current.stage.mouseY - gripLeftBottom.y - this.y;			
			
		draw();
	}
	
	//---------------------------------------------------------------------------------------------------------------------------------------
	
	
	private function onDragMiddle(e:MouseEvent):Void 
	{
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveMiddle, false, 0, true);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseMiddle, false, 0, true);			
	}
	
	private function releaseMiddle(e:MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveMiddle);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, releaseMiddle);		
		this.dispatchResizeEvent();
	}
	
	private function moveMiddle(e:MouseEvent):Void 
	{
			this.x = (Lib.current.stage.mouseX - gripMiddle.x );
			this.y = (Lib.current.stage.mouseY - gripMiddle.y );	
		this.draw();		
	}
	

	
	private function onDragRightBottom(e:MouseEvent) {
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveRigthBottom, false, 0, true);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseRightBottom, false, 0, true);				
	}
	
	private function releaseRightBottom(e:MouseEvent):Void 
	{
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveRigthBottom);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, releaseRightBottom);				
		this.dispatchResizeEvent();
	}
	
	private function moveRigthBottom(e:MouseEvent):Void 
	{
		this._width = this._width + Lib.current.stage.mouseX - gripRightBottom.x - this.x;
		this._height = this._height + Lib.current.stage.mouseY - gripRightBottom.y - this.y;
		this.draw();
	}
	
	//---------------------------------------------------------------------------------------------------------------------------------------
	private function onDragRightTop(e:MouseEvent) {
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveRigthTop, false, 0, true);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, releaseRightTop, false, 0, true);		
	}
	
	private function releaseRightTop(e:MouseEvent) {
		Lib.current.stage.removeEventListener (MouseEvent.MOUSE_MOVE, moveRigthTop);
		Lib.current.stage.removeEventListener (MouseEvent.MOUSE_UP, releaseRightTop);				
		this.dispatchResizeEvent();
	}
	
	private function moveRigthTop(e:MouseEvent) {
			this._width = this._width + Lib.current.stage.mouseX - gripRightBottom.x - this.x;
			
			var changeY =  Lib.current.stage.mouseY - gripLeftTop.y - this.y;
			this.y = this.y + changeY;
			this._height = this._height - changeY;						
			draw();			
	}
	//---------------------------------------------------------------------------------------------------------------------------------------
	
}