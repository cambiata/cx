package test;

import cx.ConfigTools;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.media.Sound;
import flash.net.URLRequest;
import haxe.io.BytesInput;
import haxe.io.Input;
import haxe.ui.toolkit.containers.HBox;
import haxe.ui.toolkit.containers.ListView;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Macros;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import sx.mvc.app.base.AppBaseContext;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.AppMain;
import sx.mvc.MvcMain;


import test.Test.TestView;
import test.Test.TestMediator;

/**
 * ...
 * @author Jonas Nyström
 */

class AppMediator extends AppBaseMediator
{
	
	
	
	/*
	@inject public var confload:Confload;
	@inject public var config:Configuration;	
	@inject public var gridLoader:GridLoader;
	@inject public var pagesLoader:PagesLoader;
	@inject public var channelsLoader:ChannelsLoader;	
	@inject public var errors:Errors;
	var layoutManager:LayoutManager;	
	var viewConfigurationViewView:ConfigurationViewView;	
	var pagesView:PagesView;	
	var zoomView:ZoomView;	
	var viewScrollerView:ScrollerView;
	var viewPlaybackMixerView:PlaybackMixerView;	
	var viewErrordisplayView:ErrordisplayView;
	*/
	var root: Root;
	
	override function register() 	
	{		
		trace('register');
			
		//
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			this.root = root; 
			var viewTestView:TestView = new TestView();
			this.root.addChild(viewTestView);	
		});

		

	
		
		
		
		/*
		// Create views
		this.pagesView = new PagesView();
		this.view.addChild(this.pagesView);		
		
		this.viewConfigurationViewView = new ConfigurationViewView();
		this.view.addChild(viewConfigurationViewView);			
		
		this.zoomView = new ZoomView();
		this.view.addChild(zoomView);		
		
		this.viewScrollerView = new ScrollerView();		
		this.view.addChild(viewScrollerView);
		
		this.viewPlaybackMixerView = new PlaybackMixerView();
		this.view.addChild(viewPlaybackMixerView);
			
		viewErrordisplayView = new ErrordisplayView();
		this.view.addChild(viewErrordisplayView);		
		
		
		// Layout views
		this.layoutManager = new LayoutManager();
		this.layoutManager.add(new WidgetItem(this.viewConfigurationViewView, Horizontal.LEFT_MARGIN(20), Vertical.BOTTOM_MARGIN(20)));
		this.layoutManager.add(new WidgetItem(this.viewScrollerView, Horizontal.STRETCH_MARGIN(40, 60), Vertical.BOTTOM));
		
		this.layoutManager.add(new WidgetItem(this.zoomView, Horizontal.RIGHT, Vertical.TOP));
		this.layoutManager.add(new WidgetItem(this.viewPlaybackMixerView, Horizontal.RIGHT, Vertical.TOP_MARGIN(100)));		
		this.layoutManager.add(new WidgetItem(this.viewErrordisplayView, Horizontal.CENTER, Vertical.CENTER));				
		
		
		var pagesItem:WidgetItem = new WidgetItem(this.pagesView, Horizontal.STRETCH_MARGIN(0, 100), Vertical.STRETCH_MARGIN(0, 30));
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
		
		
		mediate(this.config.updated.add(function() 
		{
			this.pagesLoader.load(config.host, config.productId, config.userId);
			
			if (config.playbackLevel == AccessLevelPlay.FullPlayback)
			{
				TimerTools.delay(function() {
					this.gridLoader.load(config.host, config.productId, config.userId);
					this.channelsLoader.load(config.host, config.productId, config.userId);					
				}, 1000);
			}
			
			
		}));	
		
		this.channelsLoader.result.add(function(result:ChannelsResult) {
			switch(result)
			{
				case ChannelsResult.error(message, url):
					errors.addError(message + ' Url: ' + url);
				default:
			}
		});
		
		this.pagesLoader.result.add(function(result:PagesResult) {
			switch(result)
			{
				case PagesResult.error(message, url):
					errors.addError(message + ' Url: ' + url);
				default:									
			}
		}); 
		
		this.gridLoader.result.add(function(result:GridResult) {
			switch(result)
			{
				case GridResult.error(message, url):
					errors.addError(message + ' Url: ' + url);
				default:									
			}						
		});		
		// kickoff configuration
		this.confload.dispatch();	
		*/		
	}
	
}

class AppContext extends AppBaseContext
{
	override function config() 
	{			
		trace('config');
		Macros.addStyleSheet("assets/styles/gradient/gradient.css");
		ConfigTools.getConfig(Config);		
		//UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		//UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");				
	}
	
	override function init() 	
	{

		/*
		injector.mapSingleton(Configuration);		
		injector.mapSingleton(Setzoom);
		injector.mapSingleton(GridProc);
		injector.mapSingleton(PageSystemsUtils);
		injector.mapSingleton(PlayPosition);
		injector.mapSingleton(GridLoader);
		injector.mapSingleton(PagesLoader);
		injector.mapSingleton(ChannelsLoader);
		injector.mapSingleton(PlaybackEngine);
		injector.mapSingleton(Errors);
		injector.mapSingleton(Zooma);
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);				
		
		mediatorMap.mapView(ZoomView, ZoomMediator);				
		mediatorMap.mapView(PagesView, PagesMediator);					
		mediatorMap.mapView(ConfigurationViewView, ConfigurationViewMediator);	
		mediatorMap.mapView(ScrollerView, ScrollerMediator);
		mediatorMap.mapView(PlaybackMixerView, PlaybackMixerMediator);		
		mediatorMap.mapView(ErrordisplayView, ErrordisplayMediator);				
		*/
		
		mediatorMap.mapView(TestView, TestMediator);		
		
		trace('init');
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}
}

//----------------------------------------------------------------
// Main entry point
// This shouldn't need to be touched.
//
class Main extends AppMain
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
 

