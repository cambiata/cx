package print.mgr.view;

import cx.flash.ui.UIProgress;
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
class PrintLoadView extends WidgetView
 {

	 public var spinProgress:UIProgress;
	public var btn:Button;	
	public var label:Text;		
	override public function createChildren() 
	{
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text = 'Hämtar sidminiatyrer...';
		label.w = 200;
		label.x = 10;
		label.y = 10;
		this.addChild(label);
		
		spinProgress = new UIProgress(360, 80, 80, 80, ScorxColors.ScorxPetrolDark, ScorxColors.ScorxGreen);
		spinProgress.spin();		
		this.addChild(spinProgress);		
		
		
		this.w = Constants.MANAGER_VIEW_W;		
		this.h = Constants.MANAGER_VIEW_H;		
	}
	
	override public function addSkin() 
	{		
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}	
}

class PrintLoadMediator extends mmvc.impl.Mediator<PrintLoadView>
{
	override function onRegister() 
	 {
		trace('PrintLoadMediator registered');		
	}	
}