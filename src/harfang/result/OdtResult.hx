package harfang.result;
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
	private var docTemplate:String;
	public function new(odtFile:String, ?data:Dynamic=null, docTemplate:String = 'templates/content/document.html') {
		this.odtFile = cx.Web.getCwd() + '/' + odtFile;
		this.data = data;
		this.docTemplate = docTemplate;
		if (!neko.FileSystem.exists(this.odtFile)) throw new harfang.exceptions.Exception("Can''t find odt file " + odtFile);		
	}
	
	override public function execute() {	
		/*
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
		*/
		
		var z = OdtTools.getZipEntries(this.odtFile);
		var xmlParts = OdtTools.getXmlParts(z);
		var html = OdtTools.getMeta() + OdtTools.getHtmlFromContent(xmlParts, z, 40);
		
		return new TemplateResult(this.docTemplate , { document:html }).execute() ;
		
		//var html = '';
		//html += '<div class="" style="background-color:#f5f5f5; width:100%; padding-top:20px; padding-bottom:20px;"><div class="document" style="width:800px; border:1px solid #ddd; margin:0px auto; background-color:white;padding:80px 60px 100px 80px;/*box-shadow: 0 1px 10px rgba(0, 0, 0, 0.15);*/">';
		//html += OdtTools.getMeta() + OdtTools.getHtmlFromContent(xmlStr, z, 40);
		//html += '</div></div>';
        //return html;
	}
}