package print.inst.view;

import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
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
	public var info:Text;
	public var btnInstallRuntime:Button;	
	
	public var label:Text;
	override public function createChildren() 
	 {
		 this.w = Constants.INSTALLER_VIEW_W;
		 this.h = Constants.INSTALLER_VIEW_H;

		this.btnInstallRuntime = UIBuilder.create(Button);
		this.btnInstallRuntime.format = Constants.TEXT_FORMAT_BUTTON_LARGE;
		this.btnInstallRuntime.text = "Installera AIR & Scorx Print";
		this.btnInstallRuntime.w = Constants.BUTTON_LARGE_W;
		this.btnInstallRuntime.h = Constants.BUTTON_LARGE_H;
		this.addChild(this.btnInstallRuntime);
		
		this.info = UIBuilder.create(Text);
		this.info.format = new TextFormat('Arial', 14, 0xFFFFFF);
		this.info.label.htmlText = 'För att skriva ut behöver du installera <br />Adobe AIR och Scorx Print.';
		this.info.w = this.w - 20;
		this.info.autoHeight = true;	
		this.info.label.multiline = true;
		this.info.label.autoSize = TextFieldAutoSize.LEFT;
		this.addChild(this.info);
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