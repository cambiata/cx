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
class InstallView extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		this.btn = UIBuilder.create(Button);
		this.btn.text = "InstallView";
		this.btn.w = 140;
		this.addChild(this.btn);
	}
}

class InstallMediator extends mmvc.impl.Mediator<InstallView>
{
	
	@inject public var airTools:AirTools;
	
	override function onRegister() 
	 {
		trace('InstallMediator registered');		
		
		this.view.btn.onPress = function(e)
		{
			this.airTools.installApplication();
		};
		
		
	}	

}



/*

import print.inst.view.Install.InstallView;
import print.inst.view.Install.InstallMediator;


mediatorMap.mapView(InstallView, InstallMediator);

*/