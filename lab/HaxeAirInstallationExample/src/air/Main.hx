package air;

import cx.AIRAppTools;
import cx.AIRTools;
import cx.TimerTools;
import flash.geom.Point;
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
import sx.ScorxColors;

import flash.text.TextField;
import flash.text.TextFormat;

import cx.flash.ui.UI;

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
		var main:Main =  new Main();
		
		TimerTools.delay(function() {
			NativeApplication.nativeApplication.activeWindow.maxSize = new Point(800, 600);
			NativeApplication.nativeApplication.activeWindow.alwaysInFront = true;
		
		}, 500);
		
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, function(e : BrowserInvokeEvent)
		{
			
			var now:String = Date.now().toString();
			/*
			trace("");
			trace("BrowserInvokeEvent  received: " + now); 
			trace("Arguments: " + e.arguments);
			trace("isHTTPS: " + e.isHTTPS);
			trace("isUserEvent: " + e.isUserEvent);
			trace("Sandbox type: " + e.sandboxType);
			trace("Security domain: " + e.securityDomain);	
			*/
			if (main != null)
			main.invokeArguments(e.arguments);
			
		});				
		
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent)
		{			
			var now:String = Date.now().toString();
			//trace("");
			//trace("Invoke event received: " + now); 			
			//trace("Arguments: " + e.arguments); 
			//
			if (main != null)
			main.invokeArguments(e.arguments);
		});				

	}
	
	var textField:TextField;	
	var btnLaunch:Sprite;
	var textFormat:TextFormat;
	var btn:Sprite;
	var userId:Int;
	var productId:Int;
	
	public function new()
	{
		TimerTools.delay(function() {
			createUI();
			init();
		}, 200);
	}

	private function init()
	{


		

		
	}
	
		private function createUI()
		{
			textFormat =  new TextFormat('Arial', 30, 0x555555);					
			textField = UI.createText('Scorx AIR Print application', 10, 10, textFormat);
			//textField.defaultTextFormat = textFormat;
			Lib.current.addChild(textField);		

			
			/*
			var textFormat =  new TextFormat('Arial', 30, 0x555555);		
			this.btnLaunch = UI.createButton('Start', function() { 
				//this.airTools.invokeApplication([Std.string(Config.userId), Std.string(Config.productId)]);
				//trace('Hello');
				} , 100, 100, ScorxColors.ScorxGreen, 150, 150, 20, textFormat, true);								
			this.btnLaunch.alpha = 0.2;
			Lib.current.addChild(this.btnLaunch );			
			*/
			
		}
	
		public function invokeArguments(args:Array<Dynamic>)
		{		
			
			userId = 0;
			productId = 0;
			
			if (btn != null) Lib.current.removeChild(btn);
			TimerTools.delay(function() {
				
				
				
				btn = null;
				switch(args[0]) 
				{
					case AIRTools.PRINTJOB :
						//trace('SUCCESS');
						btn = UI.createButton('Print!', null, 100, 100, ScorxColors.ScorxGreen, 150, 150, textFormat, true);
						try
						{
							this.userId = Std.parseInt(args[1]);
							this.productId = Std.parseInt(args[2]);							
							this.textField.text += " " + this.userId + ":" +this.productId;
						}
						catch (err:Dynamic)
						{
							trace( "Can't find  userId and/or productId " + args);
						}						
						
					case AIRTools.APP_INSTALLATION_SUCCESS:
						//trace('INSTALLATION DONE!');
						btn = UI.createButton('Installation success!', null, 100, 100, ScorxColors.ScorxYellow, 150, 150, textFormat, true);
						

					default:
						//trace('???');
						btn = UI.createButton('No printjob', null, 100, 100, ScorxColors.ScorxRed, 150, 150, textFormat, true);					
				}
				Lib.current.addChild(btn);
			}, 200);
		}
		
}