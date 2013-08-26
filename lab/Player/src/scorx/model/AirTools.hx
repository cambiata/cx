package scorx.model;
import cx.AIRTools;
import msignal.Signal.Signal1;

/**
 * ...
 * @author 
 */
class AirTools
{
	var airTools:AIRTools;
	
	public var update:Signal1<AIRStatus>;
	
	public function new()
	{
		this.update = new Signal1<AIRStatus>();		
	}
	
	@inject public var debug:Debug;
	public function init() 
	{
		airTools = new AIRTools(Config.MANAGER_APPLICATION_ID, Config.MANAGER_PUBLISHER_ID, Config.MANAGER_APPLICATION_URL, Config.MANAGER_APPLICATION_VERSION);				
		airTools.statusCallback = this.airStatusChange;
		airTools.errorCallback = this.airErrorChange;				
	}
	
	/*
	function airStatusChange(status:String=null, version:String=null) 
	{
		debug.log('STATUS: ' + status);
		debug.log('VERSION: ' + version);		
		this.update.dispatch(status);		
	}
	*/
	
	function airStatusChange(status:AIRStatus)
	{
		//debug.log('STATUS: ' + status);		
		this.update.dispatch(status);
		
		switch(status)
		{
			case AIRStatus.installApp(newVersion):
				trace('Install Print Manager');
			case AIRStatus.updateApp(installedVersion, newVersion):
				trace ('update');
				//this.airTools.installApplication([AIRTools.APP_INSTALLATION_NEW_VERISON]);
			case AIRStatus.available:
				trace('Install Adobe AIR and Print Manager');
				//this.airTools.installApplication([AIRTools.APP_INSTALLATION_SUCCESS]);	
			case AIRStatus.unavailable:
				trace('Unavailable');
			case AIRStatus.installed:
				trace('Installed - everything OK');
		}
		
	}
	
	function airErrorChange(msg:String) 
	{
		Debug.log(msg);
	}	
	
	public function installAirRuntime()
	{
		this.airTools.installAirRuntime();	
	}
	
	public function installApplication()
	{
		this.airTools.installApplication();	
	}
	
	public function invokeApplication(args:Array<String>) 
	{
		this.airTools.invokeApplication(args);
	}
	
}