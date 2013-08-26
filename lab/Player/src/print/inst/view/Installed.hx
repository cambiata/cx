package print.inst.view;

import cx.BaseCodeTools;
import flash.text.TextFormat;
import haxe.crypto.BaseCode;
import haxe.Serializer;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import scorx.model.AirTools;
import scorx.model.Configuration;
import sx.data.ScoreLoadingType;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;

/**
 * ...
 * @author 
 */
using StringTools;
class InstalledView extends VBoxView 
{

	public var btnStartPrintManager:Button;	
	public var label:Text;	
	
	override public function createChildren() 
	{
		/*
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text = 'Ready to rock!';
		 label.w = 200;
		 label.x = 10;
		 label.y = 10;
		 this.addChild(label);
		*/
		 
		this.btnStartPrintManager = UIBuilder.create(Button);
		this.btnStartPrintManager.text = "Start Print Manager";		
		this.btnStartPrintManager.w = Constants.BUTTON_LARGE_W;
		this.btnStartPrintManager.h = Constants.BUTTON_LARGE_H;
		this.btnStartPrintManager.format = Constants.TEXT_FORMAT_BUTTON_LARGE; 
		this.btnStartPrintManager.refresh();
		//this.btnStartPrintManager.y = 50;
		
		this.addChild(this.btnStartPrintManager);
		this.refresh();
		
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

class InstalledMediator extends mmvc.impl.Mediator<InstalledView>
{
	@inject public var airTools:AirTools;
	@inject public var configuration:Configuration;
	
	override function onRegister() 
	{
		trace('InstalledMediator registered');		
		this.view.btnStartPrintManager.onPress = function(e) 
		{			
			this.airTools.invokeApplication([
				Config.INVOKER_MESSAGE_PRINTJOB, 
				Std.string(configuration.productId),
				Std.string(configuration.userId), 				
				BaseCodeTools.encode(configuration.host),
				Std.string(ScoreLoadingType.print),
			]);			
		};		
	}	
}