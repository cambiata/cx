package print.inst;

import cx.AIRTools;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;
import flash.text.TextFormat;
import pgr.gconsole.GameConsole;
import print.inst.view.Available.AvailableMediator;
import print.inst.view.Available.AvailableView;
import print.inst.view.Installed.InstalledMediator;
import print.inst.view.Installed.InstalledView;
import print.inst.view.Startup.StartupMediator;
import print.inst.view.Startup.StartupView;
import print.inst.view.Update.UpdateView;
import print.inst.view.Update.UpdateMediator;
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
	var label:Text;
	var button:Button;
	var installView:InstallView;
	var updateView:UpdateView;
	
	override function register() 	
	{
		setupUI();
		
		this.mediate(this.airTools.update.add(function(status:AIRStatus)  {
			Debug.log('AppMediator STATUS ' + Std.string(status));			
			txtStatus.text = Std.string(status);

			switch(status)
			{
				case AIRStatus.installApp(newVersion):
					this.viewstack.showIdx(3);
					//this.label.text = 'Install Scorx Print Manager';
				case AIRStatus.updateApp(installedVersion, newVersion):
					this.viewstack.showIdx(4);
					//this.label.text = 'Update Scorx Print Manager';
				case AIRStatus.available:
					this.viewstack.showIdx(2);
					//this.label.text = 'Install AIR Runtime';
				case AIRStatus.installed:
					this.viewstack.showIdx(1);
					//this.label.text = '';
					
				default:
			}	 
			
		}));				
		
		this.mediate(this.config.updated.add(function() {
			this.txtConfig.text = this.config.printVersion + ' - ' + this.config.productId + ':' + this.config.userId + ':' + this.config.host;			
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
		
		this.viewstack = UIBuilder.create(ViewStack);
		this.viewstack.wrap = true;
		//this.viewstack.trans = new Scale();
		this.viewstack.x = 0;
		this.viewstack.y = 0;
		this.view.addChild(viewstack);			
		
		/*
		 label = UIBuilder.create(Text);
		label.format = Constants.TEXT_FORMAT_HEADER2;
		label.text = '';
		label.align = 'right';
		 label.w = 290;
		 label.x = Constants.INSTALLER_VIEW_W - 300;
		 label.y = 4;
		 this.view.addChild(label);			
		*/
		
		
		txtStatus = UIBuilder.create(Text);
		txtStatus.format = new TextFormat('Arial', 10, 0x666666);
		txtStatus.text = 'status...';
		txtStatus.x = 180;
		txtStatus.y = 120;
		this.view.addChild(txtStatus);	
		this.txtStatus.visible = false;
		
		txtConfig = UIBuilder.create(Text);
		txtConfig.format = new TextFormat('Arial', 10, 0x666666);
		txtConfig.text = '...';
		txtConfig.x = 10;
		txtConfig.y = 120;
		this.view.addChild(txtConfig);		
		this.txtConfig.visible = false;
		
		/*
		button = UIBuilder.create(Button);
		button.text = 'Print Starter';
		this.view.addChild(button);
		*/
		
		//------------------------------------------------------------------------------

			
		
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
		
		//4
		updateView = new UpdateView();
		this.viewstack.addChild(this.updateView);		
		
		this.viewstack.refresh();
		this.viewstack.showIdx(0);		
		

		//---------------------------------------------------------------------------
		
		/*
		button.onPress = function(e) {
			this.viewstack.next();
		}
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
		
		injector.mapSingleton(Debug);
		injector.mapSingleton(Configuration);				
		injector.mapSingleton(AirTools);		
		
		commandMap.mapSignalClass(Confload, ConfloadCommand);						
		
		mediatorMap.mapView(StartupView, StartupMediator);
		mediatorMap.mapView(InstalledView, InstalledMediator);
		
		
		
		mediatorMap.mapView(AvailableView, AvailableMediator);


		mediatorMap.mapView(InstallView, InstallMediator);		


		mediatorMap.mapView(UpdateView, UpdateMediator);		
		
		
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
