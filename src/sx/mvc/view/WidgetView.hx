package sx.mvc.view;

import ru.stablex.ui.widgets.Widget;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class WidgetView extends Widget
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