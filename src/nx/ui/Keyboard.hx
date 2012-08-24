package nx.ui;
import nme.display.Stage;
import nme.events.KeyboardEvent;
import nx.element.Bars;

/**
 * ...
 * @author Jonas Nyström
 */

class Keyboard 
{

	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(stage:Stage, bars:Bars) {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
			trace(e.keyCode);
		});
	}
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	

	
}