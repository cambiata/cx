/**
 * ...
 * @author Jonas Nyström
 */

package gustav;

import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class Config
{
	static public var filesPath:String 			= Web.getCwd();	
	static public var dbFile:String 			= 'data/karin.sqlite';		
	static public var gustavMaxUsers:Int		= 50000;		
	static public var vipusersSql:String 		= 'data/vipusers.sql';	
	
	//---------------------------------------------------------------------
	static public var testString:String  		= 'Hello from Config.hx!';
}


/*
---------------------------------------------------
 Usage:
---------------------------------------------------
in Main.hx:

	ConfigTools.loadConfig(Config, Config.configFile);
	trace(Config.testString) 
	
	
---------------------------------------------------	
main.Config:
	
	testString = Hello from main.conf !
	
*/