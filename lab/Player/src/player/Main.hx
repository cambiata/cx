package player;

import pgr.gconsole.GameConsole;
import player.controller.Conf;
import player.controller.Load;
import player.controller.Load.LoadCommand;
import player.controller.LoadPages;
import player.controller.LoadPages.LoadPagesCommand;
import player.controller.Play;
import player.controller.Play.PlayCommand;
import player.controller.Stop;
import player.controller.Stop.StopCommand;
import player.model.ConfigModel;
import player.model.ProductModel;
import player.model.TimerModel;
import player.view.Buttons.ButtonsView;
import player.view.Buttons.ButtonsMediator;
import player.view.Pages.PagesView;
import player.view.Pages.PagesMediator;
import sx.data.ScoreLoader;

import player.Config;

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

	@inject public var configuration:Conf;
	@inject public var config:ConfigModel;
	@inject public var product:ProductModel;
	
	var buttonsView:ButtonsView;	
	var pagesView:PagesView;
	var layoutManager:LayoutManager;
	
	override function register() 	
	{
		// kickof configuration
		this.configuration.dispatch();
		
		trace(config.HOST);
		trace(product.productId);
		trace(product.userId);
		
		this.buttonsView = new ButtonsView();
		this.pagesView = new PagesView();
		
		this.view.addChild(this.buttonsView);
		this.view.addChild(this.pagesView);
		
		this.layoutManager = new LayoutManager();
		this.layoutManager.add(new WidgetItem(this.buttonsView, Horizontal.CENTER, Vertical.BOTTOM));
		var pagesItem:WidgetItem = new WidgetItem(this.pagesView, Horizontal.STRETCH_MARGIN(0, 100), Vertical.STRETCH_MARGIN(0, 40));
		this.layoutManager.add(pagesItem);
		pagesItem.afterResize = function (x, y, width, height) 
		{
			this.pagesView.afterResize(x, y, width, height);	
		}
		
		this.layoutManager.resize();

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
		GameConsole.init(0.33, "DOWN");
		GameConsole.log("Log this message");
		
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");				
	}
	
	override function init() 	
	{
		injector.mapSingleton(TimerModel);
		injector.mapSingleton(ConfigModel);
		injector.mapSingleton(ProductModel);
		
		injector.mapSingleton(ScoreLoader);
		
		commandMap.mapSignalClass(Conf, ConfCommand);
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

