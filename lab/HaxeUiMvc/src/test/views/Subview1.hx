package test.views;

import haxe.ui.toolkit.controls.Button;
import cx.mvc.view.HBoxView;
import cx.mvc.view.VBoxView;

/**
 * ...
 * @author 
 */
class Subview1View extends VBoxView /* HBoxView */
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		
		this.btn = UIBuilder.create(Button);
		this.btn.text = "Subview1View";
		this.btn.w = 140;
		this.addChild(this.btn);
		
		this.w = 200;
		this.h = 100;		
	}
	
	override public functin addSkin()
	 {
		
		var skin = new Paint();
		skin.color = 0xFF0000;
		skin.apply(this);				
	}
}

class Subview1Mediator extends mmvc.impl.Mediator<Subview1View>
{
	override function onRegister() 
	 {
		trace('Subview1Mediator registered');	
		
		this.view.btn.onPress = function(e)
		{
			// do something...
		};		
		
	}	
}



/*

import test.views.Subview1.Subview1View;
import test.views.Subview1.Subview1Mediator;


		var viewSubview1View:Subview1View = new Subview1View();
		this.view.addChild(viewSubview1View);



		mediatorMap.mapView(Subview1View, Subview1Mediator);

*/