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

 
 enum AIRStatus 
 {
	installed;
	available;
	unavailable;
	updateApp(installedVersion:String, newVersion:String);
	installApp(newVersion:String);
 }
 
 
class AIRTools
{
	var airAppUrl:String;
	
	var currentAppVersion:String;
	var installedAppVersion:String;
	
	
	
	var airAppId:String;
	var publisherId:String;
	var airSWF:Dynamic;
	
	var status:String;	
	//var version:String;
	var prevStatus:String;
	var prevAppVersion:String;	
	
	
	var timer:Timer;
	
	static public var STATUS_INSTALLED = 'installed';
	static public var STATUS_AVAILABLE = 'available';
	static public var STATUS_UNAVAILABLE = 'unavailable';	
	static public var STATUS_UPDATE = 'update';
	static public var STATUS_INSTALL_APP = 'installapp';
	
	//public static var AIR_SWF_URL:String = "http://airdownload.adobe.com/air/browserapi/air.swf";	
	public static var BROWSERAPI_URL = "http://airdownload.adobe.com/air/browserapi/air.swf";
	public static var APP_INSTALLATION_SUCCESS:String = "APPINSTALLATIONSUCCESS";
	static public var AIR_INSTALLATION_SUCCESS:String = "AIRINSTALLATIONSUCCESS";
	static public var APP_INSTALLATION_NEW_VERISON:String = "APPINSTALLATIONNEWVERISON";

	static public inline var CHECK_INTERVAL:Int= 3000;
	
	//public var statusCallback: String -> String -> Void = null;
	public var statusCallback: AIRStatus -> Void = null;
	public var errorCallback:String->Void = null;
	
	public function new(airAppId:String, publisherId:String, airAppUrl:String, currentAppVersion:String) 
	{
		this.airAppUrl = airAppUrl;
		this.currentAppVersion = currentAppVersion;
		this.airAppId = airAppId;
		this.publisherId = publisherId;
		
		loadAirSwf();
		
		timer = new Timer(CHECK_INTERVAL);		
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
		if (this.status == AIRTools.STATUS_INSTALLED) 
		{
			try 
			{
				this.airSWF.getApplicationVersion(this.airAppId, this.publisherId, function (installedAppVersion:String) {
					this.installedAppVersion = installedAppVersion;
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
		this.airSWF.installApplication(this.airAppUrl, this.currentAppVersion, parameters);					
	}
	
	public function installAirRuntime(parameters:Array<String> = null)
	{
		parameters = [AIR_INSTALLATION_SUCCESS];	
		this.airSWF.installApplication(this.airAppUrl, this.currentAppVersion, parameters);			
	}
	
	
	private function errorMsg(msg:String)
	{
		//trace('ERROR ' + msg);
		if (this.errorCallback != null) 
		{
			this.errorCallback(msg);
		}
	}
	
	private function statusMsg(msg:String)
	{
		//trace('STATUS ' + msg);
	}
	
	
	
	
	private function statusCB()
	{
		
		var currentStatus:AIRStatus = EnumTools.createFromString(AIRStatus, this.status);
		
		if (this.status == STATUS_INSTALLED)
		{
			if (this.installedAppVersion == null)
			{
				//trace('Application  is not installed');
				this.status = STATUS_INSTALL_APP;
				currentStatus = AIRStatus.installApp(this.currentAppVersion);
			}
			else if (this.installedAppVersion < this.currentAppVersion)
			{
				//trace('Time to update to version $currentAppVersion!');
				this.status = STATUS_UPDATE;
				currentStatus = AIRStatus.updateApp(this.installedAppVersion, this.currentAppVersion);
			}
			else if (this.installedAppVersion == this.currentAppVersion)
			{
				//trace('Latest version installed');
			}
		}
		
		//trace([this.status, this.installedAppVersion, currentStatus]);
		
		
		
		if (this.statusCallback != null) {
			if (this.status != this.prevStatus || this.installedAppVersion != this.prevAppVersion)
			{
				//trace('CALL');
				//this.statusCallback(this.status, this.installedAppVersion);
				this.statusCallback(currentStatus);
			}
		}
		this.prevStatus = this.status;
		this.prevAppVersion = this.installedAppVersion;
	}
	
	//----------------------------------------------------------------------------------------------------------------------------------

	
}