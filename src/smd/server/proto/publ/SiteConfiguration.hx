package smd.server.proto.publ;

import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import neko.Web;
import smd.server.proto.base.BaseConfiguration;
import smd.server.proto.publ.Site;

class SiteConfiguration extends BaseConfiguration {
	
	static private var URI_REGISTER:String = '/register';
	static private var URI_START:String = '/start';	
	
    public override function init() {
        super.init();		
		Log.trace = Firebug.trace;	
		try {
			ConfigTools.loadConfig(Config, Config.configFile);
			Users.init(loginFailHandler);
			Context.user = Users.currentUser;
		} catch (e:Dynamic) onInitError(e);
		
        this.addModule(new Site());
    }	
	
	static public function loginFailHandler(user:String, pass:String):Bool {
		Web.redirect('/loginfail/' + user + '/' + pass);
		return true;
	}	
	
}