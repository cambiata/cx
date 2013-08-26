package print.inst.view;

import cx.flash.ui.UIProgress;
import flash.text.TextFormat;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;
import sx.ScorxColors;

/**
 * ...
 * @author 
 */
class StartupView extends VBoxView
{

	public var label:Text;	
	
	override public function createChildren() 
	{
		
		var spin:UIProgress = new UIProgress(0, 0, 60, 60, 0xbbbbbb, 0xffffff);
		spin.spin();
		this.addChild(spin);
		
		this.w = Constants.INSTALLER_VIEW_W;
		this.h = Constants.INSTALLER_VIEW_H;
	}

	override public function addSkin()
	{
		var skin = new Paint();
		skin.color = Constants.INSTALLER_VIEW_COLOR;
		skin.apply(this);				
	}
	
}

class StartupMediator extends mmvc.impl.Mediator<StartupView>
{
	override function onRegister()
	{
		trace('StartupMediator registered');		
	}	
}