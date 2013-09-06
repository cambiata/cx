package sx.data;
import flash.display.BitmapData;
import mloader.ImageLoader;
import mloader.Loader.Loader;
import mloader.Loader.LoaderEvent;
import mloader.Loader.LoaderEventType;
import mloader.Loader.LoaderErrorType;
import mloader.LoaderQueue;
import mloader.StringLoader;
import mloader.JsonLoader;
import scorx.types.ScoreLoadingType;

/**
 * ...
 * @author 
 */
 
class ScoreLoader
{

	static var HOST = "http://scorxdev.azurewebsites.net/";
	var host:String;
	var productId:Int;
	var userId:Int;	
	var nrOfPages:Int;
	var typeString:String;
	
	public function new(productId:Int=0, userId:Int = 0, host:String = null) 
	{
		this.setParameters(productId, userId, host);
	}
	
	public function setParameters(productId:Int = 0, userId:Int = 0, host:String=null)
	{
		this.host = (host != null) ? host : HOST;
		this.productId = productId;
		this.userId = userId;
	}
	
	public function loadPages(type:ScoreLoadingType=null)
	{
		if (type == null) type = ScoreLoadingType.screen;
		typeString = Std.string(type);
		loadFirstPageAndCount();		
	}
	
	function loadFirstPageAndCount() 
	{
		Debug.log('loadFirstPageAndCount');
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 1;
		queue.ignoreFailures = false;
		//queue.add(getInfoLoader());
		queue.add (getCountLoader());
		queue.add(getPageLoader(0));
		queue.load();
	}	

	function getPageLoader(pageNr:Int):ImageLoader
	{
		var url:String = this.host + 'media/$typeString/$productId/$pageNr/$userId?ext=.png';		
		Debug.log('getPageLoader: ' + url);
		var imageLoader = new ImageLoaderExt(url, pageNr);
		imageLoader.loaded.addOnce(onImageLoaded).forType(LoaderEventType.Complete);		
		return imageLoader;		
	}
	
	function getCountLoader():StringLoader
	{
		var url:String  =  this.host + 'media/$typeString/count/$productId?ext=.txt';	
		Debug.log('getCountLoader: ' + url);
		var countLoader:StringLoader = new StringLoader(url);
		countLoader.loaded.addOnce(onCountComplete).forType(LoaderEventType.Complete);	
		return countLoader;
	}
	
	function getInfoLoader():JsonLoader<Dynamic>
	{
		var url:String  =  this.host + 'media/info/$productId/$userId?ext=.json';	
		Debug.log('getInfoLoader: ' + url);
		var infoLoader:JsonLoader<Dynamic> = new JsonLoader<Dynamic>(url);
		infoLoader.loaded.addOnce(onInfoComplete).forType(LoaderEventType.Complete);	
		return infoLoader;
	}
	
	//-------------------------------------------------------------------------------------------------------------
	
	function onInfoComplete(event:LoaderEvent<Dynamic>) 
	{
		switch (event.type)
		{
			case Complete: 
				Debug.log('Info loaded successfully');				
			case Fail(e): 		    
				Debug.log("Info Loader failed: " + e);
				return;	
			default:
		}		
		
		Debug.log('onInfoComplete SUCCESS');
		Debug.log(event.target.content);
	}
	
	function onCountComplete(event:LoaderEvent<String>) 
	{
	
		Debug.log('onCountComplete');
		var nrOfPages:Int = 1;
		try 
		{
			nrOfPages = Std.parseInt(event.target.content);			
			
			if (nrOfPages  == 0) 
			{
				Debug.log('onCountComplete nrOfPages IS 0!!!');
				nrOfPages = 1;
			}
			
		} catch (e:Dynamic) trace(e);
		
		this.nrOfPages = nrOfPages;
		
		this.onPageLoaded(0, this.nrOfPages, null, this.typeString);
		if (this.nrOfPages > 1) loadOtherPages(this.nrOfPages);
	}	
	
	function onImageLoaded(event:LoaderEvent<Dynamic>) 
	{
		switch (event.type)
		{
			case Complete: Debug.log('Image loaded successfully');
			case Fail(e): 		    
				Debug.log("Image Loader failed: " + e);
				return;	
			default:
		}
		
		var content = event.target.content;
		var loader:ImageLoaderExt = cast(event.target, ImageLoaderExt);
		var bitmapData:BitmapData = null; 
		
		#if js
			trace(event.target.content);
			//bitmapData = content; // cast(event.target.content, BitmapData);			
		#else
			bitmapData = loader.content; 
		#end
		
		var pageNr:Int = loader.idx;		
		this.onPageLoaded(pageNr+1, this.nrOfPages, bitmapData, this.typeString);
	}	
	
	function loadOtherPages(nrOfPages:Int)
	{
		Debug.log('loadOtherPages');
		if (nrOfPages < 2 ) throw "This shouldn't happen!";
		
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.loaded.addOnce(queueOtherPagesComplete).forType(LoaderEventType.Complete);				
		for (pageNr in 1...nrOfPages)
		{
			queue.add(getPageLoader(pageNr));						
		}
		queue.load();
		
	}
	
	function queueFirstPageComplete(event:LoaderEvent<Dynamic>) 
	{
		//trace("LoaderQueue completed");
	}	
	
	function queueOtherPagesComplete(event:LoaderEvent<Dynamic>) 
	{
		//trace("LoaderOtherPagesQueue completed");
	}
	
	//-----------------------------------------------------------------------------------------
	
	dynamic public function onPageLoaded(pageNr:Int, nrOfPages:Int, data:BitmapData, type:String)
	{
		trace('onPageLoaded $pageNr / $nrOfPages ');
	}
}