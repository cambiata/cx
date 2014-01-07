package harfang.result;
import cx.Lib;
import cx.Web;
import hxjson2.JSON;

/**
 * ...
 * @author Jonas Nyström
 */

class JsonResult extends ActionResult
{
	private var object:Dynamic;
	public function new(object:Dynamic) {
		this.object = object;
	}
	
	override public function execute():String 
	{
		Web.setHeader('content-type', "application/json");		
		return JSON.encode(this.object);
	}	
}