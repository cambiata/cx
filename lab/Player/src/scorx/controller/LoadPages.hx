package scorx.controller;
import cx.TimerTools;
import flash.display.BitmapData;
import haxe.Unserializer;
import msignal.Signal.Signal0;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import mmvc.impl.Command;
import scorx.model.PlaybackEngine;
import sx.data.ScoreLoader;
import sx.data.ScoreLoadingType;

/**
 * ...
 * @author 
 */

 enum LoadPagesStatus
 {
	 started(nrOfPages:Int);
	 progress(pageInfo:LoadedPageInfo);
	 completed(nrOfPages:Int);
 }
 
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
	public var completed:Signal1<Int>;
	public var failed:Signal1<Dynamic>;
	public var status:Signal1<LoadPagesStatus>;

	public function new() 
	{
		super(LoadParameters);
		started = new Signal1<Int>();
		completed = new Signal1<Int>();
		progress = new Signal1<LoadedPageInfo>();
		failed = new Signal1<Dynamic>(Dynamic);
		
		status = new Signal1<LoadPagesStatus>();
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
		
		Debug.log(['LoadPagesCommand...', loadParameters.productId, loadParameters.userId, loadParameters.host]);
		
		this.loader.setParameters(loadParameters.productId, loadParameters.userId, loadParameters.host);
		
		
		
		this.loader.onPageLoaded = function(pageNr:Int, nrOfPages:Int, data:BitmapData, type:String)
		{			
			Debug.log('loader.onPageLoaded');
			
			trace([pageNr, nrOfPages]);
			if (pageNr == 0) 
			{
				this.loadPages.status.dispatch(LoadPagesStatus.started(nrOfPages));
				Debug.log('loader.started...');
			}
			else if (pageNr == nrOfPages)
			 {
				 this.loadPages.status.dispatch(LoadPagesStatus.progress( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } ));
				 this.loadPages.status.dispatch(LoadPagesStatus.completed(nrOfPages));
				 Debug.log('loader.completed...');
			 }
			 else
			 {
				this.loadPages.status.dispatch(LoadPagesStatus.progress( { pageNr:pageNr, nrOfPages:nrOfPages, data:data } ));				
				 Debug.log('loader.progress...');
			 }
		}
	
		this.loader.loadPages(loadParameters.type);
		
		
	}
	
	
}
