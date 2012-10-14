package smd.server.sx.result;
import cx.ReflectTools;
import cx.WebTools;
import smd.server.base.result.TemplateResult;
import smd.server.sx.State;
import smd.server.sx.user.User;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexResult extends TemplateResult
{

	public function new(templateFile:String, ?data:Dynamic = null) {
		data = this.addData(data);
		//data = { };
		super(templateFile, data);
	}	

	private function addData(data:Dynamic) {
		
		Reflect.setField(data, 'domain', WebTools.domaintag);		
		Reflect.setField(data, 'user', User.user);
		
		return data;
	}
}