package nx3.xamples.main.live;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author 
 */

class Nx3LiveDevelop extends Sprite
{
	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		
		//write your code here
		
		var xampleSprite = Examples.basic1();
		Lib.current.addChild(xampleSprite);		
		
	}
	
	private function onRemoved(e:Event):Void 
	{			
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		removeChildren();
		
		//don't forget to remove event listeners, 
		//that you added manually to onAdded function or elsewhere
		//for proper garbage collection
	}
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.addChild(new Nx3LiveDevelop());
	}
	
}