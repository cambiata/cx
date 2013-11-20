package cx.mvc.app.base;
import mmvc.impl.Mediator.Mediator;
import cx.mvc.app.AppView;

/**
 * ...
 * @author Jonas Nyström
 */
class AppBaseMediator extends Mediator<AppView>
{
	public function new() 
	{
		super();
	}
	
	override function onRegister()
	{
		register();
	}
	
	function register() 
	{
		
	}
}