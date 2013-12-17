package print.mgr.controller.command;

import msignal.Signal.Signal1;
import mmvc.impl.Command;
import sx.data.PageLoader;
import sx.data.ScoreLoadingType;
import flash.display.BitmapData;
/**
 * ...
 * @author 
 */

 class LoadOnePageInfo 
 {
	 public function new(){}
	 public var host:String;
	 public var productId:Int;
	 public var userId:Int;	 
	 public var type:ScoreLoadingType;
	 public var pageNr:Int;	
	 public var nrOfPages:Int;
	 
	 
 }
 
 class LoadOnePage extends cx.command.msignal.Command
 {	 
	 var host:String;
	 var productId:Int;
	 var userId:Int;
	 var type:ScoreLoadingType;
	 var pageNr:Int;
	 var nrOfPages:Int;
	 public var pageLoader:PageLoader;

	 public function new(pageInfo:LoadOnePageInfo)
	 {
		 super();
		host = pageInfo.host;
		productId = pageInfo.productId;
		userId = pageInfo.userId;
		type = ScoreLoadingType.print;
		pageNr = pageInfo.pageNr;
		nrOfPages = pageInfo.nrOfPages;
		
		this.pageLoader = new PageLoader(this.productId, this.userId, this.host);
		this.pageLoader.onPageLoaded = onPageLoaded;
		
	 }
	 
	override private function execute() 
	{
			trace('LoadOnePage EXECUTE');
			this.beforeStart(this.pageNr);
			this.pageLoader.loadPages(this.pageNr, this.type);
		
	}
	
	function onPageLoaded(pageNr:Int, data:BitmapData, type:String)
	{
		trace('onPageLoaded $pageNr ');
		this.beforeComplete(pageNr, data, type);
		this.complete();
	}	
	
	dynamic public function beforeStart(pageNr:Int)
	{
		
	}
	
	dynamic public function beforeComplete(pageNr:Int, data:BitmapData, type:String)
	{
		trace('beforeComplete');
	}
	
 }
 
 
 /*
class LoadOnePage extends Signal1<LoadOnePageInfo> 
{
	
	public var completed:Signal1<Int>;
	public var failed:Signal1<Dynamic>;	
	
	public function new() 
	{
		super(LoadOnePageInfo);
		completed = new Signal1<Int>();
		failed = new Signal1<Dynamic>(Dynamic);		
	}
}

class LoadOnePageCommand extends Command
{	
	override public function execute():Void
	{
		trace('LoadOnePageCommand');		
	}
}
*/