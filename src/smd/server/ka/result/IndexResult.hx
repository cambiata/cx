package smd.server.ka.result;
import cx.FileTools;
import cx.neko.Session;
import cx.Web;
import haxe.Firebug;
import neko.FileSystem;
import neko.Lib;
import smd.server.base.result.ActionResult;
import smd.server.base.controller.UserController;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.AuthTools;
import smd.server.base.result.TemplateResult;
import smd.server.base.SiteState;
import smd.server.base.types.Messages;
import smd.server.base.types.PageData;
import smd.server.ka.config.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexResult extends ActionResult
{
	private var templateFile:String;
	private var data:PageData;
	private var user:AuthUser;
	
	public function new(templateFile:String='index.html', user:AuthUser=null, sidebarStr:String=null, contentStr=null) {		
		
		this.user = user;
		
		this.templateFile = Config.templateDir + templateFile;
		if (!neko.FileSystem.exists(this.templateFile)) throw new harfang.exceptions.Exception("Can''t find templateFile " + templateFile);		
		
		//-----------------------------------------------------------------------------------------------------
		
		var tplDir = Config.templateDir;		
		var dir = (this.user.role != null) ? tplDir + 'auth' : tplDir + 'anon';
		SiteState.messages.infos.push(dir + ' ' + FileSystem.exists(dir));
		dir += '/';
		
		//-----------------------------------------------------------------------------------------------------
		
		this.data = { 
			title:'Körakademin, Mellansels folkhögskola',
			user: user, 
			menu: new TemplateResult(dir +'menu.html', { } ).execute(),
			sidebar: (sidebarStr == null) ? new TemplateResult(dir + 'sidebar.html', user ).execute() : sidebarStr,
			content: (contentStr == null) ? new TemplateResult(dir + 'home.html', user ).execute() : contentStr,
			messages:SiteState.messages,
		};		

	}
	
	override public function execute() {						
		var templateStr = cx.FileTools.getContent(this.templateFile);
        var t = new haxe.Template(templateStr);
        var output = t.execute(this.data);
		return output;		
		
		//return this.templateFile;
	}	
	
	private function addDebugInfo() {
		var debugInfo = '';
		//debugInfo += 'NekoSession.getSavePath():' + cx.neko.NekoSession.getSavePath();
		return debugInfo;
	}
}

