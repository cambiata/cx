package ex.views;

import flash.events.MouseEvent;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import cx.mvc.view.haxeui.HBoxView;
import cx.mvc.view.haxeui.VBoxView;

/**
 * ...
 * @author 
 */
class DatalistView extends VBoxView 
{

	public var btn:Button;	
	
	override public function createChildren() 
	{
		var listTest:ListView = new ListView();
		listTest.width = 300;		
		listTest.height = 300;
		listTest.percentHeight = 100;
		for (n in 0...100) { 
			listTest.dataSource.add( { text:"Datalist Item " + n } );
		}				
		this.addChild(listTest);
		
		this.btn =  new Button();
		this.btn.text = "DatalistView button";
		this.btn.width = 300;
		this.btn.height = 40;	
		this.addChild(this.btn);		
		
	}
}

class DatalistMediator extends mmvc.impl.Mediator<DatalistView>
{
	override function onRegister() 
	 {
		trace('DatalistMediator registered and eventlisteners setup');	
		
		this.view.btn.addEventListener(MouseEvent.CLICK, function(e) {
			trace("DatalistView button is clicked!");
		});
		
	}	
}



/*

// The following imports should be added to Main.hx

import test.views.Datalist.DatalistView;
import test.views.Datalist.DatalistMediator;


// The following code should be added to AppContext.init()

		mediatorMap.mapView(DatalistView, DatalistMediator);

		
// The following code should be added to AppMediator.register()

		var viewDatalistView:DatalistView = new DatalistView();
		root.addChild(viewDatalistView);


*/