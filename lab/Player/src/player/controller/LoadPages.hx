package player.controller;
import cx.TimerTools;
import flash.display.BitmapData;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import mmvc.impl.Command;
import player.model.ProductModel;
import sx.data.ScoreLoader;

/**
 * ...
 * @author 
 */

 typedef LoadPagesInfo = 
 {
	 pageNr:Int,
	 nrOfPages:Int,
	 data:BitmapData,	 
 }
 
 
class LoadPages extends Signal1<String>
{
	
	public var started:Signal1<Int>;
	public var progress:Signal1<LoadPagesInfo>;
	public var completed:Signal0;
	
	public var failed:Signal1<Dynamic>;

	public function new() 
	{
		super(String);
		
		started = new Signal1<Int>();
		completed = new Signal0();
		progress = new Signal1<LoadPagesInfo>();
		failed = new Signal1<Dynamic>(Dynamic);
	}
}

class LoadPagesCommand extends Command
{
	
	@inject public var loadPages:LoadPages;
	@inject public var url:String;	
	@inject public var loader:ScoreLoader;
	@inject public var product:ProductModel;
	
	public function new() super();	
	
	override public function execute():Void
	{		
		this.loader.setParameters(product.productId, product.userId);
		this.loader.loadPages();
		this.loader.onPageLoaded = function(pageNr:Int, nrOfPages:Int, data:BitmapData, type:String)
		{			
			trace([pageNr, nrOfPages]);
			if (pageNr == 0) 
			{
				trace('start...');
				loadPages.started.dispatch(nrOfPages);
				
				
			}
			else if (pageNr == nrOfPages)
			 {
				 loadPages.progress.dispatch( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } );				 
				 trace('complete...');
				 loadPages.completed.dispatch();				 
			 }
			 else
			 {
				 trace('progress...');
				loadPages.progress.dispatch( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } );				 
			 }
		}
	}
}
