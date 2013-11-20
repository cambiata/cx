package test.views;

import flash.events.MouseEvent;
import haxe.ui.toolkit.controls.Button;
import cx.mvc.view.haxeui.HBoxView;
import cx.mvc.view.haxeui.VBoxView;

/**
 * ...
 * @author 
 */
class Sub2View extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		
		this.btn =  new Button();
		this.btn.text = "Sub2View button";
		this.btn.width = 150;
		this.btn.height = 50;	
		this.addChild(this.btn);		
	}
}

class Sub2Mediator extends mmvc.impl.Mediator<Sub2View>
{
	override function onRegister() 
	 {
		trace('Sub2Mediator registered and eventlisteners setup');	
		
		this.view.btn.addEventListener(MouseEvent.CLICK, function(e) {
			trace("Sub2View button is clicked!");
		});
		
	}	
}


/*

// The following imports should be added to Main.hx

import test.views.Sub2.Sub2View;
import test.views.Sub2.Sub2Mediator;


// The following code should be added to AppContext.init()

		mediatorMap.mapView(Sub2View, Sub2Mediator);

		
// The following code should be added to AppMediator.register(), inside Toolkit.openFullscreen block

			var viewSub2View:Sub2View = new Sub2View();
			root.addChild(viewSub2View);


*/