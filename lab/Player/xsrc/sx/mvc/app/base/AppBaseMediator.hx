package sx.mvc.app.base;
import mmvc.impl.Mediator.Mediator;
import sx.mvc.app.AppView;

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