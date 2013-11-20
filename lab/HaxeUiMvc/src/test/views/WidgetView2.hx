package test.views;

import haxe.ui.toolkit.controls.Button;
import sx.mvc.view.haxeui.HBoxView;



/**
 * ...
 * @author 
 */
class WidgetView2View extends HBoxView
 {

	public var btn:Button;	
	
	override public function createChildren() 
	 {
		
		var but:Button = new Button();
		but.width = 50;
		but.height = 50;
		this.addChild(but);
		
		var but:Button = new Button();
		but.width = 50;
		but.percentWidth = 100;
		but.height = 50;
		this.addChild(but);
		
		var but:Button = new Button();
		but.width = 50;
		but.height = 50;
		this.addChild(but);				
	}
	
}

class WidgetView2Mediator extends mmvc.impl.Mediator<WidgetView2View>
{
	override function onRegister() 
	 {
		trace('WidgetView2Mediator registered');	
		
		/*
		this.view.btn.onPress = function(e)
		{
			// do something...
		};		
		*/
		
	}	
}



/*

import test.WidgetView2.WidgetView2View;
import test.WidgetView2.WidgetView2Mediator;


		var viewWidgetView2View:WidgetView2View = new WidgetView2View();
		this.view.addChild(viewWidgetView2View);



		mediatorMap.mapView(WidgetView2View, WidgetView2Mediator);

*/