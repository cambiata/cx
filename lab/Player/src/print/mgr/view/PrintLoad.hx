package print.mgr.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class PrintLoadView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "PrintLoadView";
		this.btn.w = 140;
		this.addChild(this.btn);
	}
}

class PrintLoadMediator extends mmvc.impl.Mediator<PrintLoadView>
{
	override function onRegister() 
	 {
		trace('PrintLoadMediator registered');		
	}	
}