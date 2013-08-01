package print.mgr.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class MgrStartupView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "MgrStartupView";
		this.btn.w = 140;
		this.addChild(this.btn);
	}
}

class MgrStartupMediator extends mmvc.impl.Mediator<MgrStartupView>
{
	override function onRegister() 
	 {
		trace('MgrStartupMediator registered');		
	}	
}