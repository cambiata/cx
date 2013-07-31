package sx.mvc.view;

import ru.stablex.ui.widgets.HBox;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class HBoxView extends HBox
{

	public function new() 
	{		
		super();
		this.childPadding = 8;
		this.padding = 8;
		createChildren();
		this.refresh();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this);} );
	}
	
	private function createChildren()
	{
		
	}
	
}