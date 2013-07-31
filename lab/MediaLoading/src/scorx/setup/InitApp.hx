package scorx.setup;
import flash.Lib;
import pgr.gconsole.GameConsole;
import pgr.gconsole.GCThemes;
import ru.stablex.ui.UIBuilder;
import cx.ConfigTools;
import jasononeil.CompileTime;

/**
 * ...
 * @author 
 */
class InitApp
{

	public function new() 
	{
		InitConfig();
		initConsole();
		initUI();
	}
	
	function initConsole() 
	{
		GameConsole.init(0.33, "DOWN");
		GameConsole.log("Log this message");
		GameConsole.registerVariable(Config, "productId", "productId", true);
		//GameConsole.registerVariable(Lib.current.stage, "stageWidth", "stageWidth", true);
	}
	
	function initUI() 
	{
		UIBuilder.init("../../assets/ui/scorx-defaults.xml");
		UIBuilder.regSkins("../../assets/ui/scorx-skins.xml");
	}

	function InitConfig() 
	{
		#if (flash || html5)
			ConfigTools.loadFlashVars(Config);			
		#end						
		Config.buildDate = CompileTime.buildDate();		
		trace([Config.productId, Config.userId]);
	}
	
}