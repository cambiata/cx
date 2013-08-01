package ;

/**
 * ...
 * @author 
 */
class Config
{
	public static var APPLICATION_ID:String = "air.AirApplication";
	public static var PUBLISHER_ID:String = "";
	
	public static var AIR_RUNTIME_DOWNLOAD_URL = "http://get.adobe.com/air/";
	public static var APPLICATION_URL = "http://dev.korakademin.se/app/AirApplication.air";
	
	public static var AIR_SWF_URL:String = "http://airdownload.adobe.com/air/browserapi/air.swf";
	public static  var airversion:String = "1.0";

	public static inline var INVOKER_MESSAGE_PRINTJOB = 'printjob';
	public static inline var SCORX_PRINT_MANAGER = "Scorx Print Manager";
	public static inline var SCORX_PRINT_INVOKER = "Scorx Print Invoker";
	
	public static inline var INVOKER_START_PRINT = "Start Print Manager";
	static public inline var INVOKER_INSTALL:String = "Install Print Manager";
	static public inline var INVOKER_NOT_AVALIABLE_MESSAGE:String = "Sorry! Scorx Print Manager is not available for this device.";
	static public inline var INVOKER_EXTERNAL_STATUS_MESSAGE:String = 'invokePrintingMessage';
	static public inline var INVOKER_CONTROLLING_INSTALLATION_MESSAGE:String = "Checking Print Manager installation...";

	static public inline var MANAGER_INSTALLATION_SUCCESS:String = "Installation finished successfully!";
	static public inline var MANAGER_NOTHING_TO_DO:String = "No Printjob";
	static public inline var MANAGER_START_PRINTING:String = "Print!";
	static public inline var MANAGER_SELECT_PRINTER:String = "Klick below to select printer";
	static public inline var MANAGER_READY_TO_PRINT:String = "Ready to print";
	static public inline var MANGER_LOADING:String = "Loading pages...";
	
	static public inline var SERVER_HOST:String = "http://scorxdev.azurewebsites.net/";
	
	static public inline var TEXT_SIZE_BIG = 18;
	
	public static var userId:Int = 123;
	public static var productId:Int = 234;
	
	/*
	public static  var appinstallarg:Array<String> = [];
	public static  var applauncharg:Array<String> = [];
	public static  var appid:String = "air.AirApplication";
	public static  var appname:String = "AirApplication";
	public static  var appurl:String = "CONFIG-URL";
	public static  var appversion:String = "1.0";
	public static  var pubid:String = "CONFIG-PUB-ID";	
	*/
	
}