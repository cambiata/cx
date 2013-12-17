package print.mgr;

import cx.AirAppTools;
import cx.BaseCodeTools;
import cx.EnumTools;
import cx.TimerTools;
import cx.WebTools;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.Lib;
import flash.filesystem.File;
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.text.TextFormat;
import flash.utils.Function;
import haxe.xml.Check.Rule;
import pgr.gconsole.GameConsole;
import print.mgr.model.MgrStatus;
import print.mgr.model.PrinterConfig;
import print.mgr.model.Printjob;
import print.mgr.model.Status;
import print.mgr.view.MgrStartup.MgrStartupView;
import print.mgr.view.PrintLoad.PrintLoadMediator;
import print.mgr.view.PrintLoad.PrintLoadView;
import print.mgr.view.Default.DefaultView;
import print.mgr.view.Default.DefaultMediator;
import print.mgr.view.PrintoutProcess.PrintoutProcessView;
import print.mgr.view.PrintoutProcess.PrintoutProcessMediator;
import print.mgr.view.PrintoutSelect.PrintoutSelectView;
import print.mgr.view.PrintoutSelect.PrintoutSelectMediator;
import print.mgr.view.Thumbnails.ThumbnailsView;
import print.mgr.view.Thumbnails.ThumbnailsMediator;
import print.mgr.view.PrintoutDone.PrintoutDoneView;
import print.mgr.view.PrintoutDone.PrintoutDoneMediator;
import player.view.Errordisplay.ErrordisplayView;
import player.view.Errordisplay.ErrordisplayMediator;
import scorx.data.Errors;
import sx.ScorxColors;

import scorx.data.PagesLoader;


import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.ViewStack;
import scorx.controller.Confload;
import scorx.controller.LoadPages;
import scorx.data.JobData;
import scorx.model.AirEvents;
import scorx.model.AirTools;
import scorx.model.Configuration;
import sx.data.ScoreLoader;
import sx.mvc.app.AppView;
import sx.mvc.app.base.AppBaseContext;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.MvcMain;
import scorx.types.ScoreLoadingType;

import flash.events.BrowserInvokeEvent;
import flash.desktop.NativeApplication;
import flash.events.InvokeEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.InvokeEvent;

import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;

/**
 * ...
 * @author 
 */

 //@:bitmap("assets/img/scorx/scorx-blue.png") class BitmapDataLogo extends BitmapData { }
  class AppMediator extends AppBaseMediator
{
	@inject public var debug:Debug;
	@inject public var confload:Confload;
	@inject public var configuration:Configuration;	
	@inject public var airEvents:AirEvents;	
	@inject public var status:Status;
	//@inject public var loader:ScoreLoader;
	@inject public var loadThumbnails:LoadPages;
	@inject public var printConfig:PrinterConfig;
	@inject public var thumbsLoader:PagesLoader;
	@inject public var errors:Errors;
		
	var txtParams:Text;
	var txtEvents:Text;
	var txtStatus:Text;
	var txtNative:Text;
	var label:Text;
	var viewstack:ViewStack;
	var startupView:MgrStartupView;
	var printLoadView:PrintLoadView;
	var defaultView:DefaultView;
	
	var thumbnailView:ThumbnailsView;	
	var printSelectView:PrintoutSelectView;
	var printProcessView:PrintoutProcessView;
	var printDoneView:PrintoutDoneView;
	var errorsView:ErrordisplayView;
	
