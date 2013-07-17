package cx;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.TimerEvent;
import flash.system.LoaderContext;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.utils.Timer;



/**
 * ...
 * @author 
 */
class AIRTools
{
	var airAppUrl:String;
	var minAirVersion:String;
	var airAppId:String;
	var publisherId:String;
	var airSWF:Dynamic;
	
	var status:String;	
	var version:String;
	var prevStatus:String;
	var prevVersion:String;	
	
	
	var timer:Timer;
	
	static public var AIR_INSTALLED = 'installed';
	static public var AIR_AVAILABLE = 'available';
	static public var AIR_UNAVAILABLE = 'unavailable';	
	public static var BROWSERAPI_URL = "http://airdownload.adobe.com/air/browserapi/air.swf";
	public static var APP_INSTALLATION_SUCCESS = 'INSTALLATIONSUCCESS';
	
	public static var PRINTJOB = 'printjob';
	
	
	public var statusCallback: String -> String -> Void = null;
	
	public function new(airAppId:String, publisherId:String, airAppUrl:String, minAirVersion:String) 
	{
		this.airAppUrl = airAppUrl;
		this.minAirVersion = minAirVersion;
		this.airAppId = airAppId;
		this.publisherId = publisherId;
		
		loadAirSwf();
		
		timer = new Timer(2000);		
		timer.addEventListener(TimerEvent.TIMER, checkStatusMain);		
		timer.start();
	}
	
	function loadAirSwf() 
	{
		var loader = new Loader();
		var loaderContext = new LoaderContext();
		loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		loader.contentLoaderInfo.addEventListener(Event.INIT, function(e:Event) {
				this.airSWF = e.target.content;
				checkStatusMain();
			});		
		loader .contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent) {
			errorMsg(e.text);
		});
			
		try 
		{
			loader.load(new URLRequest(BROWSERAPI_URL));
		} 
		catch (err:Dynamic)
		{
			errorMsg(err);
		}				
	}
	
	//---------------------------------------------------------------------------------------------------------------------------
	
	var waitCounter:Int = 0;
	
	function checkStatusMain(e:Event=null)
	{
		
		
		//trace('check');
		if (this.airSWF == null) return;
		this.status = this.airSWF.getStatus();		
		//trace(this.status);
		if (this.status == AIRTools.AIR_INSTALLED) 
		{
			try 
			{
				this.airSWF.getApplicationVersion(this.airAppId, this.publisherId, function (version:String) {
					//trace(version);
					this.version = version;
				});
			}
			catch (e:Dynamic)
			{
				errorMsg( 'ERROR version check!  $e');
			}
		}
		statusMsg('Air SWF status: $status');
		
		
		
		waitCounter++;
		if (waitCounter < 2) return;

		statusCB();	
	}
	
	
	public function invokeApplication(args:Array<String>) 
	{
		if (this.airSWF == null) errorMsg( "Problem: airSWF isn't loaded");
		try 
		{
			this.airSWF.launchApplication( this.airAppId,  this.publisherId, args);
		} 
		catch (err:Error)
		{
			errorMsg('Error: ${err.message}');
		}
	}
	
	public function installApplication(parameters:Array<String>=null)
	{
		parameters = [APP_INSTALLATION_SUCCESS];		
		this.airSWF.installApplication(this.airAppUrl, this.minAirVersion, parameters);					
	}
	
	private function errorMsg(msg:String)
	{
		trace('ERROR ' + msg);
		
	}
	
	private function statusMsg(msg:String)
	{
		//trace('STATUS ' + msg);
	}
	
	
	
	
	private function statusCB()
	{
		//trace([this.status, this.version]);
		

		if (this.statusCallback != null) {
			if (this.status != this.prevStatus || this.version != this.prevVersion)
			{
				//trace('CALL');
				this.statusCallback(this.status, this.version);
			}
		}
		this.prevStatus = this.status;
		this.prevVersion = this.version;
	}
	
	//----------------------------------------------------------------------------------------------------------------------------------

	
}