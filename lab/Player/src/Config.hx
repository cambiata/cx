package ;


/**
 * ...
 * @author 
 */
class Config
{
	static public var host:String =  "http://localhost:8080"; // http://scorxdev.azurewebsites.net"; // "localhost:26446"; // "http://scorxdev.azurewebsites.net/";
	static public var productId:Int = 1;
	static public var userId:Int = 1;
	
	static public var playbackLevel:String = 'FullPlayback';
	static public var viewLevel:String = 'OrganizationView';
	static public var printVersion:String = "0.402";
	
	static public var drawGrid:Bool = false;
	
	//----------------------------------------------------------------------------------------------------------------------
	
	public static var MANAGER_APPLICATION_ID:String = "print.mgr.ScorxPrint";
	public static var MANAGER_PUBLISHER_ID:String = "";		
	public static var MANAGER_APPLICATION_URL = "http://dev.korakademin.se/app/ScorxPrint.air";	
	
	//public static var MANAGER_APPLICATION_VERSION:String = "0.304";		
	//	
	
	static public inline var INVOKER_MESSAGE_PRINTJOB:String = "invokerMessagePrintjob";

}