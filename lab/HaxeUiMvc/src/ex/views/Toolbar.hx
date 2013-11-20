package ex.views;

import flash.events.MouseEvent;
import haxe.ui.toolkit.controls.Button;
import cx.mvc.view.haxeui.HBoxView;
import cx.mvc.view.haxeui.VBoxView;

/**
 * ...
 * @author 
 */
class ToolbarView extends HBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		
		this.btn =  new Button();
		this.btn.text = "ToolbarView button";
		this.btn.width = 150;
		this.btn.height = 40;	
		this.addChild(this.btn);	
		
		var but:Button = new Button();
		but.width = 40;
		but.percentWidth = 100;
		but.height = 40;
		this.addChild(but);
		
		var but:Button = new Button();
		but.width = 40;
		but.height = 40;
		this.addChild(but);	
		
	}
}

class ToolbarMediator extends mmvc.impl.Mediator<ToolbarView>
{
	override function onRegister() 
	 {
		trace('ToolbarMediator registered and eventlisteners setup');	
		
		this.view.btn.addEventListener(MouseEvent.CLICK, function(e) {
			trace("ToolbarView button is clicked!");
		});
		
	}	
}



/*

// The following imports should be added to Main.hx

import test.views.Toolbar.ToolbarView;
import test.views.Toolbar.ToolbarMediator;


// The following code should be added to AppContext.init()

		mediatorMap.mapView(ToolbarView, ToolbarMediator);

		
// The following code should be added to AppMediator.register()

		var viewToolbarView:ToolbarView = new ToolbarView();
		root.addChild(viewToolbarView);


*/