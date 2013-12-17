package sx.mvc.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Box;
import ru.stablex.ui.widgets.Text;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class BoxView extends Box
{

	public function new() 
	{		
		super();
		
		this.childPadding = 8;
		this.padding = 8;
		
		createChildren();
		addSkin();
		this.refresh();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this);} );
	}
	
	private function createChildren()
	{
		var label:Text = UIBuilder.create(Text);
		label.text = 'This is BoxView - createChildren() should be overridden!';
		label.w = 400;
		this.addChild(label);		
	}

	function addSkin() 
	{
		
	}	
	
}