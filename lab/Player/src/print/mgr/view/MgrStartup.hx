package print.mgr.view;

import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;

/**
 * ...
 * @author 
 */
class MgrStartupView extends WidgetView 
 {

	public var btn:Button;	
	
	public var label:Text;		
	override public function createChildren() 
	{		 
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text = 'Manager Startup  ';
		label.w = 200;
		label.x = 10;
		label.y = 10;
		this.addChild(label);
		
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H_COVER;

	}
	
	override public function addSkin() 
	{
		trace('D as');
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}	
	
}

class MgrStartupMediator extends mmvc.impl.Mediator<MgrStartupView>
{
	override function onRegister() 
	 {
		trace('MgrStartupMediator registered');		
	}	
}