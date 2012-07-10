package cx.app.nme.plot;


import cx.nme.display.utils.NumberLoader;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.Lib;

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

	private function init(e) 
	{
		var nl = new NumberLoader('numbers.png');
		var y = 0;
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e:Event) {
			var d = this.addChild(nl.getNumberCache(Math.random()));
			d.y = y;
			y += 20;
		});
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;		
		Lib.current.addChild(new Main());		
	}
	
}

