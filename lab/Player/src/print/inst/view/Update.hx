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

/**
 * ...
 * @author 
 */
class UpdateView extends VBoxView 
 {

	public var btn:Button;	
	public var info:Text;
	
	override public function createChildren() 
	 {
		btn = UIBuilder.create(Button);
		btn.text = "Uppdatera Scorx Print";
		this.btn.w = Constants.BUTTON_LARGE_W;
		this.btn.h = Constants.BUTTON_LARGE_H;
		this.btn.format = Constants.TEXT_FORMAT_BUTTON_LARGE; 
		this.addChild(this.btn);
		
		this.w = Constants.INSTALLER_VIEW_W;
		this.h = Constants.INSTALLER_VIEW_H;
		this.info = UIBuilder.create(Text);
		this.info.format = new TextFormat('Arial', 14, 0xFFFFFF);
		this.info.label.htmlText = 'Du bör uppdatera Scorx Print till <br />senaste version';
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