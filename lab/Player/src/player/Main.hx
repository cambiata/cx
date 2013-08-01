package player;

import player.Config;

import pgr.gconsole.GameConsole;
import scorx.controller.Confload;
import scorx.controller.Load;
import scorx.controller.Load.LoadCommand;
import scorx.controller.LoadPages;
import scorx.controller.LoadPages.LoadPagesCommand;
import scorx.controller.Play;
import scorx.controller.Play.PlayCommand;
import scorx.controller.Stop;
import scorx.controller.Stop.StopCommand;
import scorx.model.Configuration;
import scorx.model.TimerModel;
import scorx.model.Debug;
import scorx.view.Buttons.ButtonsView;
import scorx.view.Buttons.ButtonsMediator;
import scorx.view.Pages.PagesView;
import scorx.view.Pages.PagesMediator;
import sx.data.ScoreLoader;


import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Scroll;
import ru.stablex.ui.widgets.Button;

import sx.mvc.MvcMain;
import sx.mvc.app.AppView;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.app.base.AppBaseContext;

import cx.ConfigTools;
import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.WidgetItem;
import cx.layout.Vertical;

import flash.Lib;
import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextFormat;

 
/**
 * ...
 * @author 
 */

//----------------------------------------------------------------
// AppView
// Create application user interface here
//

class AppMediator extends AppBaseMediator
{

	@inject public var debug:Debug;
	@inject public var confload:Confload;
	@inject public var config:Configuration;
	@inject public var loadPages:LoadPages;
	
	var buttonsView:ButtonsView;	
	var pagesView:PagesView;
	var layoutManager:LayoutManager;
	
	override function register() 	
	{
		debug.log(config.host);
		debug.log(config.productId);
		debug.log(config.userId);
		
		// autoload pages after configuration model update
		mediate(this.config.updated.add(function() 
		{
			this.reload();
		}));		
		
		this.buttonsView = new ButtonsView();
		this.view.addChild(this.buttonsView);
		this.pagesView = new PagesView();
		this.view.addChild(this.pagesView);
		
		this.layoutManager = new LayoutManager();
		this.layoutManager.add(new WidgetItem(this.buttonsView, Horizontal.RIGHT, Vertical.TOP));
		var pagesItem:WidgetItem = new WidgetItem(this.pagesView, Horizontal.STRETCH_MARGIN(0, 60), Vertical.STRETCH);
		this.layoutManager.add(pagesItem);
		pagesItem.afterResize = function (x, y, width, height) 
		{
			this.pagesView.afterResize(x, y, width, height);	
		}		
		this.layoutManager.resize();
		
		// kickof configuration
		this.confload.dispatch();
		
		//---------------------------------------------------------------------------------------------------		
		this.setupDebug();

	}
	
	function setupDebug() 
	{
		GameConsole.init(0.33, "DOWN");
		GameConsole.registerVariable(config, 'host', 'host');
		GameConsole.registerVariable(config, 'productId', 'productId');
		GameConsole.registerVariable(config, 'userId', 'userId');
		GameConsole.registerFunction(config, 'setValues', 'setValues', true);
		GameConsole.registerFunction(this, 'reload', 'reload', true);
	}
	
	public function reload()
	{
		var loadParameters:LoadParameters = new LoadParameters();
		loadParameters.host = config.host;
		loadParameters.productId = config.productId;
		loadParameters.userId = config.userId;
		loadParameters.type = ScoreLoadingType.screen;
		loadPages.dispatch(loadParameters);				
	}
		
	
}

//----------------------------------------------------------------
// AppContext
// Setup application dependencies here
//

class AppContext extends AppBaseContext
{
	override function config() 
	{			
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");				
	}
	
	override function init() 	
	{
		injector.mapSingleton(TimerModel);
		injector.mapSingleton(Configuration);
		injector.mapSingleton(Debug);
		
		injector.mapSingleton(ScoreLoader);
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);
		commandMap.mapSignalClass(Load, LoadCommand);
		commandMap.mapSignalClass(LoadPages, LoadPagesCommand);
		
		commandMap.mapSignalClass(Play, PlayCommand);
		commandMap.mapSignalClass(Stop, StopCommand);
		
		mediatorMap.mapView(ButtonsView, ButtonsMediator);			
		mediatorMap.mapView(PagesView, PagesMediator);			
		//---------------------------------------------------------------------------
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}

}


//----------------------------------------------------------------
// Main entry point
// This shouldn't need to be touched.
//

class Main extends MvcMain
{
	static public function main() 
	
	{
		Lib.current.addChild(new Main());
	}
	
	override function init()
	{
		this.addChild(new AppContext().view);
	}
}

