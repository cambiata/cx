package sx.objecthandles;

/**
 * ...
 * @author Jonas Nyström
 */

import flash.display.Sprite;
import flash.events.MouseEvent;

class SpriteHandle extends Sprite, implements IHandle {
	
	private var _descriptor:HandleDescription;		
	private var _targetModel:Dynamic;	
	private var isOver:Bool;
	
	/*
	public var handleDescriptor(getHandleDescriptor, setHandleDescriptor): HandleDescription;
	*/
	public var handleDescriptor(getHandleDescriptor, setHandleDescriptor): HandleDescription;
	
	public function getHandleDescriptor():HandleDescription {
		return this._descriptor;
	}
	
	public function setHandleDescriptor(value:HandleDescription):HandleDescription {
		return this._descriptor = value;
	}
	
	public function getTargetModel():Dynamic {
		return _targetModel;
	}
	
	public function setTargetModel(value:Dynamic):Void	{
		_targetModel = value;
	}
	
	public function new() {
		super();	
		//trace(' - new SpriteHandle');
		this.isOver = false;
		this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
	}
	
	private function onRollOver(e:MouseEvent):Void {
		//trace(' - onRollOver');
		this.isOver = true;
		redraw();
	}
	
	private function onRollOut(e:MouseEvent):Void  {
		//trace(' - onRollOut');
		this.isOver = false;
		redraw();
	}
	
	public function redraw(): Void {
		//trace(' - redraw ' + this.isOver);
		this.graphics.clear();
		if (this.isOver) {
			graphics.lineStyle(1,0x3dff40);
			graphics.beginFill(0xc5ffc0	,1);			
		} else {
			graphics.lineStyle(1,0);
			graphics.beginFill(0xaaaaaa,1);			
		}
		graphics.drawRect(-5,-5,10,10);
		graphics.endFill();		
	}
	
	/* INTERFACE sx.objecthandles.IHandle */
	
	public function getVisible():Bool return this.visible
	
	public function setVisible(value:Bool):Bool return this.visible = value
	
	public function getX():Float return this.x
	
	public function setX(value:Float):Float return this.x = value
	
	public function getY():Float return this.y
	
	public function setY(value:Float):Float return this.y = value
	
	public function getWidth():Float return this.width
	
	public function setWidth(value:Float):Float return this.width = value
	
	public function getHeight():Float return this.height
	
	public function setHeight(value:Float):Float return this.height = value
	
	public function getRotation():Float return this.rotation
	
	public function setRotation(value:Float):Float return this.rotation = value
}