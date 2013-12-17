package print.mgr.model;
import cx.ArrayTools;

/**
 * ...
 * @author 
 */
class PrinterConfig
{

	public var printPages(default, null):Map<Int, Bool>;
	public var printerName(default, null):String = 'PDFCreator';
	
	public function new() 
	{
		this.printPages = new Map<Int, Bool>();
	}
	
	public function init(nrOfPages:Int)
	{
		for (nr in 0...nrOfPages)
		{
			this.printPages.set(nr, true);
		}
	}
	
	
	public function getPages():Array<Int>
	{
		return ArrayTools.fromIterator(this.printPages.keys());
		
	}
	
	public function getSelectedPages():Array<Int>
	{
		var result:Array<Int> = [];
		for (pageNr in this.printPages.keys())
		{
			if (printPages.get(pageNr)) result.push(pageNr);
		}		
		return result;
	}
	
	public function setPage(pageNr:Int, value:Bool)
	{
		this.printPages.set(pageNr, value);
	}
	
	
	public function setPrinterName(name:String)
	{
		this.printerName = name;
	}
	
	
}