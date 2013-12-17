package print.mgr.view;

import cx.AirAppTools;
import cx.AIRTools;
import flash.desktop.NativeApplication;
import flash.display.NativeWindow;
import flash.Lib;
import flash.system.ApplicationDomain;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class PrintoutDoneView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "Utskrift färdig - stäng Scorx Print";
		this.btn.w = 240;
		this.addChild(this.btn);
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H_COVER;		
	}
	
	override public function addSkin() 
	{
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}	
}

class PrintoutDoneMediator extends mmvc.impl.Mediator<PrintoutDoneView>
{
	override function onRegister() 
	 {
		trace('PrintoutDoneMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			NativeApplication.nativeApplication.exit();
		};		
		
	}	

}



/*

import print.mgr.view.PrintoutDone.PrintoutDoneView;
import print.mgr.view.PrintoutDone.PrintoutDoneMediator;


mediatorMap.mapView(PrintoutDoneView, PrintoutDoneMediator);

*/