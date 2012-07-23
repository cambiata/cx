package neko;

import cx.FileTools;
import neko.Lib;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import nme.display.Sprite;
import nme.display.Stage;
import nme.events.Event;
import nme.events.SampleDataEvent;
import nme.media.Sound;
import nme.utils.ByteArray;


/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite
{
	static private var ba:ByteArray;
	static private var stage:Stage;
	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}	
	
	private function init(e) 
	{
		/*
		ba = new ByteArray();
		var bytes = FileTools.getBytes('200.data');
		trace(bytes.length);
		ba.writeBytes(bytes);
		trace(ba.length);
		
		var p = new Sound();
		p.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
		p.play();
		*/
		
	}
	
	static function main() 
	{
		
		var stage = nme.Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;		
		nme.Lib.current.addChild(new Main());			
	}
	
	static private function onSampleData(e:SampleDataEvent):Void 
	{
			trace(e.position);
			//for (var i:int = 0; i < 2048; i++) 
			for(i in 0...2048)
			{
				var left = ba.readFloat();
				var right = ba.readFloat();				
				e.data.writeFloat(left * 0.2);
				e.data.writeFloat(right * 0.2);
				//e.data.writeFloat(0);
				//e.data.writeFloat(0);
			}		
	}
	
}