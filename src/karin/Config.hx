package karin;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */
class Config
{

	static public var filesPath:String 			= Web.getCwd();	
	static public var configFile:String 		= Web.getCwd() + 'main.conf';
	static public var testString:String 		= 'Hello Config!';	
	static public var dbFile:String 			= 'data/scorx.sqlite';	
	
}