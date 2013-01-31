package smd.server.proto;
import cx.ConfigTools;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
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
}