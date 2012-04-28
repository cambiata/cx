package smd.server.ka.result;
import cx.neko.Session;
import cx.Web;
import haxe.Firebug;
import smd.server.base.result.ActionResult;
import smd.server.base.controller.UserController;
import smd.server.base.controller.UserController.LoginUser;
import smd.server.base.controller.UserController.UserTools;
import smd.server.base.result.TemplateResult;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexResult extends ActionResult
{
	private var templateFile:String;
	private var data:PageData;
	public function new(?templateFile:String='templates/index.html', ?user:LoginUser=null, sidebarStr:String=null, contentStr=null) {		
		this.data = { 
			title:'Körakademin, Mellansels folkhögskola',
			user:user, 
			menu: new TemplateResult('templates/menu.html', {}).execute(),
			sidebar:(sidebarStr == null) ? new TemplateResult('templates/sidebar.html', { test:'123' } ).execute() : sidebarStr,
			content: (contentStr == null) ? new TemplateResult('templates/content.html', {}).execute() : contentStr,
		};
		
		this.templateFile = cx.Web.getCwd() + '/' + templateFile;
		if (!neko.FileSystem.exists(this.templateFile)) throw new harfang.exceptions.Exception("Can''t find templateFile " + templateFile);		
	}
	
	override public function execute() {						
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
        return output;
		
	}	
}

typedef PageData = {
	title:String,
	user:LoginUser,	
	menu:String,
	sidebar:String,
	content:String,
}
