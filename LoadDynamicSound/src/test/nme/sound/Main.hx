package test.nme.sound;

import nme.display.Loader;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.net.URLLoader;
import nme.net.URLLoaderDataFormat;
import nme.net.URLRequest;
import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite 
{

	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	
	private var data:ByteArray;	
	private function init(e) 
	{
		trace('init');
		var l = new URLLoader();		
		l.dataFormat = URLLoaderDataFormat.BINARY;		
		l.load(new URLRequest('200.data'));
		l.addEventListener(Event.COMPLETE, onComplete);
	}
	
	private function onComplete(e:Event):Void 
	{
		trace('comlete');
		data = cast(e.target, URLLoader).data;
		trace(data.length);				
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
