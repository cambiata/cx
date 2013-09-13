package player;


import scorx.data.ChannelsLoader;
import scorx.data.PagesLoader;
import scorx.data.GridLoader;
import scorx.model.PlaybackEngine;
import scorx.model.PlayPosition;
import sx.player.grid.PageSystemsUtils;
import scorx.data.GridProc;
//import sx.data.ScoreLoader;
import scorx.types.ScoreLoadingType;
import sx.mvc.MvcMain;
import sx.mvc.app.AppView;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.app.base.AppBaseContext;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFormat;
import ru.stablex.ui.UIBuilder;

import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.WidgetItem;
import cx.layout.Vertical;

import scorx.controller.Confload;
import scorx.model.Configuration;
import player.view.ConfigurationView.ConfigurationViewView;
import player.view.ConfigurationView.ConfigurationViewMediator;
import player.view.Scroller.ScrollerView;
import player.view.Scroller.ScrollerMediator;
import scorx.view.Pages.PagesView;
import scorx.view.Pages.PagesMediator;
import player.controller.Setzoom;
//import scorx.controller.LoadPages;
//import scorx.controller.LoadPages.LoadPagesCommand;

import scorx.view.Buttons.ButtonsView;
import scorx.view.Buttons.ButtonsMediator;
import player.view.Zoom.ZoomView;
import player.view.Zoom.ZoomMediator;
import flash.display.StageDisplayState;

#if js 
import js.Browser;
import js.JQuery;
#end


/*
import Config;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import scorx.controller.LoadChannels.LoadChannelsController;
import scorx.controller.LoadChannels.LoadChannelsStatus;
import scorx.data.ChannelsLoader;
import scorx.model.PlaybackEngine;

import pgr.gconsole.GameConsole;

import scorx.controller.Load;
import scorx.controller.Load.LoadCommand;
import scorx.controller.LoadChannels.LoadChannelsController;
import scorx.controller.LoadChannels.LoadChannelsCommand;
import scorx.controller.Play;
import scorx.controller.Play.PlayCommand;
import scorx.controller.Stop;
import scorx.controller.Stop.StopCommand;
import scorx.model.TimerModel;
import sx.data.ScoreLoader;
import sx.data.ScoreLoadingType;

import player.view.Smallthumbs.SmallthumbsView;
import player.view.Smallthumbs.SmallthumbsMediator;
import player.view.ConfigurationView.ConfigurationViewView;
import player.view.ConfigurationView.ConfigurationViewMediator;
import player.view.PlaybackMixer.PlaybackMixerView;
import player.view.PlaybackMixer.PlaybackMixerMediator;





import cx.ConfigTools;
import cx.layout.Horizontal;
import cx.layout.LayoutManager;
import cx.layout.WidgetItem;
import cx.layout.Vertical;

*/
 
/**
 * ...
 * @author 
 */

//----------------------------------------------------------------
// AppView
// Create application user interface here
//
/*
class AppMediator extends AppBaseMediator
{

	@inject public var confload:Confload;
	@inject public var config:Configuration;
	@inject public var loadPages:LoadPages;
	@inject public var loadChannelsController:LoadChannelsController;
	
	var buttonsView:ButtonsView;	
	var pagesView:PagesView;
	var layoutManager:LayoutManager;
	var smallthumbsView:SmallthumbsView;
	var zoomView:ZoomView;
	var viewConfigurationViewView:ConfigurationViewView;
	var viewPlaybackMixerView:PlaybackMixerView;
	
	override function register() 	
	{
		Debug.log(config.host);
		Debug.log(config.productId);
		Debug.log(config.userId);
		
		// autoload pages after configuration model update
		mediate(this.config.updated.add(function() 
		{
			this.reload();
		}));		
		
		
		this.buttonsView = new ButtonsView();
		this.view.addChild(this.buttonsView);
		this.pagesView = new PagesView();
		this.view.addChild(this.pagesView);
		
		smallthumbsView = new SmallthumbsView();
		this.view.addChild(smallthumbsView);
		zoomView = new ZoomView();
		this.view.addChild(zoomView);

		viewConfigurationViewView = new ConfigurationViewView();
		this.view.addChild(viewConfigurationViewView);		

		viewPlaybackMixerView = new PlaybackMixerView();
		this.view.addChild(viewPlaybackMixerView);		
		
		this.layoutManager = new LayoutManager();
		this.layoutManager.add(new WidgetItem(this.buttonsView, Horizontal.RIGHT, Vertical.TOP));
		this.layoutManager.add(new WidgetItem(this.smallthumbsView, Horizontal.LEFT, Vertical.STRETCH_MARGIN(0, 30)));
		this.layoutManager.add(new WidgetItem(this.zoomView, Horizontal.RIGHT, Vertical.TOP));
		
		this.layoutManager.add(new WidgetItem(this.viewConfigurationViewView, Horizontal.LEFT_MARGIN(20), Vertical.BOTTOM_MARGIN(20)));
		
		this.layoutManager.add(new WidgetItem(this.viewPlaybackMixerView, Horizontal.RIGHT_MARGIN(4), Vertical.BOTTOM_MARGIN(4)));
		
		var pagesItem:WidgetItem = new WidgetItem(this.pagesView, Horizontal.STRETCH_MARGIN(40, 60), Vertical.STRETCH);
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
		loadPages.status.add(function(status:LoadPagesStatus)
		{
			switch(status) 
			{
				case LoadPagesStatus.started(nrOfPages):
					trace('NrOfPages ' + nrOfPages);				
				case LoadPagesStatus.completed:					
					loadChannelsController.dispatch(loadParameters);
				default:					
			}
		});

		loadChannelsController.status.add(function(status:LoadChannelsStatus)
		{
			
			
		});
		
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
		injector.mapSingleton(ScoreLoader);		
		injector.mapSingleton(ChannelsLoader);		
		injector.mapSingleton(Setzoom);
		injector.mapSingleton(PlaybackEngine);
		
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);
		commandMap.mapSignalClass(Load, LoadCommand);
		commandMap.mapSignalClass(LoadPages, LoadPagesCommand);
		commandMap.mapSignalClass(LoadChannelsController, LoadChannelsCommand);
		
		commandMap.mapSignalClass(Play, PlayCommand);
		commandMap.mapSignalClass(Stop, StopCommand);
		
		mediatorMap.mapView(ButtonsView, ButtonsMediator);			
		mediatorMap.mapView(PagesView, PagesMediator);			
		
		mediatorMap.mapView(SmallthumbsView, SmallthumbsMediator);		
		mediatorMap.mapView(ZoomView, ZoomMediator);		
		mediatorMap.mapView(ConfigurationViewView, ConfigurationViewMediator);
		mediatorMap.mapView(PlaybackMixerView, PlaybackMixerMediator);
		//---------------------------------------------------------------------------
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}

}
*/



