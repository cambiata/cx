package flash;


import cx.AIRTools;
import cx.ConfigTools;
import cx.flash.ui.UI;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.external.ExternalInterface;
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
import flash.text.TextFormat;
import flash.utils.Timer;
import sx.ScorxColors;
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
	
	//public static var BROWSERAPI_URL = "http://airdownload.adobe.com/air/browserapi/air.swf";
	
	private var buttonY:Float = 0;
	private function newButtonY():Float 
	{		
		return buttonY += 28;
	}
	
	var airSWF:Dynamic = null;
	
	var btnLaunch:Sprite;
	var btnInstall:Sprite;
	var btnNotAvaliable:Sprite;
	
	var status:String;
	var textField:TextField;
	var textFieldBig:TextField;
	var textFieldErrors:TextField;
	var timer:Timer;
	var airTools:AIRTools;
	
	public function new()
	{
		
		textFormat =  new TextFormat('Arial', 30, 0x333333);		
		createUI();
		this.initVars();
		this.airTools = new AIRTools(Config.APPLICATION_ID, Config.PUBLISHER_ID, Config.APPLICATION_URL, Config.airversion);		
		this.airTools.statusCallback = this.airStatusChange;

		/*
		this.callExternal();
		this.createUI();
		this.loadAirSwf();
		this.kickoff();		
		*/		
	}
	private function initVars()
	{
		ConfigTools.loadFlashVars(Config);
		this.textField.text = Config.APPLICATION_URL.substr(16) + ' userId:' + Config.userId + ' productId:' + Config.productId;
	}
	
	private function callExternal()
	{
		try 
		{
			ExternalInterface.call('calledFromFlashPlayer', "Hello from Flash Player!");			
		}
		catch (err:Error)
		{
			trace('Couldnt call external interface');
		}
	}

	//var installCheck = false;

	var btn:Sprite = null;
	var textFormat:TextFormat;
	
	function airStatusChange(status:String=null, version:String=null) 
	{
		//trace([status, version]);			
		switch(status)
		{
			case AIRTools.AIR_INSTALLED:
				if (version == null)
				{
					//if (installCheck == true)
					//{

					//}
					//installCheck = true;
					textFieldBig.text = "";
					if (this.btn != null) Lib.current.removeChild(btn);
					this.btn = UI.createButton('Install ScorxPrint', function() {  
							this.airTools.installApplication([AIRTools.APP_INSTALLATION_SUCCESS]);
						}, 10, 10, ScorxColors.ScorxYellow, 300, 50, 20, textFormat, false);	
					Lib.current.addChild(this.btn );							
					
				}
				else
				{

					//this.airTools.invokeApplication([AIRTools.PRINTJOB, Std.string(Config.userId), Std.string(Config.productId)]);
					textFieldBig.text = "";
					if (this.btn != null) Lib.current.removeChild(btn);
					this.btn = UI.createButton('Start ScorxPrint', function() { 
						this.airTools.invokeApplication([AIRTools.PRINTJOB, Std.string(Config.userId), Std.string(Config.productId)]);
						} , 10, 10, ScorxColors.ScorxGreen, 300, 50, 20, textFormat, false);								
					Lib.current.addChild(this.btn );					
					
					
				}
				//btnNotAvaliable.alpha = 0.2;
			case AIRTools.AIR_AVAILABLE:			
				
				textFieldBig.text = "";
				if (this.btn != null) Lib.current.removeChild(btn);
				this.btn = UI.createButton('Install ScorxPrint', function() {  
						this.airTools.installApplication([AIRTools.APP_INSTALLATION_SUCCESS]);
					}, 10, 10, ScorxColors.ScorxYellow, 300, 50, 20, textFormat, false);	
				Lib.current.addChild(this.btn );					
				
			case AIRTools.AIR_UNAVAILABLE:

				textFieldBig.text = "Sorry! ScorxPrint not available for this device.";
				/*
				if (this.btn != null) Lib.current.removeChild(btn);		
				this.btn = UI.createButton('Not avalilable', function() { 
					this.airTools.invokeApplication([Std.string(Config.userId), Std.string(Config.productId)]);
					} , 210, 10, ScorxColors.ScorxRed, 250, 50, 20, textFormat, false);								
				Lib.current.addChild(this.btn );						
				*/
				
			default:
				throw "This shouldn't happen";
		}
		this.externalStatusMessage(status, version);
	}	
	
	private function externalStatusMessage(status:String, version:String)
	{
		try 
		{
			ExternalInterface.call('invokePrintingMessage', status, version);			
		}
		catch (err:Error)
		{
			this.textFieldErrors.text ='Error: Could not call external interface';
		}				
	}

	/*
	private function loadAirSwf()
	{
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
	}
	*/	
	private function createUI()
	{
			
		textFieldBig = UI.createText('Kontrollerar ScorxPrint installation...', 10, 12,  new TextFormat('Arial', 18, 0xEEEEEE));
		Lib.current.addChild(textFieldBig);				
		
		textField = UI.createText('Flash Print Install ', 10, 70);
		textField.defaultTextFormat = new TextFormat('Arial', 12, 0x666666);
		Lib.current.addChild(textField);		

		textFieldErrors = UI.createText('', 10, 90);
		textFieldErrors.defaultTextFormat = new TextFormat('Arial', 12, 0xff6666);
		Lib.current.addChild(textFieldErrors);				
		
		/*
		var textFormat =  new TextFormat('Arial', 30, 0x555555);		
		this.btnLaunch = UI.createButton('Starta!', function() { 
			this.airTools.invokeApplication([AIRTools.PRINTJOB, Std.string(Config.userId), Std.string(Config.productId)]);
			} , 100, 30, ScorxColors.ScorxGreen, 150, 150, 20, textFormat, false);								
		this.btnLaunch.alpha = 0.2;
		Lib.current.addChild(this.btnLaunch );
		
		this.btnInstall = UI.createButton('Install ', function() {  
				this.airTools.installApplication([AIRTools.APP_INSTALLATION_SUCCESS]);
			}, 300, 30, ScorxColors.ScorxYellow, 150, 150, 20, textFormat, false);	
		this.btnInstall.alpha = 0.2;
		Lib.current.addChild(this.btnInstall );		

		this.btnNotAvaliable = UI.createButton('Not avalilable', function() { 
			this.airTools.invokeApplication([Std.string(Config.userId), Std.string(Config.productId)]);
			} , 500, 30, ScorxColors.ScorxRed, 150, 150, 20, textFormat, false);								
		this.btnNotAvaliable.alpha =0.2;
		Lib.current.addChild(this.btnNotAvaliable );	
		*/
	}
	
	/*
	private function kickoff()
	{
		timer.start();		
	}
	

	function checkStatusMain(e:Event=null)
	{
		if (this.airSWF == null) return;
		this.status = this.airSWF.getStatus();		
		if (this.status == AIRTools.AIR_INSTALLED) 
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
			if (this.status == AIRTools.AIR_AVAILABLE)
			{
				this.btnInstall.alpha = 1;				
				
			} 
			else if (this.status == AIRTools.AIR_UNAVAILABLE)
			{
				this.btnNotAvaliable.alpha = 1;
			}
			
		}
	}
	
	function checkStatusAndVersion(version:String) 
	{
		//trace([status, version]);
		var time = Date.now().toString();
		this.textField.text += ' - AirPrinterApp v: $version';
		if ( status == AIRTools.AIR_INSTALLED)
		{
				if (version == null)
				{
					this.btnInstall.alpha = 1;
					this.btnLaunch.alpha = 0.2;
				}
				else
				{
					this.btnInstall.alpha = 0.2;
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
	*/
}