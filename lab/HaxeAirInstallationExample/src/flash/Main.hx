package flash;


import cx.ConfigTools;
import cx.flash.ui.UI;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.Lib;
import flash.errors.Error;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.display.Loader;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.events.MouseEvent;
import flash.utils.Timer;
/**
 * ...
 * @author 
 */

class Main 
{	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		new Main();
	}
	
	public static var BROWSERAPI_URL = "http://airdownload.adobe.com/air/browserapi/air.swf";
	
	private var buttonY:Float = 0;
	private function newButtonY():Float 
	{		
		return buttonY += 28;
	}
	
	var airSWF:Dynamic = null;
	var btnInstall:Sprite;
	var btnLaunch:Sprite;
	var status:String;
	var textField:TextField;
	
	public function new()
	{
		ConfigTools.loadFlashVars(Config);
		trace('');
		trace(Config.APPLICATION_URL);
		//trace('-----------------------------------');
		//trace('Start by loading the Browser Api swf from Adobe...');
		var loader = new Loader();
		var loaderContext = new LoaderContext();
		loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		loader.contentLoaderInfo.addEventListener(Event.INIT, function(e:Event) {
				this.airSWF = e.target.content;
				checkStatusMain();
			});		
		try {
			loader.load(new URLRequest(BROWSERAPI_URL));
		} catch (err:Error)
		{
			trace(err.message);
		}			

		textField = UI.createText('Flash Print Install ', 100, 0);
		Lib.current.addChild(textField);		
		
		this.btnInstall = UI.createButton('Install: ', function() {  
				this.airSWF.installApplication(Config.APPLICATION_URL, Config.airversion, ['INSTALLATION-PARAMETER']);			
			}, 20, newButtonY(), 0x5555FF);	
		this.btnInstall.alpha = 0;
		Lib.current.addChild(this.btnInstall );		
		this.btnLaunch = UI.createButton('Invoke AIR application 2', function() { invokeApplication(["One", "Two"]); } , 20, newButtonY(), 0x55FF55);						
		this.btnLaunch.alpha = 0;
		Lib.current.addChild(this.btnLaunch );
		
		var timer:Timer = new Timer(2000);
		timer.addEventListener(TimerEvent.TIMER, checkStatusMain);
		timer.start();
	}

	function checkStatusMain(e:Event=null)
	{
		if (this.airSWF == null) return;
		this.status = this.airSWF.getStatus();
		if (this.status == 'installed') 
		{
			try 
			{
				this.airSWF.getApplicationVersion(Config.APPLICATION_ID, Config.PUBLISHER_ID, checkStatusAndVersion);
			}
			catch (e:Dynamic)
			{
				this.textField.text = 'ERROR version check!  $e';
			}
		}
		else
		{
			this.textField.text = 'Air SWF status: $status';
			this.btnInstall.alpha = 1;
		}
	}
	
	function checkStatusAndVersion(version:String) 
	{
		//trace([status, version]);
		var time = Date.now().toString();
		this.textField.text = 'Air Runtime status $status, Air Printer App version: $version, Current time: $time';
		if ( status == 'installed')
		{
				if (version == null)
				{
					this.btnInstall.alpha = 1;
					this.btnLaunch.alpha = 0;
				}
				else
				{
					this.btnInstall.alpha = 0;
					this.btnLaunch.alpha = 1;
				}
		}
		else
		{			
			this.btnInstall.alpha = 1;				
		}		
	}
	
	private function invokeApplication(args:Array<String>) 
	{
		if (this.airSWF == null) throw "Problem: airSWF isn't loaded";
		//trace('Trying to invoke AirApplication. Arguments:');		
		//trace(args);
		try 
		{
			this.airSWF.launchApplication( Config.APPLICATION_ID,  Config.PUBLISHER_ID, args);
		} catch (err:Error)
		{
			trace('Error: ${err.message}');
		}
	}

}