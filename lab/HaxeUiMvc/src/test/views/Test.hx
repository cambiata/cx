package test.views;

import flash.media.Sound;
import flash.net.URLRequest;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import flash.events.Event;
import flash.events.MouseEvent;
import sx.mvc.view.haxeui.VBoxView;

/**
 * ...
 * @author 
 */

class TestView extends VBoxView 
{
	public var btnTest:Button;
	override function createChildren()
	{
		btnTest = new Button();
		btnTest.text = "btnTest";
		btnTest.width = 150;
		btnTest.height = 50;		
		
		this.addChild(btnTest);		
		
		var listTest:ListView = new ListView();
		listTest.width = 300;		
		listTest.height = 300;
		listTest.percentHeight = 100;
		
		for (n in 0...100) { 
			listTest.dataSource.add( { text:"Item " + n } );
		}				
		this.addChild(listTest);			
	}
}

class TestMediator extends mmvc.impl.Mediator<TestView>
{
	override function onRegister() 
	{
		trace('TestMediator registered, eventlisteners setup');			
		this.view.btnTest.addEventListener(MouseEvent.CLICK, function(e) {
			trace('btnTest clicked!');
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