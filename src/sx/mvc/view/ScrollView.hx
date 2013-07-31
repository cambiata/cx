package sx.mvc.view;

import ru.stablex.ui.widgets.Scroll;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class ScrollView extends Scroll
{
	public function new() 
	{		
		super();
		this.w = 100;
		this.h = 100;
		createChildren();
		this.refresh();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this);} );
	}
	
	private function createChildren()
	{
		
	}
	
}