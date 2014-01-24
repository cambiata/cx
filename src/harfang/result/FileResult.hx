package harfang.result;

import cx.FileTools;
import harfang.result.ActionResult;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */
class FileResult extends ActionResult
{	
	
	private var filename:String;
	private var mime:String;
	
	public function new(filename:String, mime:String) {
		this.filename = filename;		
		this.mime = mime;
	}
	
	override public function execute():String 
	{
		var examplename = FileTools.getFilename(this.filename);
		var content = FileTools.getContent(this.filename);
		

		Web.setHeader('content-type', this.mime);	
		Web.setHeader('content-disposition', 'attachment; filename="$examplename"');
		Web.setHeader('content-length', Std.string(content.length));
		return content;		
	}
	
}