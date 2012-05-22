package smd.server.ka.data;
import haxe.Firebug;
import neko.Web;
import smd.server.base.data.DataFunctions;

/**
 * ...
 * @author Jonas Nyström
 */

class Functions extends DataFunctions
{
	static public function __func_hello() {		
		Firebug.trace(Web.getParams().get('hej'));
	}
	
	static public function __func_updatescorx() {
		Firebug.trace('Update Scorx!');
	}
}