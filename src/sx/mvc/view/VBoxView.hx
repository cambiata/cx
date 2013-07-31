package sx.mvc.view;

import ru.stablex.ui.widgets.VBox;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class VBoxView extends VBox
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