package scorx.model;
import cx.EnumTools;
import cx.WebTools;
import msignal.Signal.Signal0;
import scorx.model.AccessLevelPlay;
import scorx.model.utils.ChannelUtils;

/**
 * ...
 * @author 
 */
class Configuration
{
	public function new()
	{
		this.updated = new Signal0();
	}
	
	public var host(default, null):String = "http://scorxdev.azurewebsites.net/";	
	public var productId(default, null):Int = 0;
	public var userId(default, null):Int = 0;	
	
	
	public var playbackLevel(default, null):AccessLevelPlay;
	public var playbackChannels(default, null): Array<PlaybackChannel>;
	
	public function setValues(productId:Null<Int> = null, userId:Null<Int> = null, host:Null<String> = null, playbackLevel:Null<String>=null, playbackChannelIds:Null<String>=null)
	{
		
		if (productId != null) this.productId = productId;
		if (userId != null) this.userId = userId;
		if (host != null) this.host = WebTools.addSlash(WebTools.addHttpPrefix(host));
		
		
		this.playbackLevel  = (playbackLevel == null) ? AccessLevelPlay.NoPlayback : EnumTools.createFromString(AccessLevelPlay, playbackLevel);
		
		if (this.playbackLevel == AccessLevelPlay.FullPlayback)
		{
			this.playbackChannels = [];
			if (playbackChannelIds != null)	
			{
				var channelIds:Array<String> = Std.string(playbackChannelIds).split(",");
				trace(channelIds);
				for (channelId in channelIds) this.playbackChannels.push(ChannelUtils.getChannel(channelId));					
			}
		}
		
		
		this.updated.dispatch();
	}
	
	public var updated:Signal0;
}