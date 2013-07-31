package scorx.media.main.test;

import cx.ConfigTools;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import scorx.setup.InitApp;
import scorx.setup.UITest;
import sx.data.ScoreLoader;


/**
 * ...
 * @author 
 */

class Main 
{

	public function new() 
	{
		new InitApp();
		Lib.current.addChild(new UITest());
		

		
	}
	
	public static function main() 
	{
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		new Main();
	}
	
	
}
