package print.inst.view;

import cx.BaseCodeTools;
import haxe.crypto.BaseCode;
import haxe.Serializer;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import scorx.model.AirTools;
import scorx.model.Configuration;
import sx.data.ScoreLoader.ScoreLoadingType;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
using StringTools;
class InstalledView extends VBoxView 
{

	public var btnStartPrintManager:Button;	
	
	override public function createChildren() 
	{
		this.name = 'Installed';
		
		this.btnStartPrintManager = UIBuilder.create(Button);
		this.btnStartPrintManager.text = "Start Print Manager";		
		this.btnStartPrintManager.w = 160;
		this.addChild(this.btnStartPrintManager);
		this.refresh();
		
		var skin = new Paint();
		skin.color = 0x0000FF;
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