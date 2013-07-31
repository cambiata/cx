package sx.data;
import flash.display.BitmapData;
import mloader.ImageLoader;
import mloader.Loader.Loader;
import mloader.Loader.LoaderEvent;
import mloader.Loader.LoaderEventType;
import mloader.LoaderQueue;
import mloader.StringLoader;

/**
 * ...
 * @author 
 */

 enum ScoreLoadingType 
 {
	 screen;
	 print;
	 thumb;	 
 }
 
class ScoreLoader
{

	static var HOST = "http://scorxdev.azurewebsites.net/";
	var productId:Int;
	var userId:Int;	
	var nrOfPages:Int;
	var typeString:String;
	
	public function new(productId:Int=0, userId:Int=0) 
	{
		this.productId = productId;
		this.userId = userId;
		//loadPages();
	}
	
	public function setParameters(productId:Int = 0, userId:Int = 0)
	{
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
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		//queue.loaded.addOnce(queueFirstPageComplete).forType(LoaderEventType.Complete);
		//queue.loaded.addOnce(function(e) { trace(e); } ).forType(LoaderEventType.Fail);
		
		
		queue.add (getCountLoader());
		queue.add(getPageLoader(0));
		queue.load();
	}	

	function getPageLoader(pageNr:Int):ImageLoader
	{
		var url:String = HOST + 'media/$typeString/$productId/$pageNr/$userId?ext=.png';		
		var imageLoader = new ImageLoaderExt(url, pageNr);
		imageLoader.loaded.addOnce(onImageLoaded).forType(LoaderEventType.Complete);
		return imageLoader;		
	}
	
	function getCountLoader():StringLoader
	{
		var url:String  = HOST + 'media/$typeString/count/$productId?ext=.txt';		
		var countLoader:StringLoader = new StringLoader(url);
		countLoader.loaded.addOnce(onCountComplete) .forType(LoaderEventType.Complete);	
		return countLoader;
	}
	
	function onCountComplete(event:LoaderEvent<String>) 
	{
		var nrOfPages:Int = 1;
		try 
		{
			nrOfPages = Std.parseInt(event.target.content);			
		} catch (e:Dynamic) trace(e);
		
		this.nrOfPages = nrOfPages;
		
		this.onPageLoaded(0, this.nrOfPages, null, this.typeString);
		if (this.nrOfPages > 1) loadOtherPages(this.nrOfPages);
	}	
	
	function onImageLoaded(event:LoaderEvent<Dynamic>) 
	{
		var content = event.target.content;
		var loader:ImageLoaderExt = cast(event.target, ImageLoaderExt);
		var bitmapData:BitmapData = loader.content; // cast(event.target.content, BitmapData);
		var pageNr:Int = loader.idx;		
		this.onPageLoaded(pageNr+1, this.nrOfPages, bitmapData, this.typeString);
	}	
	
	function loadOtherPages(nrOfPages:Int)
	{
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