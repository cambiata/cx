package smd.server.sx.result;
import cx.ReflectTools;
import smd.server.base.result.TemplateResult;
import smd.server.sx.State;
import smd.server.sx.user.User;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexResult extends TemplateResult
{

	public function new(templateFile:String, ?data:Dynamic = null, directory:String = '') {
		data = this.addData(data);
		//data = { };
		super(templateFile, data, directory);
	}	

	private function addData(data:Dynamic) {
		
		Reflect.setField(data, 'domain', State.domaintag);		
		Reflect.setField(data, 'user', User.user);
		
		return data;
	}
}