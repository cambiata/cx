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
class DefaultView extends WidgetView 
 {

	public var btn:Button;	
	
	
	public var label:Text;		
	override public function createChildren() 
	{
		// ru.stablex.ui.widgets.Text;
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text = 'Default view';
		label.w = 200;
		label.x = 10;
		label.y = 10;
		this.addChild(label);
		
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H;
		
	}
	
	override public function addSkin() 
	{
		trace('D as');
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}
	
}

class DefaultMediator extends mmvc.impl.Mediator<DefaultView>
{
	override function onRegister() 
	 {
		trace('DefaultMediator registered');		
	}	

}



/*

import print.mgr.view.Default.DefaultView;
import print.mgr.view.Default.DefaultMediator;


commandMap.mapSignalClass(DefaultView, DefaultMediator);

*/