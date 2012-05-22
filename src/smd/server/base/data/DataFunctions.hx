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
		var keys = Web.getParams().keys();
		var classFields = ReflectTools.getFields(this);
		
		for (key in keys) {
			var value = params.get(key);
			var funcname = "__" + key + "_" + value;
			if (Lambda.has(classFields, funcname)) {
				var field = ReflectTools.getField(this, funcname);
				if (field != null) field();
			}			
		}
	}
	
}