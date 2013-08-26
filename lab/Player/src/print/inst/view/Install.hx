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
class InstallView extends VBoxView 
 {

	 public var btn:Button;	
	
	public var label:Text;
	override public function createChildren() 
	 {
		 
		btn = UIBuilder.create(Button);
		btn.text = "Click here to install Scorx Print Manager";
		this.btn.w = Constants.BUTTON_LARGE_W;
		this.btn.h = Constants.BUTTON_LARGE_H;
		this.btn.format = Constants.TEXT_FORMAT_BUTTON_LARGE; 
		this.addChild(this.btn);
		
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