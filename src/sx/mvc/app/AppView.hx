package sx.mvc.app;
import flash.display.Sprite;
import mmvc.api.IViewContainer;
import msignal.Signal.Signal1;
/**
 * ...
 * @author Jonas Nyström
 */
class AppView  extends Sprite  implements IViewContainer
{
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;
	public function isAdded(view:Dynamic):Bool return true;
	public static var REGISTER:Signal1<Dynamic> = new Signal1();
	
	public function new()
	{
		super();	
		trace('AppView new()');
		REGISTER.add(activeMediators);
	}

	function activeMediators(view)
	{
		viewAdded(view);
	}		
}