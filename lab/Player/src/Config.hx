package ;


/**
 * ...
 * @author 
 */
class Config
{
	static public var host:String =  "http://localhost:2000"; // http://scorxdev.azurewebsites.net"; // "localhost:26446"; // "http://scorxdev.azurewebsites.net/";
	static public var productId:Int = 109;
	static public var userId:Int = 1;
	
	static public var playbackLevel:String = 'FullPlayback';
	static public var viewLevel:String = 'OrganizationView';
	
	//----------------------------------------------------------------------------------------------------------------------
	
	public static var MANAGER_APPLICATION_ID:String = "print.mgr.PrintMgr";
	public static var MANAGER_PUBLISHER_ID:String = "";		
	public static var MANAGER_APPLICATION_URL = "http://dev.korakademin.se/app/PrintMgr.air";	
	public static var MANAGER_APPLICATION_VERSION:String = "0.304";		
	//	
	static public inline var INVOKER_MESSAGE_PRINTJOB:String = "invokerMessagePrintjob";

}