package print.mgr;

import cx.BaseCodeTools;
import cx.TimerTools;
import flash.geom.Point;
import flash.Lib;
import flash.filesystem.File;
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import haxe.xml.Check.Rule;
import pgr.gconsole.GameConsole;
import print.mgr.model.MgrStatus;
import print.mgr.model.Status;
import print.mgr.view.MgrStartup.MgrStartupView;
import print.mgr.view.PrintLoad.PrintLoadMediator;
import print.mgr.view.PrintLoad.PrintLoadView;
import print.mgr.view.Default.DefaultView;
import print.mgr.view.Default.DefaultMediator;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.ViewStack;
import scorx.controller.Confload;
import scorx.controller.LoadPages;
import scorx.data.JobData;
import scorx.model.AirEvents;
import scorx.model.Configuration;
import scorx.model.Debug;
import sx.data.ScoreLoader;
import sx.mvc.app.AppView;
import sx.mvc.app.base.AppBaseContext;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.MvcMain;

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

  class AppMediator extends AppBaseMediator
{
	@inject public var debug:Debug;
	@inject public var confload:Confload;
	@inject public var configuration:Configuration;	
	@inject public var airEvents:AirEvents;	
	@inject public var status:Status;
	
	var txtParams:Text;
	var txtEvents:Text;
	var txtStatus:Text;
	var txtNative:Text;
	var viewstack:ViewStack;
	var startupView:MgrStartupView;
	var printLoadView:PrintLoadView;
	var defaultView:DefaultView;
	
	override function register() 	
	{
		airEvents.init();
		
		setupListeners();
		
		setupUI();
		
	
		mediate(this.status.updated.add(function(status:MgrStatus) {
			this.txtStatus.text = Std.string(status);		
			
			switch (status)
			{
				case MgrStatus.Startup: this.viewstack.showIdx(0);
				case MgrStatus.PrintLoad(productId, userId, host, type): this.viewstack.showIdx(1);
				default:
					this.viewstack.showIdx(2);
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
		
		// kickof configuration
		this.confload.dispatch();
		
		//---------------------------------------------------------------------------------------------------		
		this.setupDebug();

	}
	
	function setupUI() 
	{
		
		var button:Button = UIBuilder.create(Button);
		button.text = 'Print Manager ' + airEvents.getAppVersion();
		button.w = 160;
		this.view.addChild(button);
		
		txtParams = UIBuilder.create(Text);
		txtParams.text = 'Params...';
		txtParams.x = 200;
		this.view.addChild(txtParams);			
		
		txtStatus = UIBuilder.create(Text);
		txtStatus.text = 'Status...';
		txtStatus.x = 500;
		this.view.addChild(txtStatus);				
		
		
		txtEvents = UIBuilder.create(Text);
		txtEvents.text = 'Params...';
		txtEvents.x = 200;
		txtEvents.y = 20;
		this.view.addChild(txtEvents);		

		txtNative = UIBuilder.create(Text);
		txtNative.text = 'Params...';
		txtNative.x = 200;
		txtNative.y = 40;
		this.view.addChild(txtNative);	
		
		//------------------------------------------------------------------------------
		
		this.viewstack = UIBuilder.create(ViewStack);
		this.viewstack.wrap = true;
		this.viewstack.x = 0;
		this.viewstack.y = 50;
		this.view.addChild(viewstack);					
		
		// 0
		startupView = new MgrStartupView();		
		this.viewstack.addChild(this.startupView);		
		
		// 1
		printLoadView = new PrintLoadView();
		this.viewstack.addChild(this.printLoadView);		
		
		// 2
		defaultView = new DefaultView();
		this.viewstack.addChild(this.defaultView);
		
		this.viewstack.refresh();
		
		this.viewstack.showIdx(0);
		
	}
	
	function setupDebug() 
	{ 
		GameConsole.init(0.33, "DOWN");
		GameConsole.registerVariable(configuration, 'host', 'host');
		GameConsole.registerVariable(configuration, 'productId', 'productId');
		GameConsole.registerVariable(configuration, 'userId', 'userId');
		GameConsole.registerFunction(configuration, 'setValues', 'setValues', true);
		//GameConsole.registerFunction(this, 'reload', 'reload', true);
	}
	
	function setupListeners()
	{
		NativeApplication.nativeApplication.addEventListener(BrowserInvokeEvent.BROWSER_INVOKE, function(e : BrowserInvokeEvent)
		{
			//this.txtEvents.text = 'BROWSER EVENT ' + e.arguments;
			//trace( 'BROWSER EVENT ' + e.arguments);
			
			var jobType:String = e.arguments[0];
			
			
			var jobData:JobData = new JobData(
				Std.parseInt(e.arguments[1]),
				Std.parseInt(e.arguments[2]),
				BaseCodeTools.decode(e.arguments[3]),
				e.arguments[4]
			);
			
			this.txtEvents.text = jobType + ' : ' + jobData.productId + ' : ' + jobData.userId + ' : ' + jobData.host;
		
			this.configuration.setValues(jobData.productId, jobData.userId, jobData.host);
			
			switch (jobType)
			{
					case Config.INVOKER_MESSAGE_PRINTJOB:
						this.status.setStatus(MgrStatus.PrintLoad(jobData.productId, jobData.userId, jobData.host, Std.string(ScoreLoadingType.print)));
					default:
						this.status.setStatus(MgrStatus.Default);
			}			
		});
		
		
		
		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, function(e : InvokeEvent)
		{			
			this.txtNative.text = 'NATIVE EVENT ' + e.arguments;
			trace( 'NATIVE EVENT ' + e.arguments);
			this.status.setStatus(MgrStatus.Default);
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
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);		
		commandMap.mapSignalClass(LoadPages, LoadPagesCommand);		
		
		mediatorMap.mapView(DefaultView, DefaultMediator);	
		mediatorMap.mapView(PrintLoadView, PrintLoadMediator);
		
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
			NativeApplication.nativeApplication.activeWindow.maxSize = new Point(800, 600);
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