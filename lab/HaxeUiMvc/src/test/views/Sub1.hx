package test.views;

import flash.events.MouseEvent;
import haxe.ui.toolkit.controls.Button;
import cx.mvc.view.haxeui.HBoxView;
import cx.mvc.view.haxeui.VBoxView;

/**
 * ...
 * @author 
 */
class Sub1View extends VBoxView 
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		
		this.btn =  new Button();
		this.btn.text = "Sub1View button";
		this.btn.width = 150;
		this.btn.height = 50;	
		this.addChild(this.btn);
		
	}
}

class Sub1Mediator extends mmvc.impl.Mediator<Sub1View>
{
	override function onRegister() 
	 {
		trace('Sub1Mediator registered and eventlisteners setup');	
		
		this.view.btn.addEventListener(MouseEvent.CLICK, function(e) {
			trace("Sub1View button is clicked!");
		});
		
	}	
}



/*

// The following imports should be added to Main.hx

import test.views.Sub1.Sub1View;
import test.views.Sub1.Sub1Mediator;


// The following code should be added to AppContext.init()

		mediatorMap.mapView(Sub1View, Sub1Mediator);

		
// The following code should be added to AppMediator.register()

		var viewSub1View:Sub1View = new Sub1View();
		this.view.addChild(viewSub1View);


*/