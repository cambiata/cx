package smd.server.base.result;
import cx.FileTools;
import neko.Web;
import smd.server.base.SiteState;

/**
 * ...
 * @author Jonas Nyström
 */

class HtmlWrappedResult extends ActionResult
{
	private var data:Dynamic;
	private var docTemplate:String;
	private var htmlFile:String;
	static private var template:String = 'templates/content/document.html';
	
	public function new(htmlFile:String, ?data:Dynamic=null, docTemplate:String = 'templates/content/document.html') {
		this.data = data;
		this.htmlFile = (FileTools.exists(htmlFile)) ? htmlFile : cx.Web.getCwd() + '/' + htmlFile;
		
		this.docTemplate = FileTools.exists(docTemplate) ? docTemplate : Web.getCwd() + '/' + docTemplate;
		//this.docTemplate = docTemplate;
	
		//trace(this.docTemplate);
		if (!FileTools.exists(this.docTemplate))
		this.docTemplate = FileTools.exists(template) ? template : Web.getCwd() + '/' + template;
		//SiteState.messages.infos.push(this.docTemplate);
		
		
		if (!neko.FileSystem.exists(this.htmlFile)) throw new harfang.exceptions.Exception("Can''t find html file " + this.htmlFile);		
		if (!neko.FileSystem.exists(this.docTemplate)) throw new harfang.exceptions.Exception("Can''t find template file " + this.docTemplate);		
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