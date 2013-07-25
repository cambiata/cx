package cx;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.printing.PrintJob;
import flash.printing.PrintUIOptions;
import flash.Vector;
/**
 * ...
 * @author 
 */
class AirAppTools
{

	public function new() 
	{
		
	}
	
	static public  function getPrinters():Array<String>
	{
		var printers = PrintJob.printers;
		var ar = new Array<String>();
		for (printer in printers) ar.push(printer);		
		return ar; 
	}
	
	static var  PRINTER_FILTER = [
				'png',
				'tiff',
				'img',
				'bitmap',
				'bmp',
				//'pdf',
				'document',
				'image',
				'fax',
				'virtual'
			];
	
	
	static public  function getFilteredPrinters(filter:Array<String>=null)
	{
		if (filter == null) filter = PRINTER_FILTER;
		return filterPrinterValues(getPrinters(), filter);
	}
	
	static function filterPrinterValues(printers:Array<String>, filter:Array<String>)
	{
		var result = {passed: new Array<String>(), filtered: new Array<String>()};
		for (printer in printers) {
			var found = false;
			var p:String = printer;
			for (f in filter)
			{
				if (p.toLowerCase().indexOf(f) >= 0) 
				{
					//trace(' filter ' + f + ' found in ' + p + ', continue!');
					result.filtered.push(p);
					found = true;
					continue;
				}
			}
			if (found) continue;
			result.passed.push(printer);
		}
		return result;
	}	
	
	static public function testPrint(printer:String, bitmapData:BitmapData)
	{
		var printJob:PrintJob = new PrintJob();
		printJob.printer = printer;
		//trace('Current printer: ' + printer);
		if (printJob.start2(null, false))
		{
			try
			{
				
				var bitmap = new Bitmap(bitmapData);
				bitmap.width = 630*0.94;
				bitmap.height = 891*0.94;
				var s = new Sprite();
				s.addChild(bitmap);
				printJob.addPage(s);
			}
			catch (e:Dynamic)
			{
				
			}						
			printJob.send();						
		}
	}	
	
	
	
}