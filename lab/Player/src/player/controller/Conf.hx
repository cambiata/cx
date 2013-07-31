package player.controller;

/**
 * ...
 * @author 
 */
 


 import cx.ConfigTools;
 import msignal.Signal.Signal0;
import mmvc.impl.Command;
import player.Config;
import player.model.ConfigModel;
import player.model.ProductModel;

/**
 * ...
 * @author 
 */
class Conf extends Signal0 {}

class ConfCommand extends Command
{
	@inject public var config:ConfigModel;
	@inject public var product:ProductModel;
	
	override public function execute():Void
	{
		trace('ConfigCommand execute');		
		
		#if (flash || html5) 
		ConfigTools.loadFlashVars(Config); 
		#end
		
		#if (neko || cpp)
		ConfigTools.loadConfig(Config);
		#end				
		
		this.config.HOST = Config.host;
		this.product.productId = Config.productId;
		this.product.userId = Config.userId;		
	}
}