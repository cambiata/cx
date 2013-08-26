package sx.data;

import sx.data.ScoreLoadingType;
import mloader.ImageLoader;
import mloader.Loader.Loader;
import mloader.Loader.LoaderEvent;
import mloader.Loader.LoaderEventType;
import mloader.LoaderQueue;
import mloader.StringLoader;
import flash.display.BitmapData;

/**
 * ...
 * @author 
 */
class PageLoader
{

	static var HOST = "http://scorxdev.azurewebsites.net/";
	var host:String;
	var productId:Int;
	var userId:Int;	
	var pageNr:Int;
	var type:ScoreLoadingType;	
	
	public function new(productId:Int=0, userId:Int=0, host:String=null) 
	{
		this.setParameters(productId, userId, host);
	}

	public function setParameters(productId:Int = 0, userId:Int = 0, host:String=null)
	{
		this.productId = productId;
		this.userId = userId;
		this.host = (host != null) ? host : HOST;
	}	
	
	public function loadPages(pageNr:Int, type:ScoreLoadingType=null)
	{
		//if (type == null) type = ScoreLoadingType.screen;
		this.type = ScoreLoadingType.print;
		this.pageNr = pageNr;
		loadPage();		
	}	
	
	function loadPage() 
	{
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.add(getPageLoader(this.pageNr));
		queue.load();
	}		
	
	function getPageLoader(pageNr:Int):ImageLoader
	{
		var typeString = Std.string(this.type);
		var url:String = this.host + 'media/$typeString/$productId/$pageNr/$userId?ext=.png';		
		trace(url);
		var imageLoader = new ImageLoaderExt(url, pageNr);
		imageLoader.loaded.addOnce(onImageLoaded).forType(LoaderEventType.Complete);
		return imageLoader;		
	}	
	
	function onImageLoaded(event:LoaderEvent<Dynamic>) 
	{
		var content = event.target.content;
		var loader:ImageLoaderExt = cast(event.target, ImageLoaderExt);
		var bitmapData:BitmapData = loader.content; // cast(event.target.content, BitmapData);
		var pageNr:Int = loader.idx;		
		this.onPageLoaded(pageNr+1, bitmapData, Std.string(this.type));
	}		
	
	dynamic public function onPageLoaded(pageNr:Int, data:BitmapData, type:String)
	{
		trace('onPageLoaded $pageNr ');
	}	
	
	
}