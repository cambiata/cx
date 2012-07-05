package test.nme.sound;


#if neko
import cx.FileTools;
#end

import haxe.io.BytesData;
import nme.display.Loader;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.ProgressEvent;
import nme.events.SampleDataEvent;
import nme.Lib;
import nme.media.Sound;
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
	private var sound2:Sound;
	private function init(e) 
	{
		trace('init');
		sound2 = new Sound();
		sound2.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
		
//#if flash		
		var l = new URLLoader();		
		l.dataFormat = URLLoaderDataFormat.BINARY;		
		l.addEventListener(Event.COMPLETE, onComplete);
		l.addEventListener(ProgressEvent.PROGRESS, onProgress);
		l.load(new URLRequest('200.data'));
//#else if neko		
		/*
		var bytes = FileTools.getBytes('200.data');
		trace(bytes.length);
		data = ByteArray.fromBytes(bytes);
		trace(data.length);
		sound2.play();
		*/
//#end

	}
	
	private function onSampleData(e:SampleDataEvent):Void 
	{
		trace(e.position);
		for (i in 0...2048) {				
			var left:Float = data.readFloat();
			var right:Float = data.readFloat();				
			e.data.writeFloat(left);
			e.data.writeFloat(right);
		}				
	}
	
	private function onProgress(e:ProgressEvent):Void 
	{
		trace('progress ' + e.bytesLoaded + ' / ' + e.bytesTotal);
	}
	
	private function onComplete(e:Event):Void 
	{
		//trace('comlete');
		data = cast(e.target, URLLoader).data;
		trace(data.length);				
		sound2.play();
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
