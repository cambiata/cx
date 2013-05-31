package cx.nme.display.behavior;

import cx.nme.display.enums.DragMode;
import cx.nme.display.ResizeSpriteEvent;
import nme.display.DisplayObject;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;

/**
 * ...
 * @author Jonas Nyström
 */



class ResizeBehavior extends AbstractSpriteBehavior {
	private var _width:Float;
	private var _height:Float;	
	
	static private var GRIP_SIZE:Float = 15;	
	private var gripLayer:Sprite;
	private var dm:DragMode;
	private var offX:Float;
	private var offY:Float;
	private var off2X:Float;
	private var off2Y:Float;
	private var onlyWhenCtrl:Bool;
	
	public function new(target:Sprite, ?x:Float = 100, ?y:Float = 100, ?width:Float = 300, ?height:Float = 100, onlyWhenCtrl:Bool=false ) {
		super(target);						
		this._width = width;
		this._height = height;		
		_target.x = x;
		_target.y = y;		
		this.onlyWhenCtrl = onlyWhenCtrl;
		trace(this.onlyWhenCtrl);
		this.createChildren();
		this.draw();		
	}	
	
	private function createChildren() 
	{
		this.gripLayer = new Sprite();
		this._target.addChild(this.gripLayer);		
		this.gripLayer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		//this.gripLayer.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
	}
	
	private function onMouseWheel(e:MouseEvent):Void 
	{		
		if (!e.ctrlKey) 	this._width -= e.delta else this._height -= e.delta;
		//if (e.shiftKey) this._target.y -= e.delta;		
		draw();
	}
	
	private function onMouseDown(e:MouseEvent):Void 
	{
		if (onlyWhenCtrl) if (!e.ctrlKey) return;
		
		var global:Point = _target.globalToLocal(new Point(_target.x, _target.y));
		
		offX = this._target.mouseX - global.x;
		offY = this._target.mouseY - global.y;
		off2X = this._width - offX;
		off2Y = this._height - offY;
		
		var mx = this._target.mouseX;
		var my = this._target.mouseY;
		dm = DragMode.None;
		
		if (mx < GRIP_SIZE && my < GRIP_SIZE) dm = DragMode.LeftTop
		else if (mx > this._width - GRIP_SIZE && my < GRIP_SIZE) dm = DragMode.RightTop
		else if (mx < GRIP_SIZE && my > this._height - GRIP_SIZE) dm = DragMode.LeftBottom
		else if (mx > this._width - GRIP_SIZE && my > this._height - GRIP_SIZE) dm = DragMode.RightBottom
		else if (my < GRIP_SIZE) dm = DragMode.Top
		else if (my > this._height - GRIP_SIZE) dm = DragMode.Bottom
		else if (mx < GRIP_SIZE) dm = DragMode.Left
		else if (mx > this._width - GRIP_SIZE) dm = DragMode.Right
		;

		if (dm != DragMode.None) {
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);					
		}
	}
	
	private function onMove(e:MouseEvent):Void 
	{			
		if (onlyWhenCtrl) if (!e.ctrlKey) return;
		
			switch (this.dm) {
				case DragMode.LeftTop:
					var changeX =  Lib.current.stage.mouseX - _target.x - offX;
					_target.x = _target.x + changeX;
					this._width = this._width - changeX ;
					var changeY =  Lib.current.stage.mouseY - _target.y - offY;
					_target.y = _target.y + changeY;
					this._height = this._height - changeY;						
					draw();	
				case DragMode.RightTop:
					this._width = Lib.current.stage.mouseX - _target.x + off2X;					
					var changeY =  Lib.current.stage.mouseY - _target.y - offY;
					_target.y = _target.y + changeY;
					this._height = this._height - changeY;						
					draw();	
				case DragMode.LeftBottom:
					var changeX =  Lib.current.stage.mouseX -  _target.x - offX;
					_target.x = _target.x + changeX;
					this._width = this._width - changeX;						
					this._height = Lib.current.stage.mouseY  - _target.y + off2Y;			
					draw();	
				case DragMode.RightBottom:
					this._width = Lib.current.stage.mouseX  - _target.x + off2X;
					this._height = Lib.current.stage.mouseY  - _target.y + off2Y;
					this.draw();	
				case DragMode.Top:
					var changeX =  Lib.current.stage.mouseX - _target.x - this.offX;
					_target.x = _target.x + changeX;		
					var changeY =  Lib.current.stage.mouseY - _target.y - this.offY;
					_target.y = _target.y + changeY;					
				case DragMode.Bottom:
					this._height = Lib.current.stage.mouseY  - _target.y + off2Y;
					this.draw();						
				case DragMode.Left:
					var changeX =  Lib.current.stage.mouseX - _target.x - offX;
					_target.x = _target.x + changeX;
					this._width = this._width - changeX;
					draw();	
				case DragMode.Right:
					this._width = Lib.current.stage.mouseX - _target.x + off2X;					
					draw();						
				default:
			}
	}
	

	private function onRelease(e:MouseEvent):Void 
	{
		if (onlyWhenCtrl) if (!e.ctrlKey) return;
		
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);	
		this.dispatchResizeEvent();
	}	
	
	private function dispatchResizeEvent() {
		this.gripLayer.dispatchEvent(new ResizeSpriteEvent(ResizeSpriteEvent.RESIZE, new Rectangle(_target.x, _target.y, this._width, this._height))); 
	}		
	
	public function draw() {
		this._width = Math.max(20, this._width);
		this._height = Math.max(20, this._height);		
		this.gripLayer.graphics.clear();		
		this.gripLayer.graphics.lineStyle(2, 0x0000FF, 0.5);
		this.gripLayer.graphics.beginFill(0x0000FF, 0.05);
		this.gripLayer.graphics.drawRect(0, 0, this._width, this._height);		
	}		
	
	
}