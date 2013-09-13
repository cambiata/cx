package scorx.data;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import msignal.Signal.Signal1;
import flash.display.LoaderInfo;
import scorx.data.ImgLoader.ImgResult;

/**
 * ...
 * @author Jonas Nyström
 */
class PagesLoader
{
	public var result:Signal1<PagesResult>;
	
	var countLoader:URLLoader;	
	var url:String;
	var countUrl:String;
	
	var host:String;
	var productId:Int;
	var userId:Int;
	
	var nrOfPages:Int;
	var nrOfLoaded:Int;

	public function new() 
	{		
		this.result = new Signal1<PagesResult>();
		
		this.countLoader = new URLLoader();
		this.countLoader.dataFormat = URLLoaderDataFormat.TEXT;
		this.countLoader.addEventListener(Event.COMPLETE, countComplete);
		this.countLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event) {this.result.dispatch(PagesResult.error('ScreenLoader Count IO error', this.url)); trace('IOERROR');} );		
		
	}
	
	private function countComplete(e:Event):Void 
	{
		trace('complete');
		var urlLoader = cast(e.target, URLLoader);
		var data = urlLoader.data;
		var nrOfPages:Int = -1;
		try 
		{
			nrOfPages = Std.parseInt(data);			
		}
		catch (e:Dynamic)
		{			
			this.result.dispatch(PagesResult.error('ScreenLoader Count data format error: ' + Std.string(e), this.countUrl));
			return;
		}
		if (nrOfPages < 1) 
		{
			this.result.dispatch(PagesResult.error('ScreenLoader Count Nr of pages error: Nr of pages =' + Std.string(nrOfPages), this.countUrl));
			return;
		}
		this.result.dispatch(PagesResult.started(nrOfPages));
		this.loadPages(nrOfPages);		
	}
	
	
	
	public function load(host:String, productId:Int, userId:Int)
	{
		this.host = host;
		this.productId = productId;
		this.userId = userId;
		
		this.countUrl = '${host}media/screen/count/$productId';
		this.countLoader.load(new URLRequest(countUrl));
	}
	
	private function loadPages(nrOfPages)
	{
		this.nrOfLoaded = 0;
		
		this.nrOfPages = nrOfPages;		
		for (pageNr in 0...nrOfPages)
		{
			var url = '${this.host}media/screen/${this.productId}/$pageNr/${this.userId}';
			trace(url);			
			var imgLoader:ImgLoader = new ImgLoader();		
			imgLoader.result.add(onImgLoaderResult);
			imgLoader.load(url, pageNr);			
		}		
	}
	
	function onImgLoaderResult(result:ImgResult) 
	{
		switch(result)
		{
			case ImgResult.data(data, pageNr):
				this.result.dispatch(PagesResult.success(pageNr, this.nrOfPages, data));
				this.nrOfLoaded++;
				if (this.nrOfLoaded == this.nrOfPages) this.result.dispatch(PagesResult.complete(this.nrOfPages));
			case ImgResult.error(message, url):
				trace(message);
			case ImgResult.progress(bytesLoaded, bytesTotal, pageNr):
		}
	}
	
}

enum PagesResult
{
	started(nrOfPages:Int);	
	success(pageNr:Int, nrOfPages:Int, data:BitmapData);
	complete(nrOfPages:Int);
	error(message:String, url:String );	
}