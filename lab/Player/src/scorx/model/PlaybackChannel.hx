package scorx.model;

/**
 * ...
 * @author 
 */
class PlaybackChannel
{
	public var channelId:String;
	public var channelLabel:String;

	public function new(channelId:String, channelLabel:String) 
	{
		this.channelId = channelId;
		this.channelLabel = channelLabel;
	}
	
}