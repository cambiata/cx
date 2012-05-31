package smd.server.base.result;
import cx.FileTools;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class HtmlWrappedResult extends ActionResult
{
	private var data:Dynamic;
	private var docTemplate:String;
	private var htmlFile:String;
	public function new(htmlFile:String, ?data:Dynamic=null, docTemplate:String = 'templates/content/document.html') {
		this.htmlFile = cx.Web.getCwd() + '/' + htmlFile;
		this.data = data;
		this.docTemplate = FileTools.exists(Web.getCwd() +  docTemplate) ? docTemplate : 'templates/content/document.html';
		if (!neko.FileSystem.exists(this.htmlFile)) throw new harfang.exceptions.Exception("Can''t find odt file " + htmlFile);		
	}
	
	override public function execute() {	
		/*
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
		*/
		
		//var z = OdtTools.getZipEntries(this.odtFile);
		//var xmlParts = OdtTools.getXmlParts(z);
		//var html = OdtTools.getMeta() + OdtTools.getHtmlFromContent(xmlParts, z, 40);
		var html = FileTools.getContent(this.htmlFile);
		
		return new TemplateResult(this.docTemplate , { document:html }).execute() ;
		
		//var html = '';
		//html += '<div class="" style="background-color:#f5f5f5; width:100%; padding-top:20px; padding-bottom:20px;"><div class="document" style="width:800px; border:1px solid #ddd; margin:0px auto; background-color:white;padding:80px 60px 100px 80px;/*box-shadow: 0 1px 10px rgba(0, 0, 0, 0.15);*/">';
		//html += OdtTools.getMeta() + OdtTools.getHtmlFromContent(xmlStr, z, 40);
		//html += '</div></div>';
        //return html;
	}

	
}