package scorx.data;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import haxe.Json;
import scorx.data.DataLoader;
import scorx.data.DataLoader.DataResult;
import msignal.Signal.Signal1;
import sx.player.TPlaybackChannels;

/**
 * ...
 * @author Jonas Nyström
 */
class ChannelsLoader
{
	public var result:Signal1<ChannelsResult>;
	
	var countLoader:URLLoader;	
	var infoUrl:String;
	
	var host:String;
	var productId:Int;
	var userId:Int;
	
	var nrOfChannels:Int;
	var nrOfLoaded:Int;	
	
	var labels:Map<String, String>;
	
	
	public function new() 
	{
		this.result = new Signal1<ChannelsResult>();		
		this.countLoader = new URLLoader();
		this.countLoader.dataFormat = URLLoaderDataFormat.TEXT;
		this.countLoader.addEventListener(Event.COMPLETE, countComplete);
		this.countLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:Event) {this.result.dispatch(ChannelsResult.error('ChannelsLoader Count IO error', this.infoUrl)); trace('IOERROR');} );		
	}	
	
	public function load(host:String, productId:Int, userId:Int)
	{
		trace('load Channels');
		this.host = host;
		this.productId = productId;
		this.userId = userId;
		this.infoUrl = '${host}media/channels/$productId';
		this.countLoader.load(new URLRequest(this.infoUrl));
	}	
	
	private function countComplete(e:Event):Void 
	{
		trace('complete');
		var urlLoader = cast(e.target, URLLoader);
		var data = urlLoader.data;
		this.channels = null;
		try 
		{
			this.channels = Json.parse(data);			
			trace(channels);
		}
		catch (e:Dynamic)
		{			
			this.result.dispatch(ChannelsResult.error('ChannelsLoader Count data format error: ' + Std.string(e), this.infoUrl));
			return;
		}
		
		if (channels.length < 1) 
		{
			this.result.dispatch(ChannelsResult.error('ChannelsLoader Count Nr of channels error: Nr of channels =' + Std.string(channels.length), this.infoUrl));
			return;
		}
		
		this.channels.sort( function(a, b) return Reflect.compare(a.Id, b.Id) );
		this.result.dispatch(ChannelsResult.started(channels));
		this.loadChannels(channels);			
	}
	
	public function loadChannels(channels:TPlaybackChannels) 
	{
		this.nrOfLoaded = 0;
		this.nrOfChannels = channels.length;
		this.channelsData = [];
		this.labels = new Map<String,String>();		
		
		for (channel in channels)
		{
			this.labels.set(channel.Id, channel.Label);
			var url = '${this.host}media/channel/${this.productId}/${channel.Id}/${this.userId}';
			trace(url);
			var dataLoader:DataLoader = new DataLoader();
			dataLoader.result.add(onDataResult);
			dataLoader.load(url, channel.Id);
		}		
	}
	
	private var channelsData:TChannelsData;
	var channels:TPlaybackChannels;
	
	function onDataResult(result:DataResult) 
	{
		switch(result)
		{
			case DataResult.data(data, tag):
				this.result.dispatch(ChannelsResult.loaded(data, tag));
				
				this.channelsData.push( { id:tag, label:'XYZ', data:data} );								
				if (this.channelsData.length == this.nrOfChannels) {
					
					this.channelsData.sort( function(a, b) return Reflect.compare(a.id, b.id) );
					
					this.result.dispatch(ChannelsResult.complete(this.channelsData));
				}
			case DataResult.error(message, url):
				trace(message);
			case DataResult.progress(bytesLoaded, bytesTotal, pageNr):				
		}
	}
}



enum ChannelsResult
{
	started(channels:TPlaybackChannels);	
	loaded(data:ByteArray, tag:String);
	complete(channelsData:TChannelsData);
	error(message:String, url:String );	
}


