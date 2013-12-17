package print.mgr.controller.command;
import cx.command.msignal.Command;
import flash.display.BitmapData;

/**
 * ...
 * @author 
 */
class PrintOnePage extends Command
{
	var printerName:String;
	var data:BitmapData;

	public function new(printerName:String, data:BitmapData) 
	{
		super();
		this.printerName = printerName;
		this.data = data;
	}
	
	override private function execute() 
	{
		trace('PRINT...');
		
	}
	
}