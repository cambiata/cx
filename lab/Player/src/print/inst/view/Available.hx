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
class AvailableView extends VBoxView 
 {

	public var btnInstallRuntime:Button;	
	
	override public function createChildren() 
	 {
		 this.name = "avalilable";
		 
		this.btnInstallRuntime = UIBuilder.create(Button);
		this.btnInstallRuntime.text = "Available - Install AIR Runtime and Scorx Print Manager";
		this.btnInstallRuntime.w = 440;
		this.addChild(this.btnInstallRuntime);
	}
}

class AvailableMediator extends mmvc.impl.Mediator<AvailableView>
{
	 @inject public var airTools:AirTools;
	
	override function onRegister() 
	 {
		trace('AvailableMediator registered');		
		
		this.view.btnInstallRuntime.onPress = function(e) {
			this.airTools.installApplication();			
		};
	}	
}