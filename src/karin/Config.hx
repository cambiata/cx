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
	static public var dbFile:String 			= 'data/karin.sqlite';	
	static public var vipusersSql:String 		= 'data/vipusers.sql';	
	static public var devtasksDbFile:String 	= 'data/devtasks.sqlite';	
	static public var dtasksFile:String 		= 'tasks/devtasks.json';	
	static public var gustavMaxUsers:Int		= 50000;	
}