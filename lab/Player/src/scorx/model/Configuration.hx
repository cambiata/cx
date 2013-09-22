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
	public var viewLevel(default, null):AccessLevelView;
	
	public var printVersion(default, null):String = "0.1";
	
	//public var playbackChannels(default, null): Array<PlaybackChannel>;
	
	public function setValues(productId:Null<Int> = null, userId:Null<Int> = null, host:Null<String> = null, playbackLevel:Null<String>=null, viewLevel:Null<String>=null, printVersion:Null<String>=null )
	{		
		if (productId != null) this.productId = productId;
		if (userId != null) this.userId = userId;
		if (host != null) this.host = WebTools.addSlash(WebTools.addHttpPrefix(host));
		
		
		this.playbackLevel  = (playbackLevel == null) ? AccessLevelPlay.NoPlayback : EnumTools.createFromString(AccessLevelPlay, playbackLevel);
		this.viewLevel = (viewLevel == null) ? AccessLevelView.OrganizationView : EnumTools.createFromString(AccessLevelView, viewLevel);

		if (printVersion != null) this.printVersion = printVersion;
		
		this.updated.dispatch();
	}
	
	public var updated:Signal0;
	
	static private var MEDIA_GRID:String = 'media/grid';
	static private var MEDIA_SCREEN_COUNT:String = 'media/screen/count';
	
	public function getGridUrl(_productId=0, _userId=0):String
	{
		if (_productId == 0) _productId = this.productId;
		if (_userId == 0) _userId = this.userId;
		var url = '$host$MEDIA_GRID/$_productId/$_userId';
		return url;
	}
	
	public function getScreenCountUrl(_productId=0, _userId=0):String
	{
		if (_productId == 0) _productId = this.productId;
		if (_userId == 0) _userId = this.userId;	
		var url = '$host$MEDIA_SCREEN_COUNT/$_productId';
		return url;		
	}
	
	
}