package print.mgr.view;

import cx.AirAppTools;
import flash.display.BitmapData;
import flash.printing.PrintJob;
import print.mgr.controller.command.LoadOnePage;
import print.mgr.controller.command.PrintOnePage;
import print.mgr.model.MgrStatus;
import print.mgr.model.Printjob;
import print.mgr.model.Status;
import ru.stablex.ui.skins.Paint;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Options;
import sx.data.ScoreLoadingType;
import sx.mvc.view.HBoxView;
import sx.mvc.view.VBoxView;
import print.mgr.model.PrinterConfig;
import scorx.model.Configuration;


/**
 * ...
 * @author 
 */
class PrintoutSelectView extends HBoxView 
 {
	public  var availablePrinters:Array<String>;
	 public var optPrinters:Options;
	public var btn:Button;	
	

	
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

		optPrinters = UIBuilder.create(Options);
		optPrinters.options = printerOptions; // [['lion', 1], ['camel', 2], ['elephant', 3]];
		optPrinters.x = 20;
		optPrinters.y = 120;		
		this.addChild(optPrinters);
		
		
		this.btn = UIBuilder.create(Button);
		this.btn.text = "Start printing";
		this.btn.w = 140;
		this.addChild(this.btn);		
		
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
	
	override function onRegister() 
	 {
		trace('PrintoutSelectMediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			// do something...
			//this.status.setStatus(MgrStatus.PrintProcess);
			trace(this.configuration.host);
			trace(this.configuration.productId);
			trace(this.configuration.userId);	
			
			
			var currentPrinter = this.view.availablePrinters[Std.int(this.view.optPrinters.value-1)];
			printerConfig.setPrinterName(currentPrinter);
			
			/*
			var loadOnePageInfo:LoadOnePageInfo = new LoadOnePageInfo();
			loadOnePageInfo.host = configuration.host;
			loadOnePageInfo.productId = configuration.productId;
			loadOnePageInfo.userId = configuration.userId;
			loadOnePageInfo.pageNr =0;
			loadOnePageInfo.type = ScoreLoadingType.print;
			
			var loadOnePage:LoadOnePage = new LoadOnePage(loadOnePageInfo);
			loadOnePage.beforeComplete = function(pageNr:Int, data:BitmapData, type:String)
			{
				var printerName = 'Samsung ML-2150 Series PCL 6';								
				AirAppTools.testPrint(printerName, data);
				
			}
			loadOnePage.start();
			*/
			
			this.printjob.beginPrinting();
			
		};		
		
	}	

}



/*

import print.mgr.view.PrintoutSelect.PrintoutSelectView;
import print.mgr.view.PrintoutSelect.PrintoutSelectMediator;


mediatorMap.mapView(PrintoutSelectView, PrintoutSelectMediator);

*/