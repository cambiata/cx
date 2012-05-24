package smd.server.ka.data;
import haxe.Firebug;
import neko.Web;
import smd.server.base.data.DataFunctions;
import smd.server.base.SiteState;

/**
 * ...
 * @author Jonas Nyström
 */

class Functions extends DataFunctions
{
	public function __func_hello() {		
		Firebug.trace(Web.getParams().get('hej'));
	}
	
	/*
	static public function __func_updatescorx() {
		Firebug.trace('Update Scorx!');
	}
	*/
	/*
	public function __func_access() {		
		//Firebug.trace('Access update');
		KaAccess.update(function(msg:String) {
			//Firebug.trace(msg);
			SiteState.messages.infos.push(msg);
		});
	}
	*/
	
}