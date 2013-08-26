package print.inst.view;

import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import scorx.model.AirTools;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;

/**
 * ...
 * @author 
 */
class AvailableView extends VBoxView 
 {

	public var btnInstallRuntime:Button;	
	
	public var label:Text;
	override public function createChildren() 
	 {

		this.btnInstallRuntime = UIBuilder.create(Button);
		this.btnInstallRuntime.format = Constants.TEXT_FORMAT_BUTTON_LARGE;
		this.btnInstallRuntime.text = "Install AIR & Print Manager";
		this.btnInstallRuntime.w = Constants.BUTTON_LARGE_W;
		this.btnInstallRuntime.h = Constants.BUTTON_LARGE_H;
		this.addChild(this.btnInstallRuntime);
		
		this.w = Constants.INSTALLER_VIEW_W;
		this.h = Constants.INSTALLER_VIEW_H;
	}
	
	override public function addSkin()
	{
		var skin = new Paint();
		skin.color = Constants.INSTALLER_VIEW_COLOR;
		skin.apply(this);				
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