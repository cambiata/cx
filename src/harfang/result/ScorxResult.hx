package harfang.result;
import smd.server.base.SiteState;
import smd.server.base.types.PageData;
import smd.server.base.auth.AuthUser;
import smd.server.base.types.Messages;
/**
 * ...
 * @author Jonas Nyström
 */

class ScorxResult extends ActionResult
{
	private var templateFile:String;
	private var data:PageData;
	
	public function new(?templateFile:String='templates/index.html', ?user:AuthUser=null, sidebarStr:String=null, contentStr=null) {		
		var sidebar = (sidebarStr == null) ? new TemplateResult('templates/scorx/sidebar.html', user ).execute() : sidebarStr;
		var content = (contentStr == null) ? new TemplateResult('templates/scorx/list.html', user ).execute() : contentStr;
		
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
}

