package sx.objecthandles;
import flash.events.IEventDispatcher;

/**
 * ...
 * @author Jonas Nyström
 */

interface IHandle implements IEventDispatcher {	
	
	function redraw():Void;
	
	function getHandleDescriptor():HandleDescription;
	function setHandleDescriptor(value:HandleDescription):HandleDescription;
	
	function getTargetModel():Dynamic;
	function setTargetModel(value:Dynamic):Void;	
	

		function getVisible():Bool;
		function setVisible(value:Bool):Bool;
		function getX():Float;
		function setX(value:Float):Float;
		function getY():Float;
		function setY(value:Float):Float;
		function getWidth():Float;
		function setWidth(value:Float):Float;
		function getHeight():Float;
		function setHeight(value:Float):Float;
		function getRotation():Float;
		function setRotation(value:Float):Float;	
	
	
}