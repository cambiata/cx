package scorx.data;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;
import msignal.Signal.Signal1;
import flash.net.URLRequest;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
/**
 * ...
 * @author Jonas Nyström
 */
class DataLoader
{
	public var result:Signal1<DataResult>;
	var url:String;
	var loader:URLLoader;
	var tag:String;
	
	public function new() 
	{
		this.result = new Signal1<DataResult>();
		this.loader = new URLLoader();
		this.loader.dataFormat = URLLoaderDataFormat.BINARY;
		this.loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
		this.loader.addEventListener(Event.COMPLETE, onComplete);
		this.loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);			
	}
	
	private function onComplete(e:Event):Void 
	{
		var data:ByteArray = this.loader.data;		
		this.result.dispatch(DataResult.data(data, this.tag));
	}
	
	private function onIOError(e:Event):Void 
	{
		this.result.dispatch(DataResult.error("DataLoader IO Error " + Std.string(e), this.url));
	}
	
	private function onProgress(e:ProgressEvent):Void 
	{
		this.result.dispatch(DataResult.progress(e.bytesLoaded, e.bytesTotal, this.tag));
	}
	
	public function load(url:String, tag:String='')
	{
		this.url = url;
		this.tag = tag;
		this.loader.load(new URLRequest(this.url));		
	}	
	
}


enum DataResult 
{
	data(data:ByteArray, tag:String);
	progress(bytesLoaded:Float, bytesTotal:Float, tag:String);
	error(message:String, url:String);	
}