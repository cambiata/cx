package cx;
import js.JQuery;

/**
 * ...
 * @author Jonas Nyström
 */

class JQueryTools 
{
	
	static public function invokeIDs(clss:Dynamic) {
		var metaFields = haxe.rtti.Meta.getFields(ReflectTools.getClass(clss));
		trace(metaFields);

		var fields = ReflectTools.getObjectFields(metaFields);
		
		for (field in fields) {
			var jq = new JQuery('#' + field);
			if (jq.length > 0) {
				Reflect.setField(clss, field, jq);
			} else {
				trace('Cant find dom element #' + field);
			}
		}			
	}
	
}