package sx.mvc.view.haxeui;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.controls.Button;
/**
 * ...
 * @author Jonas Nyström
 */
class HBoxView extends HBox
{
	public function new() 
	{		
		super();
		this.style.padding = 12;
		createChildren();		
		this.addEventListener(Event.ADDED, function(e)  { sx.mvc.app.AppView.REGISTER.dispatch(this);} );
	}
	
	private function createChildren()
	{
		var button:Button = new Button();
		button.text = "HBoxView button - should be overridden";
		this.addChild(button);
		button.addEventListener(MouseEvent.CLICK, function(e) {
			trace('cool');
		});					
	}	
}