package smd.server.base.result;
import harfang.controller.result.ActionResult;
import neko.Web;
import templo.Loader;

/**
 * ...
 * @author Jonas Nyström
 */

class TemploResult extends ActionResult
{

	private var templateFile:String;
	private var context:Dynamic;

	public function new(templateFile:String='index.mtt', context:Dynamic=null, path:String='') {	
		this.templateFile = templateFile;
		this.context = context;		
		path = (path == '') ? Web.getCwd() : path;		
		templo.Loader.BASE_DIR = path + "tmp/";
		templo.Loader.TMP_DIR = path + "tpl/";		
		templo.Loader.MACROS = null; // path + "tmp/macros.mtt";		
	}
	
	override public function execute() {		
		var t = new templo.Loader(this.templateFile);
		var r = t.execute(this.context);
		return r;
	}
	
}