package smd.server.base.result;
import harfang.controller.result.ActionResult;
import cx.FileTools;


/**
 * ...
 * @author Jonas Nyström
 */

class TemplateResult extends ActionResult
{
	private var templateFile:String;
	private var data:Dynamic;
	public function new(templateFile:String, ?data:Dynamic=null) {
		this.templateFile = (FileTools.exists(templateFile)) ? templateFile : cx.Web.getCwd() + '/' + templateFile;
		this.data = data;
		if (!FileTools.exists(this.templateFile)) throw new harfang.exception.Exception("Can't find templateFile " + this.templateFile);		
	}
	
	override public function execute() {		
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
        return output;
	}	

}