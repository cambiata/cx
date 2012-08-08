package smd.server.base.result;
import cx.FileTools;


/**
 * ...
 * @author Jonas Nyström
 */

class TemplateResult extends ActionResult
{
	private var templateFile:String;
	private var data:Dynamic;
	public function new(templateFile:String, ?data:Dynamic=null, directory:String='') {
		this.templateFile = (FileTools.exists(directory + templateFile)) ? directory + templateFile : cx.Web.getCwd() + '/' + directory + templateFile;
		this.data = data;
		if (!FileTools.exists(this.templateFile)) throw new harfang.exceptions.Exception("Can't find templateFile " + this.templateFile);		
	}
	
	override public function execute() {		
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
        return output;
	}	

}