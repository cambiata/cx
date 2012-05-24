package smd.server.base.data;
import cx.ReflectTools;
import cx.Tools;
import haxe.Firebug;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class DataFunctions 
{
	static public var params:Hash<String>;
	
	public function new() {

		params = Web.getParams();
		if (!params.keys().hasNext()) return;
		Firebug.trace('hehe');
		
		var keys = Web.getParams().keys();
		var classMethods = ReflectTools.getMethods(this);		
		for (key in keys) {
			var value = params.get(key);
			var funcname = "__" + key + "_" + value;
			if (Lambda.has(classMethods, funcname)) {
				ReflectTools.callMethod(this, funcname, []);
			}			
		}
	}
}