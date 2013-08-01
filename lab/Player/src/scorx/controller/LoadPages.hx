package scorx.controller;
import cx.TimerTools;
import flash.display.BitmapData;
import haxe.Unserializer;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import mmvc.impl.Command;
import scorx.model.Debug;
import sx.data.ScoreLoader;

/**
 * ...
 * @author 
 */

 class LoadParameters
 {
	 public function new() {}
	 public var host:String;
	 public var productId:Int;
	 public var userId:Int;
	 public var type:ScoreLoadingType;
 }
 
 typedef LoadedPageInfo = 
 {
	 pageNr:Int,
	 nrOfPages:Int,
	 data:BitmapData,	 
 }
 
 class LoadPages extends Signal1<LoadParameters>
{	
	public var started:Signal1<Int>;
	public var progress:Signal1<LoadedPageInfo>;
	public var completed:Signal0;
	public var failed:Signal1<Dynamic>;

	public function new() 
	{
		super(LoadParameters);
		started = new Signal1<Int>();
		completed = new Signal0();
		progress = new Signal1<LoadedPageInfo>();
		failed = new Signal1<Dynamic>(Dynamic);
	}
}

class LoadPagesCommand extends Command
{	
	@inject public var loadPages:LoadPages;	
	@inject public var loadParameters:LoadParameters;	 // parameter in LoadPages
	@inject public var debug:Debug;	
	@inject public var loader:ScoreLoader;
	
	public function new() super();	
	
	override public function execute():Void
	{				
		this.loader.setParameters(loadParameters.productId, loadParameters.userId);
		this.loader.loadPages();
		this.loader.onPageLoaded = function(pageNr:Int, nrOfPages:Int, data:BitmapData, type:String)
		{			
			trace([pageNr, nrOfPages]);
			if (pageNr == 0) 
			{
				debug.log('start...');
				loadPages.started.dispatch(nrOfPages);
			}
			else if (pageNr == nrOfPages)
			 {
				 loadPages.progress.dispatch( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } );				 
				 debug.log('complete...');
				 loadPages.completed.dispatch();				 
			 }
			 else
			 {
				 debug.log('progress...');
				loadPages.progress.dispatch( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } );				 
			 }
		}
		
	}
}