class AppMediator extends AppBaseMediator
{
	
	@inject public var confload:Confload;
	@inject public var config:Configuration;	

	
	var layoutManager:LayoutManager;	
	var viewConfigurationViewView:ConfigurationViewView;	
	var pagesView:PagesView;	
	var zoomView:ZoomView;	
	var viewScrollerView:ScrollerView;
	
	override function register() 	
	{
		//Debug.log('register');		
		// autoload pages after configuration model update
		mediate(this.config.updated.add(function() 
		{
			this.loadContent();
		}));			
		
		
		// Create views
		this.pagesView = new PagesView();
		this.view.addChild(this.pagesView);		
		
		this.viewConfigurationViewView = new ConfigurationViewView();
		this.view.addChild(viewConfigurationViewView);			
		
		this.zoomView = new ZoomView();
		this.view.addChild(zoomView);		
		
		this.viewScrollerView = new ScrollerView();		
		this.view.addChild(viewScrollerView);
			
		
		// Layout views
		this.layoutManager = new LayoutManager();
		this.layoutManager.add(new WidgetItem(this.viewConfigurationViewView, Horizontal.LEFT_MARGIN(20), Vertical.BOTTOM_MARGIN(20)));
		this.layoutManager.add(new WidgetItem(this.zoomView, Horizontal.RIGHT, Vertical.TOP));		
		this.layoutManager.add(new WidgetItem(this.viewScrollerView, Horizontal.STRETCH_MARGIN(40, 60), Vertical.BOTTOM));
		
		var pagesItem:WidgetItem = new WidgetItem(this.pagesView, Horizontal.STRETCH_MARGIN(40, 60), Vertical.STRETCH_MARGIN(0, 30));
		this.layoutManager.add(pagesItem);
		pagesItem.afterResize = function (x, y, width, height) 
		{
			this.pagesView.afterResize(x, y, width, height);	
		}		
		
		this.layoutManager.resize();		
		
		#if js
		Lib.current.stage.addEventListener(Event.RESIZE, function(e = null) {
			Debug.log('After resize');
			this.layoutManager.resize(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		});
		#end
		
		// kickof configuration
		this.confload.dispatch();				
	}
	
	private function loadContent()
	{
		/*
		var loadParameters:LoadParameters = new LoadParameters();
		loadParameters.host = config.host;
		loadParameters.productId = config.productId;
		loadParameters.userId = config.userId;
		loadParameters.type = ScoreLoadingType.screen;
		loadPages.dispatch(loadParameters);			
		loadPages.status.add(function(status:LoadPagesStatus)
		{
			switch(status) 
			{
				case LoadPagesStatus.started(nrOfPages):
					//trace('NrOfPages ' + nrOfPages);				
				case LoadPagesStatus.completed:					
					//loadChannelsController.dispatch(loadParameters);
				default:					
			}
		});
		*/		
	}
	
}

class AppContext extends AppBaseContext
{
	override function config() 
	{			
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");				
	}
	
	override function init() 	
	{
		injector.mapSingleton(Configuration);		
		injector.mapSingleton(Setzoom);
		injector.mapSingleton(GridProc);
		injector.mapSingleton(PageSystemsUtils);
		injector.mapSingleton(PlayPosition);
		injector.mapSingleton(GridLoader);
		injector.mapSingleton(PagesLoader);
		injector.mapSingleton(ChannelsLoader);
		injector.mapSingleton(PlaybackEngine);
		
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);				
		
		mediatorMap.mapView(ZoomView, ZoomMediator);				
		mediatorMap.mapView(PagesView, PagesMediator);					
		mediatorMap.mapView(ConfigurationViewView, ConfigurationViewMediator);	
		mediatorMap.mapView(ScrollerView, ScrollerMediator);
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

