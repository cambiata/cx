package smd.server.base.result;
import cx.OdtTools;
import cx.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class OdtResult extends ActionResult
{
	private var odtFile:String;
	private var data:Dynamic;
	public function new(odtFile:String, ?data:Dynamic=null) {
		this.odtFile = cx.Web.getCwd() + '/' + odtFile;
		this.data = data;
		if (!neko.FileSystem.exists(this.odtFile)) throw new harfang.exceptions.Exception("Can''t find odt file " + odtFile);		
	}
	
	override public function execute() {	
		/*
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
		*/
		
		var z = OdtTools.getZipEntries(this.odtFile);
		var xmlStr = OdtTools.getContentXmlStr(z);
		
		var html = '';
		html += '<div class="" style="background-color:#f5f5f5; width:100%;"><div style="width:800px; margin:0px auto; background-color:white;padding:40px 60px;">';
		html += OdtTools.getMeta() + OdtTools.getHtmlFromContent(xmlStr, z, 40);
		html += '</div></div>';
        return html;
	}
}