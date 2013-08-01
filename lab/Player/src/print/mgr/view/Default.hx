package print.mgr.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class DefaultView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "DefaultView";
		this.btn.w = 140;
		this.addChild(this.btn);
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