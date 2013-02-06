package smd.server.proto.service;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{

	public static function main() 
	{
		var uri = Web.getURI();
		trace('service: ' + uri); 
	}
	
}