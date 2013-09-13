package ;

import cx.ByteArrayTools;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

/**
 * ...
 * @author 
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		/*
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
		urlLoader.addEventListener(Event.COMPLETE, function(e:Event = null) 
		{
			trace('complete');
			trace(e.target.data);
			var byteArray:ByteArray = cast e.target.data;
			//var byteArray:ByteArray = ByteArrayTools.fromBytes(e.target.data);
			trace(byteArray.length);
			//var loader:Loader = new Loader();
			//loader.loadBytes(byteArray);
		});
		//urlLoader.load(new URLRequest('http://localhost:2000/media/screen/1/0'));
		*/
		
		var bitmapData:BitmapData = new BitmapData(0, 0);
		var contentLoaderInfo:LoaderInfo = LoaderInfo.create(null);
		contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event = null) {
			trace('complete');
			trace(bitmapData.width);
		});
		//contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoad, false, 2147483647);
		bitmapData.nmeLoadFromFile('http://localhost:2000/media/screen/1/0', contentLoaderInfo);	
		trace(bitmapData.width);
	
		
		/*
		var loader:Loader = new Loader();
		loader.load(new URLRequest('http://localhost:2000/media/screen/1/0?ext=.png'));
		this.addChild(loader);
		*/
		

		
		
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
