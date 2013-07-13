package install;

import flash.display.StageAlign;
import flash.display.StageScaleMode;

import cx.command.msignal.Command;
import cx.command.msignal.SerialCommand;
import cx.ConfigTools;
import cx.flash.ui.UI;
import cx.FlashGUITools;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.TimerEvent;
import flash.Lib;
import flash.net.URLRequest;
import flash.utils.Timer;

/**
 * ...
 * @author 
 */
class InstallerMain
{
	var btnLaunch:Sprite;
	var btnInstall:Sprite;

	public var airSwf:Dynamic ;
	
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;		
		
		new InstallerMain(Lib.current);
	}
	
	public function new(target:Sprite )
	{
		var startupCommand:SerialCommand = new SerialCommand([
				new ConfigCommand(),
				new LoadAirSwfCommand(this),
				new KickoffCommand(this.onStatusCheck),
			], 
			function () {
				trace('Startup ready!');
			});
		startupCommand.start();	
		
		btnInstall = UI.createButton('Install', onInstallBtnClick,  300, 50, 0x00FF00);
		target.addChild(btnInstall);
		
		btnLaunch = UI.createButton('Launch', onLaunchBtnClick, 300, 70, 0x0000FF);
		target.addChild(btnLaunch);
	}
	
	function onLaunchBtnClick() 
	{		
		if (this.airSwf == null)
		{
			trace('Air SWF is not loaded!');
			return;
		}					
		this.airSwf.launchApplication(Config.appid, Config.pubid, Config.applauncharg);
	}
	
	function onInstallBtnClick() 
	{
		if (this.airSwf == null)
		{
			trace('Air SWF is not loaded!');
			return;
		}		

		trace([Config.appurl, Config.airversion, Config.appinstallarg]);
		this.airSwf.installApplication(Config.appurl, Config.airversion, Config.appinstallarg);
		
	}
	
	private function onStatusCheck()
	{
		var airRuntime:Bool = false;
		var airPrintout:Bool = false;
		var airPrintoutVersion:String = null;
		
		if (this.airSwf != null)
		{		
			airRuntime = (this.airSwf.getStatus() == "installed");
							
		}	
		
		this.airSwf.getApplicationVersion(Config.appid, Config.pubid, function (version:String) {
			trace(version);
			airPrintout = (version != null);
			airPrintoutVersion = version;
		});				
		
		
		trace([airRuntime, airPrintout, airPrintoutVersion, Config.appid, Config.pubid]);
		
		if (airRuntime == false)
		{
			this.btnInstall.alpha = 1;
		}
		else
		{
			
			if (airPrintout) 
			{
				trace('show launch');
				this.btnInstall.alpha = 0;
				this.btnLaunch.alpha = 1;
			}
			else
			{
				this.btnInstall.alpha = 1;
				this.btnLaunch.alpha = 0;
			}
		}
		
	}	
}

class ConfigCommand extends Command
{
	override public function execute()
	{
		trace('config...');
		ConfigTools.loadFlashVars(Config);
		trace(Config.appid);
		this.complete();		
	}
}

class LoadAirSwfCommand extends Command
{
	var holder:Dynamic;
	public function new(holder:Dynamic)
	{
		super();
		this.holder = holder;
	}
	override public function execute()
	{
		trace('LoadAirSwfCommand...');
		var airSWFLoader_:Loader = new Loader();
		airSWFLoader_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onAirSwfLoadingError);
		airSWFLoader_.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) 	{
			trace('Air SWF loaded!');
			trace(airSWFLoader_.content);
			
			this.holder.airSwf = airSWFLoader_.content;
			trace(this.holder.airSwf.getStatus());
			this.complete();
		});				
		try 
		{
			trace('Load ' + Config.AIR_SWF_URL);
			airSWFLoader_.load(new URLRequest(Config.AIR_SWF_URL));
		} catch (err:Dynamic)
		{
			this.onAirSwfLoadingError();
		}
	}
	
	private function onAirSwfLoadingError(e:Event=null):Void 
	{
		trace('ERROR loading AirSwf');
	}
	
}

class KickoffCommand extends Command
{
	var checkCallback:Void -> Void;
	
	public function new(checkCallback:Void->Void)
	{
		super();
		this.checkCallback = checkCallback;
	}
	override public function execute()
	{
		// do something...
		var timer:Timer = new Timer(2000);
		timer.addEventListener(TimerEvent.TIMER, function (e) {
			this.checkCallback();
		});
		timer.start();
		this.complete();
	}
}