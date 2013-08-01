package air;


import cx.AirAppTools;
import cx.AIRTools;
import cx.flash.ui.UIProgress;
import cx.TimerTools;
import flash.display.Bitmap;
import flash.display.BitmapData;
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
import haxe.io.Bytes;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Options;
import ru.stablex.ui.widgets.Text;
import sx.data.ImageTools;
import sx.data.PrintTools;
import sx.ScorxColors;
import Config;
import flash.text.TextField;
import flash.text.TextFormat;

import cx.flash.ui.UI;

/**
 * ...
 * @author 
 */

 //@:bitmap("assets/testpage.png") class TestPage extends BitmapData {}
@:bitmap("assets/scorx-print.png") class ScorxPrint extends flash.display.BitmapData {}
 
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
			init();
			createUI();
			showIdle();
		}, 200);
	}

	private function init()
	{
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");
	}
	
	private function createUI()
	{
		
		var logo:Bitmap = new Bitmap(new ScorxPrint(0, 0));
		logo.x = logo.y = 10;
		Lib.current.addChild(logo);

		textFormat =  new TextFormat('Arial', 28, 0xFFFFFF);					
		textField = UI.createText(Config.SCORX_PRINT_MANAGER, 10, 28, textFormat);
		Lib.current.addChild(textField);		

		var btnTestLoad:Sprite = UI.createButton("Load", this.test1, 580, 10, 0x222222, 0, 0, 10, new TextFormat('Arial', 14, 0xFFFFFF));
		Lib.current.addChild(btnTestLoad);					
		
		
		var btnTest1:Sprite = UI.createButton("Idle", this.showIdle, 310, 10, 0x222222, 0, 0, 10, new TextFormat('Arial', 14, 0xFFFFFF));
		Lib.current.addChild(btnTest1);					
		
		var btnTest2:Sprite = UI.createButton("Success", this.showSuccess, 350, 10, 0x222222, 0, 0, 10, new TextFormat('Arial', 14, 0xFFFFFF));
		Lib.current.addChild(btnTest2);		

		var btnTest3:Sprite = UI.createButton("Loading", this.showLoading, 420, 10, 0x222222, 0, 0, 10, new TextFormat('Arial', 14, 0xFFFFFF));
		Lib.current.addChild(btnTest3);				
		
		var btnTest4:Sprite = UI.createButton("Printing", this.showPrinting, 490, 10, 0x222222, 0, 0, 10, new TextFormat('Arial', 14, 0xFFFFFF));
		Lib.current.addChild(btnTest4);						
		
		//---------------------------------------------------------------------------------------------------------
		idleUI = new Sprite();
		var idleBtn = UI.createButton(Config.MANAGER_NOTHING_TO_DO, null, BTN_X, BTN_Y, ScorxColors.ScorxPetrol, 320, 0, 20, new TextFormat('Arial', 20, 0xffffff), false);
		idleUI.addChild(idleBtn);
		
		
		//---------------------------------------------------------------------------------------------------------
		
		successUI = new Sprite();
		var successBtn = UI.createButton(Config.MANAGER_INSTALLATION_SUCCESS, null, BTN_X, BTN_Y, ScorxColors.ScorxYellow, 320, 0, 20, new TextFormat('Arial', 20, 0x000000), false);
		successUI.addChild(successBtn);
		
		//--------------------------------------------------------------------------------------------------------

		loadingUI = new Sprite();
		progress = new UIProgress(360, 60, 150, 150, 0x222222, ScorxColors.ScorxPetrol);
		progress.spin();
		loadingUI.addChild(progress);		
		
		this.progressPages = new UIProgress(370, 70, 130, 130, 0x222222, ScorxColors.ScorxGreen);
		progressPages.value = 0;
		progressPages.spinStop();
		loadingUI.addChild(progressPages);
		

		var loadingText:TextField = UI.createText(Config.MANGER_LOADING, 20, 100, new TextFormat('Arial', 20, 0xcccccc));
		loadingUI.addChild(loadingText);
		//Lib.current.addChild(loadingUI);
		
		//--------------------------------------------------------------------------------------------------------

		
		
		printingUI = new Sprite();
		//Lib.current.addChild(printingUI);
		
		
		
		/*
		var sxBtn:Button = UIBuilder.create(Button);
		sxBtn.text = "Hello";
		sxBtn.x = 200;
		sxBtn.y = 200;
		printingUI.addChild(sxBtn);
		*/
		
		printerOptions = [];
		var index = 1;
		
		availablePrinters = AirAppTools.getFilteredPrinters().passed;
		
		for (printer in availablePrinters )
		{
			printerOptions.push([printer, index]);
			index++;			
		}

		var optText:TextField = UI.createText(Config.MANAGER_SELECT_PRINTER, 20, 94, new TextFormat('Arial', 14, 0xcccccc));
		printingUI.addChild(optText);
		
		optPrinters = UIBuilder.create(Options);
		optPrinters.options = printerOptions; // [['lion', 1], ['camel', 2], ['elephant', 3]];
		optPrinters.x = 20;
		optPrinters.y = 120;
		printingUI.addChild(optPrinters);
		
		printBtn = UI.createButton(Config.MANAGER_START_PRINTING, 	onPrint
		, 360, 60, ScorxColors.ScorxGreen, 150, 150, textFormat, true);
		printingUI.addChild(printBtn);

	}
	

		
	
	static var BTN_X = 40;
	static var BTN_Y = 80;
	var progress:UIProgress;
	var printingUI:Sprite;
	var printBtn:Sprite;
	var loadingUI:Sprite;
	var idleUI:Sprite;
	var successUI:Sprite;
	
	public function invokeArguments(args:Array<Dynamic>)
	{		
		
		userId = 0;
		productId = 0;
		
		if (btn != null) Lib.current.removeChild(btn);
		TimerTools.delay(function() {
			
			btn = null;
			switch(args[0]) 
			{
				case Config.INVOKER_MESSAGE_PRINTJOB :
					try
					{
						this.userId = Std.parseInt(args[1]);
						this.productId = Std.parseInt(args[2]);			
						this.textField.text += " [" + this.userId + ":" +this.productId + "]";

						TimerTools.delay(function() {
							this.showLoading();
							this.invokePrintJob(this.productId, this.userId, null);							
						}, 500);
						
					}
					catch (err:Dynamic)
					{
						trace( "Can't find  userId and/or productId " + args);
						showIdle();
					}						
					
				case AIRTools.APP_INSTALLATION_SUCCESS:
					//trace('INSTALLATION DONE!');
					

					/*
					btn = UI.createButton(Config.MANAGER_INSTALLATION_SUCCESS, null, BTN_X, BTN_Y, ScorxColors.ScorxYellow, 150, 150, textFormat, true);
					Lib.current.addChild(btn);
					*/
					showSuccess();
					TimerTools.delay(function()
					{
						NativeApplication.nativeApplication.exit();							
					}, 3000);

				default:
					//trace('???');
					/*
					try  Lib.current.removeChild(printingUI) catch (err:Dynamic)  {}
					
					this.textField.text = Config.SCORX_PRINT_MANAGER;
					btn = UI.createButton(Config.MANAGER_NOTHING_TO_DO, null, BTN_X, BTN_Y, ScorxColors.ScorxRed, 150, 150, textFormat, true);					
					Lib.current.addChild(btn);
					*/
			}
			
			
			
		}, 200);
	}
		
	//---------------------------------------------------------------------
	
	function test1() 
	{
		//trace('test1');
		var args = [Config.INVOKER_MESSAGE_PRINTJOB, "1", "1"];
		this.invokeArguments(args);		
		//this.progress.hide();
	}

	function showIdle() 
	{
		Lib.current.addChild(idleUI);
		try  Lib.current.removeChild(successUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(loadingUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(printingUI) catch (err:Dynamic)  { }
	}		
	
	function showPrinting() 
	{
		try  Lib.current.removeChild(idleUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(successUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(loadingUI) catch (err:Dynamic)  { }
		Lib.current.addChild(printingUI);		
	}	
	
	function showLoading() 
	{
		try  Lib.current.removeChild(idleUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(successUI) catch (err:Dynamic)  { }
		Lib.current.addChild(loadingUI);
		try  Lib.current.removeChild(printingUI) catch (err:Dynamic)  { }
	}		
	
	function showSuccess() 
	{
		try  Lib.current.removeChild(idleUI) catch (err:Dynamic)  { }
		Lib.current.addChild(successUI);
		try  Lib.current.removeChild(loadingUI) catch (err:Dynamic)  { }
		try  Lib.current.removeChild(printingUI) catch (err:Dynamic)  { }

	}			
		
	//---------------------------------------------------------------------------------------------------------------------------------------
	
	var printBitmaps:Array<Bitmap> = null;
	var optPrinters:Options;
	var availablePrinters:Array<String>;
	var printerOptions:Array<Array<Dynamic>>;
	var progressPages:UIProgress;
	
	private function invokePrintJob(productId:Int = 0, userId:Int = 0, url:String)
	{	
		var printTools = new PrintTools(); 
		
		printTools .onComplete = function(bitmaps:Array<Bitmap>) 
		{
			this.showPrinting();
			this.printBitmaps = bitmaps;
		}
		
		printTools.onProgress = function(loaded, total, bitmap:Bitmap=null)
		{
			//trace([loaded, total]);
			this.progressPages.value = loaded / total;
			//trace([bitmap, loaded]);
			if (bitmap != null)
			{
				bitmap.width = 105 * 0.7;
				bitmap.height = 148 * 0.7;
				bitmap.y = 250;
				bitmap.x =(loaded-2) * 84 + 10;
				Lib.current.addChild(bitmap );
			}
		}
		
		printTools.onError = function(msg)
		{
			trace(msg);
		}
		
		printTools.onStartLoading = function()
		{
			//trace('starting...');
		}
		
		printTools.loadPages(productId, userId, Config.SERVER_HOST);		
		
		
	}
	
	private function onPrint() 
	{			
		var currentPrinter = this.availablePrinters[Std.int(optPrinters.value-1)];
		if (this.printBitmaps == []) trace (Config.MANAGER_NOTHING_TO_DO);
		AirAppTools.testPrint(currentPrinter, this.printBitmaps[0].bitmapData);
	}
	
	
}