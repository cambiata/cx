package test;

import flash.media.Sound;
import flash.net.URLRequest;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import sx.mvc.view.haxeui.HBoxView;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author 
 */

class TestView extends HBoxView 
{
	public var button:Button;
	override function createChildren()
	{
		button = new Button();
		button.text = "HBoxView";
		this.addChild(button);		
		
		var list:ListView = new ListView();
		list.width = 300;
		list.height = 300;
		for (n in 0...100) { 
			list.dataSource.add( { text:"Item " + n } );
		}		
		
		this.addChild(list);			
		
		
	}
}

class TestMediator extends mmvc.impl.Mediator<TestView>
{
	override function onRegister() 
	{
		trace('TestMediator registered');			
		this.view.button.addEventListener(MouseEvent.CLICK, function(e) {
			trace('cool');
	
			
		});			
	}	
}


/*

import test.Test.TestView;
import test.Test.TestMediator;


		var viewTestView:TestView = new TestView();
		this.view.addChild(viewTestView);



		mediatorMap.mapView(TestView, TestMediator);

*/