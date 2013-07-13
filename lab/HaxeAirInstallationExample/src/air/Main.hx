package air;

import flash.Lib;
import flash.filesystem.File;
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.InvokeEvent;
import flash.events.BrowserInvokeEvent;

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
		
		trace('Hello World from "${Constants.APPLICATION_ID}"!');
		trace('I will hopefully be invoked from a flash app embedded on a web page somewhere.');
		trace('Ciao!');
		trace("");
		
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, function(e : BrowserInvokeEvent)
		{
			var now:String = Date.now().toString();
			trace("");
			trace("BrowserInvokeEvent  received: " + now); 
			trace("Arguments: " + e.arguments);
			trace("isHTTPS: " + e.isHTTPS);
			trace("isUserEvent: " + e.isUserEvent);
			trace("Sandbox type: " + e.sandboxType);
			trace("Security domain: " + e.securityDomain);				
		});
		
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent)
		{
			var now:String = Date.now().toString();
			trace("");
			trace("Invoke event received: " + now); 			
			trace("Arguments: " + e.arguments); 
		});		
	}
}