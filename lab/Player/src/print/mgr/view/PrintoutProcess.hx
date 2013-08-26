package print.mgr.view;

import cx.flash.ui.UIProgress;

import print.mgr.model.MgrStatus;
import print.mgr.model.PrinterConfig;
import print.mgr.model.Status;
import ru.stablex.ui.skins.Paint;
import scorx.model.Configuration;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import sx.mvc.view.WidgetView;
import sx.ScorxColors;

/**
 * ...
 * @author 
 */
class PrintoutProcessView extends WidgetView
{
	public var spinProgress:UIProgress;

	public var btn:Button;	
	public var label:Text;
	
	override public function createChildren() 
	 {
		var spin:UIProgress = new UIProgress(370, 150, 60, 60, ScorxColors.ScorxPetrolLight, ScorxColors.ScorxPetrolDark);
		spin.spin();
		this.addChild(spin);		

		spinProgress = new UIProgress(360, 140, 80, 80, ScorxColors.ScorxPetrolDark, ScorxColors.ScorxGreen);
		//spin.spin();
		spinProgress.spinStop();
		this.addChild(spinProgress);				
		
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.align = 'center';
		label.x = 0;		
		label.w = Constants.MANAGER_VIEW_W;
		label.y = 70;
		this.addChild(label);
		
		 this.btn = UIBuilder.create(Button);
		this.btn.text = "Abort Printing";
		this.btn.w = 140;
		this.btn.y = 250;
		this.btn.x = 330;
		this.addChild(this.btn);		
		
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H_COVER;		
	}
	
	override public function addSkin() 
	{
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}		
}

class PrintoutProcessMediator extends mmvc.impl.Mediator<PrintoutProcessView>
{
	@inject public var configuration:Configuration;
	@inject public var printerConfig:PrinterConfig;
	@inject public var status:Status;
	
	override function onRegister() 
	 {
		trace('PrintoutProcessMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			// do something...
			trace(printerConfig);
		};		
	
		mediate(this.status.updated.add(function(status:MgrStatus) 
		{
			switch (status)
			{
				case MgrStatus.PrintProcess(pageNr, nrOfPages, action):
					var value = pageNr / (nrOfPages + 1);					
					this.view.spinProgress.value = value;
					this.view.label.text = 'Processing page $pageNr of $nrOfPages';
				default:
			}
		}));
	}	

}



/*

import print.mgr.view.PrintoutProcess.PrintoutProcessView;
import print.mgr.view.PrintoutProcess.PrintoutProcessMediator;


mediatorMap.mapView(PrintoutProcessView, PrintoutProcessMediator);

*/