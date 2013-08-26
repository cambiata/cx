package scorx.data;

import flash.utils.ByteArray;
import haxe.Json;
import mloader.JsonLoader;
import mloader.HttpLoader;
import mloader.Loader.Loader;
import mloader.Loader.LoaderEvent;
import mloader.Loader.LoaderEventType;
import mloader.Loader.LoaderErrorType;
import mloader.LoaderQueue;
import mloader.StringLoader;
import tjson.TJSON;
/**
 * ...
 * @author 
 */
class ChannelsLoader
{

	static var HOST = "http://scorxdev.azurewebsites.net/";
	var host:String;
	var productId:Int;
	var userId:Int;		
	var channelIds:Array<String>;
	
	public function new(productId:Int=0, userId:Int = 0, host:String = null) 
	{
		this.setParameters(productId, userId, host);
		this.channelIds = [];
	}
	
	public function setParameters(productId:Int = 0, userId:Int = 0, host:String=null)
	{
		this.host = (host != null) ? host : HOST;
		this.productId = productId;
		this.userId = userId;
	}
	
	public function loadChannels()
	{
		Debug.log('LOAD CHANNELS::::');
		loadChannelsInfo();				
	}
	
	function loadChannelsInfo()
	{
		Debug.log('loadChannelsInfo');
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.add(getInfoLoader());
		queue.load();		
	}
	
	function getInfoLoader():StringLoader
	{
		var url:String  =  this.host + 'media/info/$productId/$userId?ext=.json';	
		Debug.log('getInfoLoader: ' + url);
		var infoLoader:StringLoader = new StringLoader(url);
		infoLoader.loaded.addOnce(onInfoComplete).forType(LoaderEventType.Complete);	
		return infoLoader;
	}
	
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
		Debug.log('LoadChannels onInfoComplete SUCCESS');
		Debug.log(event.target.content);
		var content:String = StringTools.replace(Std.string(event.target.content), "/", "");
		content = StringTools.replace(content, "\\", "");
		//content = '"json":' + content;		
		Debug.log(content);
		var dyn:Dynamic = TJSON.parse(content);
		
		try 
		{
			Debug.log(dyn.PlayDetails.Channels);		
			var channels:Array<Dynamic> = cast dyn.PlayDetails.Channels;
			
			for (channel in channels)
			{
				this.channelIds.push(channel.ChannelId);
			}
			
		} catch (e:Dynamic) trace(e);

		
		this.onChannelLoaded(0, "", this.channelIds, null);
		
		if (this.channelIds.length > 0) 
		{
			loadChannels2();
		}
	}	
	
	
	var loadedChannelCount:Int = 0;
	
	function loadChannels2()
	{
		Debug.log('loadOtherChannels');		
		this.loadedChannelCount = 0;
		var queue:LoaderQueue = new LoaderQueue();
		queue.maxLoading = 2;
		queue.ignoreFailures = false;
		queue.loaded.addOnce(queueChannelsComplete).forType(LoaderEventType.Complete);				
		for (channelId in this.channelIds)
		{
			trace('channelId... ' + channelId);
			queue.add(getChannelLoader(channelId));						
			
		}
		queue.load();
		
	}	
	
	function queueChannelsComplete(event:Dynamic) 
	{
		
	}
	
	
	dynamic public function onChannelLoaded(channelNr:Int, channelId:String, channelIds:Array<String>, data:ByteArray) 
	{
		trace('onChannelLoaded $channelNr / $channelIds.length ');
	}
	
	function getChannelLoader(channelId:String):BytearrayLoader
	{
		var url:String = this.host + 'media/channel/$productId/$channelId/$userId?ext=.png';		
		Debug.log('getChannelLoader: ' + url);
		var loader = new BytearrayLoader(url, channelId);
		loader.loaded.addOnce(onChannelComplete).forType(LoaderEventType.Complete);		
		return loader;		
	}	
	
	function onChannelComplete(event:LoaderEvent<Dynamic>) 
	{
		trace("onChannelComplete");
		var loader:BytearrayLoader = cast(event.target, BytearrayLoader);
		trace(loader.tag);
		var data:ByteArray = loader.content;
		trace(data.length);
		
		this.loadedChannelCount++;
		this.onChannelLoaded(this.loadedChannelCount, loader.tag, this.channelIds, data);
	}
	
	
}