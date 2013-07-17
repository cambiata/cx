package cx;



import flash.desktop.NativeApplication;
import flash.events.InvokeEvent;
import flash.events.BrowserInvokeEvent;




/**
 * ...
 * @author 
 */
class AIRAppTools
{

	

	static public function AIR_appBrowserInvoke(browserInvokeCallback:BrowserInvokeEvent->Void)
	{
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, browserInvokeCallback);				
	}

	
	

}