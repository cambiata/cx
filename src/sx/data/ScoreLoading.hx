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
class ScoreLoading
{

	static var HOST = "http://scorxdev.azurewebsites.net/";
	var productId:Int;
	var userId:Int;
	
	var nrOfPages:Int;
	
	public function new(productId:Int, userId:Int=0) 
	{
		this.productId = productId;
		this.userId = userId;
		loadPages();
	}
	
	function loadPages()
	{
		loadFirstPageAndCount();		
	}
	
	function loadFirstPageAndCount() 
	{
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.loaded.addOnce(queueFirstPageComplete).forType(LoaderEventType.Complete);
		
		queue.add (getCountLoader());
		queue.add(getPageLoader(0));
		queue.load();
	}	
	


	function getPageLoader(pageNr:Int):ImageLoader
	{
		var url:String = HOST + 'media/renderscorescreen?ProductId=${this.productId}&UserId=${this.userId}&PageId=$pageNr&ext=.png';
		var imageLoader = new ImageLoaderExt(url, pageNr);
		imageLoader.loaded.addOnce(onImageLoaded).forType(LoaderEventType.Complete);
		return imageLoader;		
	}
	
	function getCountLoader():StringLoader
	{
		var url:String  = HOST + 'media/screencount/$productId';
		var countLoader:StringLoader = new StringLoader(url);
		countLoader.loaded.addOnce(onCountComplete).forType(LoaderEventType.Complete);	
		return countLoader;
	}
	
	
	function onCountComplete(event:LoaderEvent<String>) 
	{
		var nrOfPages = Std.parseInt(event.target.content);
		this.nrOfPages = nrOfPages;
		this.onPageLoaded(0, this.nrOfPages, null);
		if (nrOfPages > 1) loadOtherPages(nrOfPages);
	}	
	
	function onImageLoaded(event:LoaderEvent<Dynamic>) 
	{
		var content = event.target.content;
		var loader:ImageLoaderExt = cast(event.target, ImageLoaderExt);
		var bitmapData:BitmapData = loader.content; // cast(event.target.content, BitmapData);
		var pageNr:Int = loader.idx;		
		this.onPageLoaded(pageNr+1, this.nrOfPages, bitmapData);
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
	
	dynamic public function onPageLoaded(pageNr:Int, nrOfPages:Int, data:BitmapData)
	{
		trace('onPageLoaded $pageNr / $nrOfPages ');
	}
}