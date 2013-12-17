package print.mgr.model;
import cx.AirAppTools;
import cx.ArrayTools;
import cx.command.msignal.Command;
import cx.command.msignal.SerialCommand;
import flash.display.BitmapData;
import pgr.gconsole.GameConsole;
import print.mgr.controller.command.LoadOnePage;
import scorx.model.Configuration;
import sx.data.ScoreLoadingType;

/**
 * ...
 * @author 
 */
class Printjob
{
	@inject public var configuration:Configuration;
	@inject public var printerConfig:PrinterConfig;
	@inject public var status:Status;
	
	var serialPringing:SerialCommand ;
	var printerName:String;
	var selectedPages:Array<Int>;
	
	public function new()
	{
		
		
	}
	
	public function beginPrinting()
	{
		trace('beginPrinting');
		printerName = this.printerConfig.printerName;								
		trace(printerName);
		if (printerName == null || printerName == '') 
		{
			GameConsole.log('No printerName!');
			return;
		}
		
		selectedPages = printerConfig.getSelectedPages();		
		if (selectedPages.length < 1)
		{
			GameConsole.log('No pages to print!');
			return;			
		}
		trace('beginPrinting2');
		
		var commands:Array<Command> = [];		
		for (pageNr in selectedPages)
		{			
			commands.push(getPrintCommand(pageNr, selectedPages.length));		
		}		
		this.serialPringing = new SerialCommand(commands);
		this.serialPringing.add(printingComplete);
		this.serialPringing.start();
	}
	
	function printingComplete() 
	{
		this.status.setStatus(MgrStatus.PrintDone);
	}
	
	function getPrintCommand(pageNr:Int, nrOfPages:Int) 
	{
			trace('get print command page $pageNr/$nrOfPages');
		
			var loadOnePageInfo:LoadOnePageInfo = new LoadOnePageInfo();
			loadOnePageInfo.host = configuration.host;
			loadOnePageInfo.productId = configuration.productId;
			loadOnePageInfo.userId = configuration.userId;
			loadOnePageInfo.pageNr =pageNr;
			loadOnePageInfo.type = ScoreLoadingType.print;
			
			var loadOnePage:LoadOnePage = new LoadOnePage(loadOnePageInfo);
			
			loadOnePage.beforeStart = function(pageNr:Int)
			{
				var currentPageIdx:Int = Lambda.indexOf(selectedPages, pageNr);
				this.status.setStatus(MgrStatus.PrintProcess(currentPageIdx+1, nrOfPages, 'load'));
			}
			
			loadOnePage.beforeComplete = function(pageNr:Int, data:BitmapData, type:String)
			{				
				this.status.setStatus(MgrStatus.PrintProcess(pageNr+1, nrOfPages, 'print'));				
				AirAppTools.testPrint(printerName, data);				
			}
			return loadOnePage;
			//loadOnePage.start();		
	}
}

