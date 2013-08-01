package print.inst.view;

import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class StartupView extends VBoxView
{

	public var label:Text;	
	
	override public function createChildren() 
	{
		this.name = 'Startup';
		
		this.label = UIBuilder.create(Text);
		this.label.text = "StartupView";		
		this.label.w = 140;
		this.addChild(this.label);
		this.refresh();
		
		var skin = new Paint();
		skin.color = 0x00FF00;
		skin.apply(this);
		//this.refresh();
		
	}
}

class StartupMediator extends mmvc.impl.Mediator<StartupView>
{
	override function onRegister()
	{
		trace('StartupMediator registered');		
	}	
}