package scorx.model;
import cx.ArrayTools;
import cx.TimerTools;
import cx.XmlTools;
import flash.events.BrowserInvokeEvent;
import flash.desktop.NativeApplication;
import flash.events.InvokeEvent;
import flash.utils.Namespace;
import flash.xml.XML;
import msignal.Signal.Signal1;



/**
 * ...
 * @author 
 */
class AirEvents
{
	@inject public var debug:Debug;
	
	public var update:Signal1<String>;
	
	public function new() 
	{
		this.update = new msignal.Signal.Signal1<String>();
	}
	
	public function init()
	{		
		/*
		TimerTools.delay(function() {
			NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, function(e : BrowserInvokeEvent)
			{
				debug.log('BROWSER EVENT ' + e.arguments);
				this.update.dispatch('BROWSER EVENT ' + e.arguments);
			});
			
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent)
			{			
				debug.log('NATIVE EVENT ' + e.arguments);			
				this.update.dispatch('NATIVE EVENT ' + e.arguments);
			});
		}, 500);
		*/
		
		trace(getAppVersion());
	}
	
	public function getAppVersion():String 
	{
		var appXmlStr:String = NativeApplication.nativeApplication.applicationDescriptor.toString();
		var xml:Xml = Xml.parse(appXmlStr);
		var els = ArrayTools.fromIterator(xml.firstChild().elements());
		for (el in els) {
			if (StringTools.startsWith(el.toString(), '<versionNumber'))
			{
				var vXml:Xml = Xml.parse(el.toString());
				var version:String = vXml.firstChild().firstChild().toString();
				return version;
			}
		}
		return null;
	}
	
	
}