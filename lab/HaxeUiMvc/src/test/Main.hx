package test;

import flash.Lib;

import cx.layout.HaxeUiItem;
import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.SpriteItem;
import cx.layout.Vertical;

import cx.mvc.AppMain;
import cx.mvc.app.base.AppBaseContext;
import cx.mvc.app.base.AppBaseMediator;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;

import test.views.Test.TestView;
import test.views.Test.TestMediator;
import test.views.WidgetView2.WidgetView2View;
import test.views.WidgetView2.WidgetView2Mediator;

import test.views.Sub2.Sub2View;
import test.views.Sub2.Sub2Mediator;
import test.views.Sub1.Sub1View;
import test.views.Sub1.Sub1Mediator;

/**
 * ...
 * @author Jonas Nyström
 */

//-------------------------------------------------------------------------
// Main entry point
// This shouldn't need to be touched.
//
class Main extends AppMain
{
	static public function main() Lib.current.addChild(new Main());		
	override function init() this.addChild(new AppContext().view);	
} 

//------------------------------------------------------------------------ 
 
class AppContext extends AppBaseContext
{
	override function config() 
	{			
		trace('Config - add application configuration here');
		//Macros.addStyleSheet("assets/styles/gradient/gradient.css");
		//ConfigTools.getConfig(Config);		
	}
	
	override function init() 	
	{
		trace('Init - setup mmvc stuff here');
		/*
		injector.mapSingleton(Configuration);		
		*/

		mediatorMap.mapView(TestView, TestMediator);
		mediatorMap.mapView(WidgetView2View, WidgetView2Mediator);		
		mediatorMap.mapView(Sub2View, Sub2Mediator);	
		mediatorMap.mapView(Sub1View, Sub1Mediator);		
		
		
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}
}

//------------------------------------------------------------------------ 

class AppMediator extends AppBaseMediator
{
	var root: Root;
	
	override function register() 	
	{		
		trace('Register root view - this is where the main view is registered and subview elements setup');
		
		Toolkit.init();		
		
		Toolkit.openFullscreen(function(root:Root) 
		{
			var viewTestView:TestView = new TestView();
			root.addChild(viewTestView);
			var viewWidgetView2View:WidgetView2View = new WidgetView2View();
			root.addChild(viewWidgetView2View);					
			
			var viewSub2View:Sub2View = new Sub2View();
			root.addChild(viewSub2View);	
				
			var viewSub1View:Sub1View = new Sub1View();
			root.addChild(viewSub1View);			
			
			
			var layout = new LayoutManager();			
			layout.add(new HaxeUiItem(viewWidgetView2View, Horizontal.STRETCH, Vertical.TOP));			
			layout.add(new HaxeUiItem(viewTestView, Horizontal.LEFT, Vertical.STRETCH_MARGIN(60, 0)));						
			layout.add(new HaxeUiItem(viewSub1View, Horizontal.RIGHT, Vertical.BOTTOM));	
			layout.resize();						
		});
	}	
}



