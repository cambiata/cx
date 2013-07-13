/**
 * ...
 * @author Jonas Nyström
 */

package devtasks;

import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class Config
{
	static public var filesPath:String 			= Web.getCwd();	
	
	static public var email = 'x';
	static public var passwd = 'y';
	static public var sheetData = '0Ar0dMoySp13UdG9tMThLUVNncmpzdHNpVDVLa1FtQ1E';	

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