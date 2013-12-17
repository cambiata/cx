package sx.mvc.view;

import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Text;
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
		addSkin();
		this.refresh();
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this); } );
	}
	
	private function createChildren()
	{
		trace('W cc - should be overridden');
		var label:Text = UIBuilder.create(Text);
		label.text = 'This is WidgetView';
		label.w = 200;
		this.addChild(label);
	}
	
	private function addSkin()
	{
		trace('W as - should be overridden');
	}
	
}