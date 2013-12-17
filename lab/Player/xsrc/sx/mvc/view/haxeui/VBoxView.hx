package sx.mvc.view.haxeui;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
/**
 * ...
 * @author Jonas Nyström
 */
class VBoxView extends VBox
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
		throw "Should be overridden";
		
		var button:Button = new Button();
		button.text = "HBoxView button - should be overridden";
		this.addChild(button);
		button.addEventListener(MouseEvent.CLICK, function(e) {
			trace('cool');
		});					
	}	
}