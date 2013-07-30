package ;

import cx.ConfigTools;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import sx.mvc.MvcMain;
import view.Test.TestMediator;
import view.Test.TestView;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends sx.mvc.MvcMain
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

class AppMediator extends sx.mvc.app.base.AppBaseMediator
{
	override function register()
	{
		this.view.addChild(new TestView());		
	}
}

class AppContext extends sx.mvc.app.base.AppBaseContext
{
	override function init()
	{
		mediatorMap.mapView(TestView, TestMediator);		
		//---------------------------------------------------------------------------
		mediatorMap.mapView(sx.mvc.app.AppView, AppMediator);
	}
	
	override function config()
	{
		#if (flash || html5) 
		ConfigTools.loadFlashVars(Config); 
		#end
		#if (neko || cpp)
		ConfigTools.loadConfig(Config);
		#end		
	}
}
