package install;

import cx.ConfigTools;
import cx.flash.ui.UI;
import flash.display.Loader;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.Lib;
import flash.net.URLRequest;
import flash.utils.Object;
import flash.utils.Timer;
import jasononeil.CompileTime;

/**
 * ...
 * @author 
 */

class xMain 
{
	
	public static var AIR_SWF_URL:String = Config.AIR_SWF_URL;	
	
	// parameters:
	private var airVersion:String;
	private var appInstallArg:Array<String>;
	private var appLaunchArg:Array<String>;
	private var appID:String;
	private var appName:String;
	private var appURL:String;
	private var appVersion:String;
	private var helpURL:String;
	private var hideHelp:Bool;
	private var image:String;
	private var pubID:String;
	private var skipTransition:Bool;	
	
	
	var action:Action;
	var actionBtn:Sprite;
	var timer:Timer;
	var airSWFLoader:Loader;
	var airSWF:Dynamic;	
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		new Main();
	}
	
	public function new()
	{
		configUI();
		
		
		trace('InstallationBadge.swf  - ' + CompileTime.buildDateString());
		
		this.timer = new Timer(10000, 0);
		this.timer.addEventListener(TimerEvent.TIMER, handleTimer);
		
		// product manager?
		
		var params: Dynamic = ConfigTools.getFlashVars();
		this.airVersion = Validate.string(params.airversion);
		this.appInstallArg = (Validate.string(params.appinstallarg)==null) ? null : [params.appinstallarg];		
		this.appLaunchArg = (Validate.string(params.applauncharg)==null) ? null : [params.applauncharg];
		this.appID = Validate.string(params.appid);
		this.appName = Validate.string(params.appname);
		this.appURL = Validate.URL(params.appurl);
		this.appVersion = Validate.string(params.appversion);
		this.helpURL = Validate.URL(params.helpurl);
		this.hideHelp = (params.hidehelp != null && params.hidehelp.toLowerCase() == "true");
		this.image = Validate.URL(params.image);
		this.pubID = Validate.string(params.pubid);
		this.skipTransition = (params.skiptransition != null && params.skiptransition.toLowerCase() == "true");
		
		trace('airVersion', airVersion);
		trace('appInstallArg', appInstallArg);
		trace('appLaunchArg', appLaunchArg);
		trace('appID', appID);
		trace('appName', appName);
		trace('appURL', appURL);
		trace('appVersion', appVersion);
		trace('helpURL', helpURL);
		trace('hideHelp', hideHelp);
		trace('image', image);
		trace('pubID', pubID);
		trace('skipTransition', skipTransition);
		
		if ((this.appName == null || this.appURL == null || this.airVersion == null))
		{
			trace('ERROR : Not all essential parameters are set!');
		}
		
		// load the AIR proxy swf:
		
		this.airSWFLoader = new Loader();
		
		airSWFLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleAIRSWFError);
		airSWFLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleAIRSWFInit);
		try {
			airSWFLoader.load(new URLRequest(AIR_SWF_URL)); //, loaderContext);
		} catch (e:Dynamic) {
			handleAIRSWFError(null);
		}		
		
		
	}
	
	function configUI() 
	{
		this.actionBtn = UI.createButton('Action', handleActionClick, 300, 50, 0xFFFF00);
		Lib.current.addChild(this.actionBtn);
		
	}
	
	function handleActionClick() 
	{
		trace(this.action);
		switch (this.action)
		{
			case Action.CLOSE:
				// hide dialog
				// enableAction (prevAction);
				var x = 1;
			case Action.INSTALL, Action.UPGRADE, Action.TRY_AGAIN:
				//showDialog(getText("installing"),getText("installingtext"));
				//disableAction();
				trace('installApplication...');
				timer.reset();
				timer.start();
				trace([this.appURL, this.airVersion, this.appInstallArg]);
				airSWF.installApplication(this.appURL, this.airVersion, this.appInstallArg);
			case Action.LAUNCH:
				airSWF.launchApplication(this.appID, this.pubID, this.appLaunchArg);
				//showDialog(getText("launching"),getText("launchingtext"));
				enableAction(Action.CLOSE);
			
			
		}
		
	}
	
	private function handleAIRSWFInit(e:Event):Void 
	{
			trace('Air SWF loaded!');
			this.airSWF = airSWFLoader.content;
			if (airSWF.getStatus() == "unavailable") {
				//showDialog(getText("error"),getText("err_airunavailable"));
				trace('ERROR- AIR UNAVAILABLE');
				return;
			}
			var version:String = null;
			if (appID!=null && pubID!= null) {
				// check if the application is already installed:
				try {
					airSWF.getApplicationVersion(appID, pubID, appVersionCallback);
					return;
				} catch (e:Dynamic) {}
			}
			enableAction(Action.INSTALL);
			trace('Enable install A');
			
			//helpBtn.visible = !hideHelp;		
	}
	

	
	private function appVersionCallback(version:String):Void {
		if (version == null) {
			// application is not installed
			enableAction(Action.INSTALL);
			trace('Enable install');
		} else if (appVersion != null /*&& (checkVersion(appVersion,version)==1)*/) {
			// old version is installed
			enableAction(Action.UPGRADE);
			trace('Enable upgrade');
		} else {
			// current version is probably installed
			enableAction(Action.LAUNCH);
			trace('Enable launch');
		}
		//helpBtn.visible = !hideHelp;
	}	
	
	
	
	private function handleAIRSWFError(e:IOErrorEvent=null):Void 
	{
		trace('ERROR : Air SWF ERROR');
	}
	
	private function handleTimer(e:TimerEvent):Void 
	{
			try {
				this.airSWF.getApplicationVersion(this.appID, this.pubID, this.tryAgainVersionCallback);
			} catch (e:Dynamic) {
				enableAction(Action.TRY_AGAIN);
			}		
	}
	
	function tryAgainVersionCallback(version:String) 
	{
		trace('tryAgainVersionCallback ' + version);
		/*	
		if (version != null && (appVersion == null || !(checkVersion(appVersion,version)==1))) {
				// current version is probably installed
				timer.stop();
				enableAction("launch");
			} else {
				enableAction("tryagain");
			}		
		*/
	}
	
	/*
	// returns true if the first version number is greater than the second, or false if it is lesser or indeterminate:
		// works with most common versions strings: ex. 1.0.2.27 < 1.0.3.2, 1.0b3 < 1.0b5, 1.0a12 < 1.0b7, 1.0b3 < 1.0
		private function checkVersion(v1:String,v2:String):Int {
			var arr1:Array<String> = v1.replace(/^v/i,"").match(/\d+|[^\.,\d\s]+/ig);
			var arr2:Array<String> = v2.replace(/^v/i,"").match(/\d+|[^\.,\d\s]+/ig);
			var l:uint = Math.max(arr1.length,arr2.length);
			for (var i:uint=0; i<l; i++) {
				var sub:int = checkSubVersion(arr1[i],arr2[i])
				if (sub == 0) { continue; }
				return sub;
			}
			return 0;
		}	
	*/
	
		private function enableAction(action:Action) 
		{
			trace('enableAction: ' + action);
			/*
			if (action == null) {
				disableAction();
				actionFld.text = getText("loading");
				prevAction = null;
			} else {
				if (this.action != "close") { prevAction = this.action; }
				actionBtn.addEventListener(MouseEvent.CLICK,handleActionClick);
				actionBtn.enabled = true;
				actionFld.alpha = 1;
				actionFld.text = getText(action);
			}
			this.action = action;
			*/
			this.action = action;
		}	
	
	
}