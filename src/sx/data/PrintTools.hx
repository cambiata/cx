package sx.data;
import cx.ByteArrayTools;
import cx.command.msignal.ParallellCommand;
import cx.command.msignal.SerialCommand;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.io.Bytes;

import sx.data.ImageTools.BytesToBitmapCommand;
import cx.command.msignal.Command;

/**
 * ...
 * @author 
 */

 
 
class PrintTools
{

	static var HOST = 'http://scorxdev.azurewebsites.net/';	
	static var URL_PRINT_PAGE = 'media/renderScorePrint/';
	static var URL_PRINT_PAGES_COUNT:String = "media/printPagesCount/";
	var urlLoader:URLLoader;
		
	public function new()
	{
		/*
		try 
		{
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, onCompleteCB );
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) {
				onError(e.text);
			});
			urlLoader.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent) {
				onProgress(e.bytesLoaded, e.bytesTotal);
			});
		}
		catch (err:Dynamic)
		{
			onError(Std.string(err));
		}
		*/
	}
	
	var pagesCount:Int = 0;	
	var targetBitmaps:Array<Bitmap> = null;
	var productId:Int;
	var userId:Int;
	var pagesUrl:String;
	//var pagesBytes:Array<Bytes> = null;
	
	public function loadPages(productId:Int, userId:Int, host:String=null)
	{			
		
		this.pagesCount = 0;
		this.targetBitmaps = new Array<Bitmap>();
		this.productId = productId;
		this.userId = userId;
		//this.pagesBytes = new Array<Bytes>();
		if (host == null) host = HOST;
		this.pagesUrl =   host + URL_PRINT_PAGE;	
		
		try 
		{
			if (host == null) host = HOST;			
			var countUrl = host + URL_PRINT_PAGES_COUNT;
			//-------------------------------------------------------------------------------------------------------------------
			var countPagesCommand = new CountPagesCommand(function(pagesCount:Int) {
				//trace('PagesCount ' + pagesCount);
				this.pagesCount = pagesCount;
				this.onProgress(1, this.pagesCount+1, null);
			}, productId, countUrl);
			
			
			var pageOneBytes:Bytes = null;
			var url = host + URL_PRINT_PAGE;
			//trace(url);			
			var loadPageOneCommand = new LoadPageCommand(loadedPage, productId, userId, 0, this.pagesUrl);
			
			var serial = new SerialCommand([countPagesCommand, loadPageOneCommand]);
			
			serial.addOnce(function() {
				//trace('Parallell ready!');
				if (pagesCount > 1) 
					loadMorePages();
				else
					loadingComplete();
			});
			serial.start();
			//-------------------------------------------------------------------------------------------------------------------
			
		}
		catch (err:Dynamic)
		{
			onError(Std.string(err));
		}
		onStartLoading();
	}
	
	
	private function loadedPage(bytes:Bytes, pageNr:Int)
	{
		
		//trace('Loaded page ' + bytes.length + ' ' + pageNr);
		var bytesToBitmapCommand = new BytesToBitmapCommand(bytes, function(bitmap:Bitmap) {
				//trace('converted to bitmap');				
				this.targetBitmaps[pageNr] = bitmap;							
				this.onProgress(pageNr+2, this.pagesCount+1, bitmap);
			});		
		bytesToBitmapCommand.addOnce(function() {
		});
		bytesToBitmapCommand.start();		
	}
	
	
	
	private function loadMorePages()
	{
		var commands:Array<Command> = [];
		
		for (i in 1...this.pagesCount)
		{
			commands.push(new LoadPageCommand(loadedPage, this.productId , this.userId, i, this.pagesUrl));
		}
		var serial = new SerialCommand(commands);
		serial.addOnce(function() {
			//trace('MorePagesLoaded');		
			this.loadingComplete();
		});
		serial.start();
	}
	
	private  function loadingComplete() 
	{
		//trace('loading complete!');		
		this.onComplete(this.targetBitmaps);
	}

	/*
	function onCompleteCB(e:Event) 
	{
		try 
		{
			var byteArray:ByteArray = cast(e.currentTarget, URLLoader).data;
			var bytes = ByteArrayTools.toBytes(byteArray);
			onComplete(bytes);						
		}
		catch (err:Dynamic)
		{
			onError(Std.string(err));
		}
	}
	*/
	
	//-------------------------------------------------------------------------------
	
	dynamic public  function onComplete(bitmaps:Array<Bitmap>)
	{
		trace('onComplete ' + bitmaps.length + ' bitmaps');		
	}
	
	dynamic public  function onProgress(loaded:Float, total:Float, bitmap:Bitmap=null)
	{
		trace([loaded, total]);		
	}
	
	dynamic public  function onError(msg:String)
	{
		trace(msg);
	}
	
	dynamic  public function onStartLoading() 
	{
		onProgress(0, 0);
		trace('start');
	}
	
	//---------------------------------------------------------------------------------
	
}

class CountPagesCommand extends Command
{
	var productId:Int;
	var resultCallback:Int -> Void;
	var url:String;
	var urlLoader:URLLoader;
	
	public function new (resultCallback:Int->Void, productId:Int, url:String)
	{
		super();
		
		this.resultCallback = resultCallback; 
		this.productId = productId;
		this.url = url + '?ProductId=$productId';
		
		this.urlLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoader.addEventListener(Event.COMPLETE, function(e:Event) 
		{
			var data:String = cast(e.currentTarget, URLLoader).data;
			//trace(data);
			if (this.resultCallback != null) resultCallback(Std.parseInt(data));
			this.complete();
		});
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) {
			trace(e.text);
		});
		urlLoader.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent) {
			//trace(e.bytesLoaded, e.bytesTotal);
		});				
		
	}
	
	override public function execute()
	{
		this.urlLoader.load(new URLRequest(this.url));				
	}
	
}

class LoadPageCommand extends Command
{
	var productId:Int;
	var userId:Int;
	var url:String;
	var urlLoader:URLLoader;
	var pageNr:Int;
	var pagesBytes:Array<Bytes>;
	var loadedPageCallback:Bytes -> Int -> Void;
	
	public function new( loadedPageCallback:Bytes->Int->Void, productId:Int, userId:Int, pageNr:Int, url:String = null)
	{
		super();
		this.productId = productId;
		this.userId = userId;
		this.url = url + '?ProductId=$productId&UserId=$userId&PageNr=$pageNr';
		this.pageNr = pageNr;
		this.loadedPageCallback = loadedPageCallback;
		
		this.urlLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
			var byteArray:ByteArray = cast(e.currentTarget, URLLoader).data;
			var bytes = ByteArrayTools.toBytes(byteArray);					
			//trace(bytes.length);
			this.loadedPageCallback(bytes, this.pageNr);			
			this.complete();
			
		});
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) {
			trace(e.text);
		});
		urlLoader.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent) {
			//trace(e.bytesLoaded, e.bytesTotal);
		});		
	}
	
	override public function execute()
	 {
		//trace(this.url);
		this.urlLoader.load(new URLRequest(this.url));		 
	 }
	
	
}
