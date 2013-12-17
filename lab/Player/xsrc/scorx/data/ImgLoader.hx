package scorx.data;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import msignal.Signal.Signal1;

/**
 * ...
 * @author Jonas Nyström
 */

class ImgLoader 
{
	public var result:Signal1<ImgResult>;
	
	var url:String;
	var loaderInfo:LoaderInfo;
	var loader:Loader;
	public var pageNr(default, null):Int;
	
	public function new()
	{
		this.result = new Signal1<ImgResult>();
		this.loader = new Loader();
		this.loaderInfo = this.loader.contentLoaderInfo;
		loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
		loaderInfo.addEventListener(Event.COMPLETE, onComplete);
		loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			
	}		
	
	private function onComplete(e:Event):Void 
	{
		var loaderInfo:LoaderInfo = cast(e.target, LoaderInfo);		
		var data:BitmapData = cast(this.loader.content, Bitmap).bitmapData;				
		this.result.dispatch(ImgResult.data(data, this.pageNr));
	}
	
	private function onIOError(e:IOErrorEvent):Void 
	{	
		this.result.dispatch(ImgResult.error("ImgLoader IO Error " + Std.string(e), this.url));
	}
	
	private function onProgress(e:ProgressEvent):Void 
	{		
		this.result.dispatch(ImgResult.progress(e.bytesLoaded, e.bytesTotal, this.pageNr));
	}
	
	public function load(url:String, pageNr:Int=0)
	{
		this.url = url;
		
		this.url += '?ext=.png';

		this.pageNr = pageNr;
		this.loader.load(new URLRequest(this.url));		
	}
	
}

enum ImgResult 
{
	data(data:BitmapData, pageNr:Int);
	progress(bytesLoaded:Float, bytesTotal:Float, pageNr:Int);
	error(message:String, url:String);	
}