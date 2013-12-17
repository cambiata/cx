package print.mgr.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class PrintoutAbortedView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "PrintoutAbortedView";
		this.btn.w = 140;
		this.addChild(this.btn);
	}
}

class PrintoutAbortedMediator extends mmvc.impl.Mediator<PrintoutAbortedView>
{
	override function onRegister() 
	 {
		trace('PrintoutAbortedMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			// do something...
		};		
		
	}	

}



/*

import print.mgr.view.PrintoutAborted.PrintoutAbortedView;
import print.mgr.view.PrintoutAborted.PrintoutAbortedMediator;


mediatorMap.mapView(PrintoutAbortedView, PrintoutAbortedMediator);

*/