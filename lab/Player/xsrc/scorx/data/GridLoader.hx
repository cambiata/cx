package scorx.data;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import msignal.Signal.Signal1;

/**
 * ...
 * @author Jonas Nyström
 */
class GridLoader
{
	var urlLoader:URLLoader;
	var url:String;

	var host:String;
	var productId:Int;
	var userId:Int;	
	
	public function new() 
	{
		this.result = new Signal1<GridResult>();
		urlLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
			trace('complete');
			var urlLoader:URLLoader = cast(e.target, URLLoader);
			var xmlString:String = urlLoader.data;			
			trace(xmlString);
			try 
			{
				var xml:Xml = Xml.parse(xmlString);				
			} 
			catch (e:Dynamic)
			{
				trace('XML error! ' + Std.string(e));
				this.result.dispatch(GridResult.error('Grid XML error', this.url));
				return;
			}										
			this.result.dispatch(GridResult.success(xmlString));			
		});
		
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event) {
			trace('Load error ' + url);
			this.result.dispatch(GridResult.error('Grid Loader IO error', this.url));
		});				
	}
	
	public var result:Signal1<GridResult>;
	
	public function load(host:String, productId:Int, userId:Int)
	{
		this.host = host;
		this.productId = productId;
		this.userId = userId;		
		
		this.url = '${this.host}media/grid/${this.productId}';
		trace(this.url);
		this.urlLoader.load(new URLRequest(url));
	}
	

	
	
}

enum GridResult
{
	success(xmlString:String);
	error(message:String, url:String );	
}