	override function register() 	
	{
		airEvents.init();
		
		setupDebug();
		
		setupUI();
		
		/*
		mediate(this.loadThumbnails.status.add(function(status:LoadPagesStatus) {
			switch(status)
			{
				case LoadPagesStatus.started(nrOfPages):
					trace('Thumbnail loading started ' + nrOfPages );	
					this.printConfig.init(nrOfPages);
					this.thumbnailView.init(nrOfPages);
					
				case LoadPagesStatus.progress(pageInfo):
					trace('progress');
					this.thumbnailView.addPage(pageInfo.pageNr, pageInfo.data);
					
				case LoadPagesStatus.completed(nrOfPages):
					trace('COMPLETED ' + nrOfPages);
					this.thumbnailView.freeze();
					this.status.setStatus(MgrStatus.PrintSelect);
			}
		}));
		*/
		
		this.thumbsLoader.result.add(function(result:PagesResult) {
			trace('thumbs result...' + Std.string(result));
			switch(result)
			{
				case PagesResult.started(nrOfPages):
					this.printConfig.init(nrOfPages);
					this.thumbnailView.init(nrOfPages);
				case PagesResult.success(pageNr, nrOfPages, data):
					this.thumbnailView.addPage(pageNr, data);
				case PagesResult.complete(nrOfPages):
					this.thumbnailView.freeze();
					this.status.setStatus(MgrStatus.PrintSelect);
				case PagesResult.error(message, url):
					this.errors.addError(message + ":" + url);
			}
		});
		

		mediate(this.status.updated.add(function(status:MgrStatus) {
			this.txtStatus.text = Std.string(status);		
			
			switch (status)
			{
				case MgrStatus.Startup: 
					{
						this.viewstack.showIdx(0);
						//this.label.text = 'Startup ' + airEvents.getAppVersion() ;
					}
				case MgrStatus.PrintLoad(productId, userId, host, type): 
					{
						this.viewstack.showIdx(1);
						//this.label.text = 'Loading thumbnails...';
						configuration.setValues(productId, userId, host);
						// Load thumbs!
						this.thumbsLoader.load(configuration.host, configuration.productId, configuration.userId, "thumb");
						
					}
				case MgrStatus.PrintSelect:
						//this.label.text = 'Select printer';
						this.viewstack.showIdx(3);
						
				case MgrStatus.PrintProcess(pageNr, nrOfPages, action):
						//this.label.text = '$action page $pageNr/$nrOfPages';
						this.viewstack.showIdx(4);
				case MgrStatus.PrintDone:
						//this.label.text = 'Done!';
						this.viewstack.showIdx(5);
				default:					
					{
						this.viewstack.showIdx(2);
						//this.label.text = 'Scorx Print Manager  x' + airEvents.getAppVersion();
					}
					
			}
		}));
		
		
		mediate(this.configuration.updated.add(function() 
		{
			this.txtParams.text = this.configuration.productId + ':' + this.configuration.userId;
		}));				
		
		mediate(this.airEvents.update.add(function(msg:String) 
		{
			this.txtEvents.text = msg;
		}));

		/*
		mediate(this.loadThumbnails.started.add(function(nrOfPages:Int) {
			trace('Thumbnail loading started ' + nrOfPages );			
		}));		
		
		mediate(this.loadThumbnails.progress.add(function(loadInfo:LoadedPageInfo) {
			trace('loaded thumbnail ' + loadInfo.pageNr  + ' of ' + loadInfo.pageNr);			
		}));
		
		mediate(this.loadThumbnails.completed.add(function(nrOfPages:Int) {
			trace('COMPLETED ' + nrOfPages);
		}));
		*/
		

		//setupListeners();
		
		
		// kickof configuration
		this.confload.dispatch();
		
		//---------------------------------------------------------------------------------------------------		
		
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, onBrowserInvoke);
		
