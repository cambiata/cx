package smd.server.ka.result;
import cx.neko.Session;
import cx.Web;
import haxe.Firebug;
import smd.server.base.result.ActionResult;
import smd.server.base.controller.UserController;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.AuthTools;
import smd.server.base.result.TemplateResult;
import smd.server.base.SiteState;
import smd.server.base.types.Messages;
import smd.server.base.types.PageData;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexResult extends ActionResult
{
	private var templateFile:String;
	private var data:PageData;
	
	public function new(?templateFile:String='templates/index.html', ?user:AuthUser=null, sidebarStr:String=null, contentStr=null) {		
		
		var sidebar = (sidebarStr == null) ? new TemplateResult('templates/content/sidebar.html', user ).execute() : sidebarStr;
		
		var content = (contentStr == null) ? new TemplateResult('templates/content/home.html', user ).execute() : contentStr;
		content += addDebugInfo();
		
		this.data = { 
			title:'Körakademin, Mellansels folkhögskola',
			user:user, 
			menu: new TemplateResult('templates/menu.html', {}).execute(),
			sidebar:sidebar,
			content:content,
			messages:SiteState.messages,
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
	
	private function addDebugInfo() {
		var debugInfo = '';
		//debugInfo += 'NekoSession.getSavePath():' + cx.neko.NekoSession.getSavePath();
		return debugInfo;
	}
}

