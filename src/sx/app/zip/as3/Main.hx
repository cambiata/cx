package sx.app.zip.as3;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import sx.util.ScorxZip;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		var filename = '00000209.alaha-ruha.nyberg.PEACE.sqlite.zip';
		var sz2 = new ScorxZip( filename);
		sz2.addEventListener(Event.COMPLETE, function (e:Event) {
			trace('on loaded');
			trace(sz2.getExample());
		});
	}

}