package micromvc.client;
import cx.ReflectTools;
import js.JQuery;
import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class JQController implements Controller
{
	public function new() 
	{		
		var metaFields = haxe.rtti.Meta.getFields(Type.getClass(this));
		var fields = Reflect.fields(metaFields);
		
		for (field in fields) {
			var jq = new JQuery('#' + field);
			if (jq.length > 0) {
				Reflect.setField(this, field, jq);
			} else {
				trace('Cant find dom element #' + field);
			}
		}	
		
		new JQuery(Lib.window).bind('hashchange', this._onHashChange);	
		this.onHashChange(null);
	}
	
	private function _onHashChange(e=null) {
		//trace('JQController.onHashChange() : ' + Lib.window.location.hash);
		this.onHashChange(Lib.window.location.hash);
	}
	
	private function onHashChange(hash:String) {
		trace('Hash: ' + hash);
	}
	
}