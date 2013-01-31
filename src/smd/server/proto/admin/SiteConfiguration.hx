package smd.server.proto.admin;

import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import smd.server.proto.admin.Site;
import smd.server.proto.base.BaseConfiguration;
import smd.server.proto.Config;
import smd.server.proto.Users;
import smd.server.proto.Context;

class SiteConfiguration extends BaseConfiguration {

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
		trace('ADMIN LOGIN FAIL HANDLER ' + user + ' ' + pass);
		return true;
	}	
	
}