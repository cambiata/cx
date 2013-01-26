package smd.server.base.result;
import harfang.controller.result.ActionResult;

/**
 * ...
 * @author Jonas Nyström
 */

class TemploResult extends ActionResult
{
	private var templateFile:String;
	private var context:Dynamic;

	public function new(templateFile:String='index.mtt', context:Dynamic=null) {	
		this.templateFile = templateFile;
		this.context = context;
		
		templo.Loader.BASE_DIR = "F:/_www/proto/tmp/";
		templo.Loader.TMP_DIR = "F:/_www/proto/tpl/";
		templo.Loader.MACROS = null; // no macro file				
	}
	
	override public function execute() {		
		//return "TemploResult " + this.templateFile;
		// the template context which will be available 
		// loads template 
		var t = new templo.Loader(this.templateFile);
		var r = t.execute(this.context);
		//neko.Lib.print(r);		

		return r;
		
	}
	
}