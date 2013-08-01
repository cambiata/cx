package print.inst;

import cx.AIRTools;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import pgr.gconsole.GameConsole;
import print.inst.view.Available.AvailableMediator;
import print.inst.view.Available.AvailableView;
import print.inst.view.Installed.InstalledMediator;
import print.inst.view.Installed.InstalledView;
import print.inst.view.Startup.StartupMediator;
import print.inst.view.Startup.StartupView;
import ru.stablex.ui.transitions.Fade;
import ru.stablex.ui.transitions.Scale;
import ru.stablex.ui.transitions.Slide;
import ru.stablex.ui.transitions.Transition;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Text;
import ru.stablex.ui.widgets.ViewStack;
import scorx.controller.Confload;
import scorx.model.AirTools;
import scorx.model.Configuration;
import scorx.model.Debug;
import sx.mvc.app.AppView;
import sx.mvc.app.base.AppBaseContext;
import sx.mvc.app.base.AppBaseMediator;
import sx.mvc.MvcMain;

import print.inst.view.Install.InstallView;
import print.inst.view.Install.InstallMediator;


/**
 * ...
 * @author 
 */

  class AppMediator extends AppBaseMediator
{
	
	@inject public var debug:Debug;
	@inject public var confload:Confload;
	@inject public var config:Configuration;		
	@inject public var airTools:AirTools;
	
	var viewstack:ViewStack;
	var startupView:StartupView;
	var installedView:InstalledView;
	var availableView:AvailableView;
	var txtConfig:Text;
	var txtStatus:Text;
	var button:Button;
	var installView:InstallView;
	
	override function register() 	
	{
		setupUI();

		
		this.mediate(this.airTools.update.add(function(status:AIRStatus)  {
			debug.log('AppMediator STATUS ' + Std.string(status));			
			txtStatus.text = Std.string(status);

			switch(status)
			{
				case AIRStatus.installApp(newVersion):
					this.viewstack.showIdx(3);
				case AIRStatus.updateApp(installedVersion, newVersion):
					//this.viewstack.showIdx(3);
					
				case AIRStatus.available:
					this.viewstack.showIdx(2);
				
				case AIRStatus.installed:
					this.viewstack.showIdx(1);
					
				default:
			}	 
			
		}));				
		
		this.mediate(this.config.updated.add(function() {
			this.txtConfig.text = this.config.productId + ':' + this.config.userId + ':' + this.config.host;			
		}));
		
		
		// kickof configuration
		this.confload.dispatch();
		
		//---------------------------------------------------------------------------------------------------		
		this.setupDebug();
		
		this.airTools.init();
	}
	
	function setupDebug() 
	{ 
		GameConsole.init(0.33, "DOWN");
		GameConsole.registerVariable(config, 'host', 'host');
		GameConsole.registerVariable(config, 'productId', 'productId');
		GameConsole.registerVariable(config, 'userId', 'userId');
		GameConsole.registerFunction(config, 'setValues', 'params', true);
		//GameConsole.registerFunction(this, 'reload', 'reload', true);
	}
	
	function setupUI()
	{
	
		
		txtStatus = UIBuilder.create(Text);
		txtStatus.text = 'STATUS?';
		txtStatus.x = 200;
		this.view.addChild(txtStatus);		
		
		txtConfig = UIBuilder.create(Text);
		txtConfig.text = 'STATUS?';
		txtConfig.x = 200;
		txtConfig.y = 20;
		this.view.addChild(txtConfig);		
		
		button = UIBuilder.create(Button);
		button.text = 'Print Starter';
		this.view.addChild(button);

		
		//------------------------------------------------------------------------------

		this.viewstack = UIBuilder.create(ViewStack);
		this.viewstack.wrap = true;
		//this.viewstack.trans = new Scale();
		this.viewstack.x = 0;
		this.viewstack.y = 50;
		this.view.addChild(viewstack);				
		
		// 0
		this.startupView = new StartupView();		
		this.viewstack.addChild(this.startupView);

		// 1
		this.installedView = new InstalledView();
		this.viewstack.addChild(this.installedView);
		
		// 2		
		this.availableView = new AvailableView();
		this.viewstack.addChild(this.availableView);		
		
		// 3
		installView = new InstallView();
		this.viewstack.addChild(this.installView);
		
		this.viewstack.refresh();
		this.viewstack.showIdx(0);		
		

		//---------------------------------------------------------------------------
		
		button.onPress = function(e) {
			this.viewstack.next();
		}		
		
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
		injector.mapSingleton(AirTools);		
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);						
		
		mediatorMap.mapView(StartupView, StartupMediator);
		mediatorMap.mapView(InstalledView, InstalledMediator);
		
		
		
		mediatorMap.mapView(AvailableView, AvailableMediator);


		mediatorMap.mapView(InstallView, InstallMediator);		
		
		
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}
}
 
 
 
class Main  extends MvcMain
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
