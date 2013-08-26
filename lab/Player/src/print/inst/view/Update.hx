package print.inst.view;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import scorx.model.AirTools;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class UpdateView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		btn = UIBuilder.create(Button);
		btn.text = "Click here to update Scorx Print Manager";
		this.btn.w = Constants.BUTTON_LARGE_W;
		this.btn.h = Constants.BUTTON_LARGE_H;
		this.btn.format = Constants.TEXT_FORMAT_BUTTON_LARGE; 
		this.addChild(this.btn);
		
		this.w = Constants.INSTALLER_VIEW_W;
		this.h = Constants.INSTALLER_VIEW_H;
	}
}

class UpdateMediator extends mmvc.impl.Mediator<UpdateView>
{
	@inject public var airTools:AirTools;
	
	override function onRegister() 
	 {
		trace('UpdateMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			this.airTools.installApplication();
		};		
		
	}	

}



/*

import print.inst.view.Update.UpdateView;
import print.inst.view.Update.UpdateMediator;


mediatorMap.mapView(UpdateView, UpdateMediator);

*/