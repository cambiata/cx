package ;


/**
 * ...
 * @author 
 */
class Config
{
	static public var host:String = "http://scorxdev.azurewebsites.net/";
	static public var productId:Int = 1;
	static public var userId:Int = 6;
	
	static public var playbackLevel:String = 'NoPlayback';
	static public var playbackChannelIds:String = "";	
	
	//----------------------------------------------------------------------------------------------------------------------
	
	public static var MANAGER_APPLICATION_ID:String = "print.mgr.ScorxPrintManager";
	public static var MANAGER_PUBLISHER_ID:String = "";		
	public static var MANAGER_APPLICATION_URL = "http://dev.korakademin.se/app/ScorxPrintManager.air";	
	public static var MANAGER_APPLICATION_VERSION:String = "0.301";	
	
	//	
	static public inline var INVOKER_MESSAGE_PRINTJOB:String = "invokerMessagePrintjob";

}