package scorx.controller;
import Config;

/**
 * ...
 * @author 
 */
 


 import cx.ConfigTools;
 import msignal.Signal.Signal0;
import mmvc.impl.Command;
import scorx.model.Configuration;

/**
 * ...
 * @author 
 */
class Confload extends Signal0 
{
	public var completed:Signal0;	
	public function new() 
	{
		super();
		this.completed = new Signal0();
	}
}

class ConfloadCommand extends Command
{
	@inject public var confload:Confload;
	@inject public var config:Configuration;
	
	override public function execute():Void
	{
		#if (flash || html5) 
		ConfigTools.loadFlashVars(Config); 
		#end
		
		#if (neko || cpp)
		ConfigTools.loadConfig(Config);
		#end		
		
		#if (air3)
			trace('CONIFG AIR');
		#end
		
		this.config.setValues(Config.productId, Config.userId, Config.host, Config.playbackLevel, Config.viewLevel);
		this.confload.completed.dispatch();
	}
}