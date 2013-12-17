package sx.mvc.view;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Jonas Nyström
 */
class BaseView extends Sprite
{

	public function new() 
	{
		super();
		createChildren();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this);} );
	}
	
	private function createChildren()
	{
		
	}
}