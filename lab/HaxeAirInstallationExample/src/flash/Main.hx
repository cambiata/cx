package flash;


import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
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
	
	public function new()
	{
		trace('Hello! This is a flash app that will try to invoke an Air application');
		trace('Start by loading the Browser Api swf from Adobe...');
		var loader = new Loader();
		var loaderContext = new LoaderContext();
		loaderContext.applicationDomain = ApplicationDomain.currentDomain;
		loader.contentLoaderInfo.addEventListener(Event.INIT, function(e:Event) {
				this.airSWF = e.target.content;
				trace('Browser Api swf successfully loaded!');
				trace('Check if Air Runtime is installed:');
				var status:String = cast( this.airSWF.getStatus(), String).toUpperCase();
				trace("Air Runtime status: " + status);	
				
				switch(status) {
					case "INSTALLED":
						//Lib.current.addChild(createButton('Check AIR application', checkVersion, 340, newButtonY()));		
						checkVersion();
					case "AVAILABLE":
						Lib.current.addChild(createButton('Get Air Runtime: ', function() {  Lib.getURL(new URLRequest(Constants.AIR_RUNTIME_DOWNLOAD_URL));  }, 340, newButtonY(), 0xFF5555));
						trace("Click the Get Air Runtime button, install it. Then refresh this browser page...");
					default:
						trace("AIR IS NOT AVAILABLE ON THIS DEVICE - SORRY!");
				}
			});		
		try {
			loader.load(new URLRequest(BROWSERAPI_URL));
		} catch (err:Error)
		{
			trace(err.message);
		}			

		//Lib.current.addChild(createButton('Get Air Runtime: ', function() {  Lib.getURL(new URLRequest(Constants.AIR_RUNTIME_DOWNLOAD_URL));  }, 340, 20, 0xFF5555));
	}
	
	private function checkVersion() 
	{
		trace('Check version for app "${Constants.APPLICATION_ID}"...');	
		if (this.airSWF == null) throw "airSWF isn't loaded";
		this.airSWF.getApplicationVersion(Constants.APPLICATION_ID, Constants.PUBLISHER_ID, function(version:String) {
			if (version == null) 
			{ 
				trace('Application "${Constants.APPLICATION_ID}" is not installed.'); 
				Lib.current.addChild(createButton('Go to AirApplication installation page ', function() { Lib.getURL(new URLRequest(Constants.AIR_APPLICATION_INSTALLATION_URL)); } , 340, newButtonY()));
				trace("Click the Go to AirApplication installation button.");
				trace("Install the application, then refresh this browser page...");
			} 
			else 
			{ 
				trace('Version $version is installed.'); 
				Lib.current.addChild(createButton('Invoke AIR application', function() { invokeApplication(null); } , 340, newButtonY(), 0x55FF55));
				Lib.current.addChild(createButton('Invoke AIR application 2', function() { invokeApplication(["One", "Two"]); } , 340, newButtonY(), 0x55FF55));				
				Lib.current.addChild(createButton('Invoke AIR application 3 - FireFox problem!', function() { invokeApplication(["Argument ONE", "Arg 2", "ARGUMENT C"]); } , 340, newButtonY(), 0x55FF55));		
			} 		
			trace("");			
		}); 
	}	
	
	
	
	private function invokeApplication(args:Array<String>) 
	{
		if (this.airSWF == null) throw "Problem: airSWF isn't loaded";
		
		trace('Trying to invoke AirApplication. Arguments:');		
		trace(args);
		//var args:Array<String> = ["ArgumentONE", "Arg2", "ARGUMENTC"]; 
		try 
		{
			this.airSWF.launchApplication( Constants.APPLICATION_ID,  Constants.PUBLISHER_ID, args);
		} catch (err:Error)
		{
			trace('Error: ${err.message}');
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------------------
	
	static public function createButton(txt: String, onClick: Void -> Void, x:Float=0, y:Float=0, color:Int=0xFFCC00): Sprite 
	{
		var textField = new TextField();
		textField.text = txt;
		textField.autoSize = TextFieldAutoSize.LEFT;

		textField.x = 2;
		textField.y = 2;		
		textField.selectable = false;

		var btn = new Sprite();
		var width = textField.width + 4;
		var height = textField.height + 4;
		
		btn.graphics.beginFill(color);
		btn.graphics.drawRoundRect(0, 0, width, height, 5);
		
		if(onClick != null) 
		{
			btn.buttonMode = true;
			btn.mouseChildren = false;
			btn.useHandCursor = true;
			btn.addEventListener(MouseEvent.CLICK, function (e: MouseEvent) { onClick(); } );
		}
		
		btn.addChild(textField);
		btn.x = x;
		btn.y = y;
		
		return btn;
	}	
	

}