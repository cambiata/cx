package smd.server.ka;

import cx.CacheTools;
import cx.ConfigTools;
import cx.Web;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import haxe.Firebug;
import hxjson2.JSON;
import neko.Lib;
import neko.Random;
import neko.Sys;
import smd.server.base.auth.AuthTools;
import smd.server.base.SiteState;
import smd.server.ka.auth.KaAuth;
import smd.server.ka.config.Config;
import smd.server.ka.Site;


class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
        this.addModule(new Site());	
		
		ConfigTools.loadConfig(Config, Web.getCwd() + 'conf/Config.txt');
		//SiteState.messages.infos.push(Config.scorxroot);
		SiteState.user = AuthTools.getCurrentUser(new KaAuth(Web.getCwd() + 'auth/autentisering.dat'));			
    }
	
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.println(JSON.encode(error));
	}
	
	override public function onError(exception : Exception) : Void {
		Lib.println(exception);
	}
	
}