		trace(AirAppTools.getPrinters());

	}
	
	function onBrowserInvoke(e : BrowserInvokeEvent)
	{
		var jobType:String = e.arguments[0];
		var jobData:JobData = new JobData(
			Std.parseInt(e.arguments[1]),
			Std.parseInt(e.arguments[2]),
			BaseCodeTools.decode(e.arguments[3]),
			e.arguments[4]
		);
		this.txtEvents.text = 'Jokkas ' + jobType + ' : ' + jobData.productId + ' : ' + jobData.userId + ' : ' + jobData.host;
		
		Debug.log(jobType + ' : ' + jobData.productId + ' : ' + jobData.userId + ' : ' + jobData.host);
		this.configuration.setValues(jobData.productId, jobData.userId, jobData.host);
		this.txtNative.text = Std.string(this.status);
		this.status.setStatus(MgrStatus.PrintLoad(jobData.productId, jobData.userId, jobData.host, Std.string(ScoreLoadingType.thumb)));				
	}
	
	function setupUI() 
	{		
		
		//var logo:Bitmap = new Bitmap(new BitmapDataLogo(0, 0));
		//trace(new BitmapDataLogo(0, 0).width);
		//logo.x = 4;
		//logo.y = 4;
		//this.view.addChild(logo);
		
		var logoLabel = UIBuilder.create(Text);
		logoLabel.format = new TextFormat('Arial', 32, 0xFFFFFF);
		logoLabel.text = 'Scorx Print - (' + airEvents.getAppVersion() + ')';
		logoLabel.w = 390;
		logoLabel.x = 8;		
		this.view.addChild(logoLabel);
		label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text ='';
		label.align = 'right';
		label.w = 300;
		label.x = 800 - label.w - 10;
		label.y = 4;
		this.view.addChild(label);		
		
		var button:Button = UIBuilder.create(Button);
		button.text = 'Scorx Print ' + airEvents.getAppVersion();
		button.w = 200;
		button.y = 510;
		button.x = 10;
		//this.view.addChild(button);
		
		txtParams = UIBuilder.create(Text);
		txtParams.text = 'Params...';
		txtParams.x = 220;
		txtParams.y = 500;
		this.view.addChild(txtParams);			
		
		txtStatus = UIBuilder.create(Text);
		txtStatus.text = 'Status...';
		txtStatus.x = 600;
		txtStatus.y = 500;
		this.view.addChild(txtStatus);				
		
		txtEvents = UIBuilder.create(Text);
		txtEvents.text = 'Events...';
		txtEvents.x = 600;
		txtEvents.y = 520;
		this.view.addChild(txtEvents);		

		txtNative = UIBuilder.create(Text);
		txtNative.text = 'Native...';
		txtNative.x = 220;
		txtNative.y = 520;
		this.view.addChild(txtNative);	
		
		
		this.thumbnailView = new ThumbnailsView();
		this.thumbnailView.y = 240;
		this.view.addChild(this.thumbnailView);		
		

		
		
		//------------------------------------------------------------------------------
		
		this.viewstack = UIBuilder.create(ViewStack);
		this.viewstack.wrap = true;
		this.viewstack.x = 0;
		this.viewstack.y = 40;
		this.view.addChild(viewstack);					
		
		//-------------------------------------------------------------------------
		
		// 0
		startupView = new MgrStartupView();		
		this.viewstack.addChild(this.startupView);		
		
		// 1
		printLoadView = new PrintLoadView();
		this.viewstack.addChild(this.printLoadView);		
		
		// 2
		defaultView = new DefaultView();
		this.viewstack.addChild(this.defaultView);
		
		// 3
		printSelectView = new PrintoutSelectView();
		this.viewstack.addChild(this.printSelectView);		
		
		// 4
		printProcessView = new PrintoutProcessView();
		this.viewstack.addChild(this.printProcessView);				
		
		// 5
		printDoneView = new PrintoutDoneView();
		this.viewstack.addChild(this.printDoneView);			
		
		//-------------------------------------------------------------------------
		
		this.viewstack.refresh();
		
		//------------------------------------------------------------------------------
		

		
		this.viewstack.showIdx(0);

		this.errorsView = new ErrordisplayView();
		this.errorsView.x = (800 - this.errorsView.w) / 2;
		this.errorsView.y = 120;
		this.view.addChild(this.errorsView);		
		
		
		
		button.onPress = function(e) {			
			//errors.addError('Test');
			status.setStatus(MgrStatus.PrintLoad(this.configuration.productId, this.configuration.userId, this.configuration.host, 'print'));			
		}
		
	}
	
	function setupDebug() 
	{ 
		GameConsole.init(0.33, "UP");
		GameConsole.registerVariable(configuration, 'host', 'host');
		GameConsole.registerVariable(configuration, 'productId', 'productId');
		GameConsole.registerVariable(configuration, 'userId', 'userId');
		GameConsole.registerFunction(configuration, 'setValues', 'params', true);
		//GameConsole.registerFunction(this, 'reload', 'reload', true);
	}
	
	function setupListeners()
	{
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, function(e : BrowserInvokeEvent)
		{
			TimerTools.delay(function() 
			{
				var jobType:String = e.arguments[0];
				var jobData:JobData = new JobData(
					Std.parseInt(e.arguments[1]),
					Std.parseInt(e.arguments[2]),
					BaseCodeTools.decode(e.arguments[3]),
					e.arguments[4]
				);
				this.txtEvents.text = jobType + ' : ' + jobData.productId + ' : ' + jobData.userId + ' : ' + jobData.host;
				
				var host = WebTools.addSlash(WebTools.addHttpPrefix(jobData.host));
				Debug.log(jobType + ' : ' + jobData.productId + ' : ' + jobData.userId + ' : ' + host);
				this.configuration.setValues(jobData.productId, jobData.userId, host);
				this.status.setStatus(MgrStatus.PrintLoad(jobData.productId, jobData.userId, host, Std.string(ScoreLoadingType.print)));
			}, 1000);
		});
		
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent)
		{			
			this.txtNative.text = 'NATIVE EVENT ' + e.arguments;
			trace( 'NATIVE EVENT ' + e.arguments);
		});			
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
		
		injector.mapSingleton(Debug);
		injector.mapSingleton(Configuration);				
		injector.mapSingleton(AirEvents);
		injector.mapSingleton(Status);
		injector.mapSingleton(ScoreLoader);				
		injector.mapSingleton(PrinterConfig);
		injector.mapSingleton(Printjob);
		injector.mapSingleton(PagesLoader);
		injector.mapSingleton(Errors);
		
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);		
		commandMap.mapSignalClass(LoadPages, LoadPagesCommand);		
		
		mediatorMap.mapView(DefaultView, DefaultMediator);	
		mediatorMap.mapView(PrintLoadView, PrintLoadMediator);
		mediatorMap.mapView(PrintoutSelectView, PrintoutSelectMediator);
		mediatorMap.mapView(PrintoutProcessView, PrintoutProcessMediator);		
		mediatorMap.mapView(ThumbnailsView, ThumbnailsMediator);		
		mediatorMap.mapView(PrintoutDoneView, PrintoutDoneMediator);
		mediatorMap.mapView(ErrordisplayView, ErrordisplayMediator);		
		
		
		mediatorMap.mapView(AppView, AppMediator);
	}
}
 
 class Main extends MvcMain
{
	static public function main() 
	{		
		Lib.current.addChild(new Main());
	}
	
	override function init():Void
	{
		this.addChild(new AppContext().view);		
		TimerTools.delay(function() {
			NativeApplication.nativeApplication.activeWindow.maxSize = new Point(800, 800);
			NativeApplication.nativeApplication.activeWindow.alwaysInFront = true;		
		}, 500);
		
	}
}
 
 
 /*
class Main 
{
	static function main() 
	{
		var app = NativeApplication.nativeApplication;
		app.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent) 
		{

		});
	}
}
*/