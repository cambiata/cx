package micromvc.client;
import cx.ReflectTools;
#if haxe3
import js.Browser;
#else

#end

import js.JQuery;
import js.Lib;




/**
 * ...
 * @author Jonas Nyström
 */

class JQController extends Controller
{
	public function new() 
	{	
		super();
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
		#if haxe3
		new JQuery(Browser.window).bind('hashchange', this._onHashChange);	
		#else
		new JQuery(js.Lib.window).bind('hashchange', this._onHashChange);	
		#end
		this.onHashChange(null);
	}
	
	private function _onHashChange(e=null) {
		//trace('JQController.onHashChange() : ' + Lib.window.location.hash);
		#if haxe3
		this.onHashChange(Browser.window.location.hash);
		#else		
		this.onHashChange(js.Lib.window.location.hash);
		#end
	}
	
	private function onHashChange(hash:String) {
		trace('Hash: ' + hash);
	}
	
}