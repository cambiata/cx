package print.mgr.view;

import cx.AirAppTools;
import flash.display.BitmapData;
import flash.printing.PrintJob;
import flash.text.TextFormat;
import print.mgr.controller.command.LoadOnePage;
import print.mgr.controller.command.PrintOnePage;
import print.mgr.model.MgrStatus;
import print.mgr.model.Printjob;
import print.mgr.model.Status;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Options;
import ru.stablex.ui.widgets.Text;
import scorx.data.Errors;
import sx.data.ScoreLoadingType;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import print.mgr.model.PrinterConfig;
import scorx.model.Configuration;
import sx.mvc.view.WidgetView;
import sx.ScorxColors;


/**
 * ...
 * @author 
 */
class PrintoutSelectView extends WidgetView 
 {
	public  var availablePrinters:Array<String>;
	public var optPrinters:Options;
	public var btn:Button;	
	public var optLabel:Text;
	public var thumbsLabel:Text;
	
	override public function createChildren() 
	 {
		var printerOptions:Array<Array<Dynamic>> = [];
		availablePrinters = AirAppTools.getFilteredPrinters().passed;
		var index = 1;

		for (printer in availablePrinters )
		{
			printerOptions.push([printer, index]);
			index++;			
		}

		optLabel = UIBuilder.create(Text);
		optLabel.format = new TextFormat('Arial', 14, 0xFFFFFF);
		optLabel.x = 140;
		optLabel.y = 60;
		optLabel.text = 'Välj skrivare:';
		this.addChild(optLabel);
		
		optPrinters = UIBuilder.create(Options);
		optPrinters.options = printerOptions; // [['lion', 1], ['camel', 2], ['elephant', 3]];
		optPrinters.x = 140;
		optPrinters.y = 80;
		optPrinters.w = 300;
		
		this.addChild(optPrinters);
		
		
		var skin = new Paint();
		skin.color = ScorxColors.ScorxGreenDark;
		skin.corners =  [8];
		
		var skinHover = new Paint();
		skinHover.color = ScorxColors.ScorxGreenDark;
		skinHover.corners =  [8];
		
		
		this.btn = UIBuilder.create(Button);
		this.btn.text = "Påbörja utskrift";
		this.btn.x = 460;
		this.btn.y = 80;
		this.btn.w = 140;
		this.btn.skin = skin;
		this.btn.skinHovered = skinHover;
		this.btn.refresh();
		this.addChild(this.btn);		
		
		thumbsLabel = UIBuilder.create(Text);
		thumbsLabel.format = optLabel.format;
		thumbsLabel.text = 'Välj vilka sidor som ska skrivas ut genom att klicka på knapparna under respektive miniatyr nedan:';
		thumbsLabel.x = 10;
		thumbsLabel.y = 170;
		this.addChild(this.thumbsLabel);	
		
		this.w = Constants.MANAGER_VIEW_W;
		this.h = Constants.MANAGER_VIEW_H;

	}
	
	override public function addSkin() 
	{
		var skin:Paint = new Paint();
		skin.color = Constants.MANAGER_VIEW_COLOR;
		skin.apply(this);
	}	
}

class PrintoutSelectMediator extends mmvc.impl.Mediator<PrintoutSelectView>
{
	@inject public var status:Status;
	@inject public var configuration:Configuration;
	@inject public var printerConfig:PrinterConfig;	
	@inject public var printjob:Printjob;
	@inject public var errors:Errors;
	
	override function onRegister() 
	 {
		trace('PrintoutSelectMediator registered');	
		
		this.view.btn.onPress = function(e)
		{

			trace(this.configuration.host);
			trace(this.configuration.productId);
			trace(this.configuration.userId);	
			
			
			var currentPrinter = this.view.availablePrinters[Std.int(this.view.optPrinters.value-1)];
			printerConfig.setPrinterName(currentPrinter);
			
			if (this.printerConfig.getSelectedPages().length < 1)
			{
				errors.addError('Ingen sida är vald för utskrift.');				
				return;
			}
			this.printjob.beginPrinting();
			
		};		
		
	}	

}



/*

import print.mgr.view.PrintoutSelect.PrintoutSelectView;
import print.mgr.view.PrintoutSelect.PrintoutSelectMediator;


mediatorMap.mapView(PrintoutSelectView, PrintoutSelectMediator);

*/