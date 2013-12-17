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
class InstallView extends VBoxView 
 {

	 public var btn:Button;	
	
	public var label:Text;
	public var info:Text;
	override public function createChildren() 
	 {
		 
		this.w = Constants.INSTALLER_VIEW_W;
		this.h = Constants.INSTALLER_VIEW_H;

		btn = UIBuilder.create(Button);
		btn.text = "Installera Scorx Print";
		this.btn.w = Constants.BUTTON_LARGE_W;
		this.btn.h = Constants.BUTTON_LARGE_H;
		this.btn.format = Constants.TEXT_FORMAT_BUTTON_LARGE; 
		this.addChild(this.btn);
		
		this.info = UIBuilder.create(Text);
		this.info.format = new TextFormat('Arial', 14, 0xFFFFFF);
		this.info.label.htmlText = 'För att skriva ut behöver du installera <br />programvaran Scorx Print.';
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