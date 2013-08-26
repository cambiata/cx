package scorx.model.utils;
import scorx.model.PlaybackChannel;

/**
 * ...
 * @author 
 */
class ChannelUtils
{

	static public function getChannel(channelId:String) :PlaybackChannel
	{
		channelId = StringTools.trim(channelId);
		return new PlaybackChannel(channelId, getChannelLabel(channelId));
	}
	
	static public function getChannelLabel(channelId:String): String
	{
		switch(channelId)
		{
			case "090": return "Lead";
			
			case "100": return "Sopran";
			case "101": return "Sopran 1";
			case "102": return "Sopran 2";
			
			case "110": return "Alt";
			case "111": return "Alt 1";
			case "112": return "Alt 2";
			
			case "120": return "Tenor";
			case "121": return "Tenor 1";
			case "122": return "Tenor 2";
			
			case "130": return "Bas";
			case "131": return "Bas 1";
			case "132": return "Bas 2";
			
			case "200": return "Komp";
			
			default: return "Unknown (" + channelId + ")";
		}
		
		return "Unknown (" + channelId + ")";
	}
}