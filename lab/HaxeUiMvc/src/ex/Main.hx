package ex;

import flash.Lib;

import cx.layout.HaxeUiItem;
import cx.layout.Horizontal;
import cx.layout.Vertical;
import cx.layout.LayoutManager;

import cx.mvc.AppMain;
import cx.mvc.app.base.AppBaseContext;
import cx.mvc.app.base.AppBaseMediator;

import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;

import ex.views.Toolbar.ToolbarView;
import ex.views.Toolbar.ToolbarMediator;
import ex.views.Datalist.DatalistView;
import ex.views.Datalist.DatalistMediator;

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
		trace('Config - Add application configuration here');
		Macros.addStyleSheet("assets/styles/gradient/gradient.css");
		//ConfigTools.getConfig(Config);		
	}
	
	override function init() 	
	{
		trace('Init - Setup mmvc stuff here: map model instances, view/mediator couples etc.');

		//injector.mapSingleton(Configuration);		


		
		mediatorMap.mapView(ToolbarView, ToolbarMediator);	
		mediatorMap.mapView(DatalistView, DatalistMediator);
		
		
		// AppView and AppMediator should be mapped as the last couple
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}
}

//------------------------------------------------------------------------ 

class AppMediator extends AppBaseMediator
{
	var root: Root;
	
	override function register() 	
	{		
		trace('Register root view - This is where the main view is registered and subview elements setup');
		
		Toolkit.init();		
		
		Toolkit.openFullscreen(function(root:Root) 
		{

			var viewToolbarView:ToolbarView = new ToolbarView();
			root.addChild(viewToolbarView);			
			
			var viewDatalistView:DatalistView = new DatalistView();
			root.addChild(viewDatalistView);		
			
			var layout = new LayoutManager();			
			layout.add(new HaxeUiItem(viewToolbarView, Horizontal.STRETCH, Vertical.TOP));			
			layout.add(new HaxeUiItem(viewDatalistView, Horizontal.LEFT, Vertical.STRETCH_MARGIN(50, 0)));						
			layout.resize();						
		});
	}	
}



