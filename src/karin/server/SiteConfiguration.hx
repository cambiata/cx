package karin.server;
import cx.ConfigTools;
import haxe.Firebug;
import haxe.Session;
import karin.db.DB;
import karin.server.auth.AuthKarin;
import neko.SQLiteSession;
import smd.server.proto.lib.auth.AuthDummy;
import smd.server.proto.lib.auth.AuthLogic;

import haxe.Log;
import karin.Config;
import karin.Context;
import karin.server.remoting.Server;

import smd.server.proto.base.BaseConfiguration;
/**
 * ...
 * @author Jonas Nyström
 */
class SiteConfiguration extends BaseConfiguration
{
	public override function init() {
        super.init();		
		//Log.trace = SiteConfiguration.trace;	
		Log.trace = Firebug.trace;
		


		try {
			ConfigTools.loadConfig(Config, Config.configFile);				
			Session.savePath = Config.filesPath + 'sessions/';
			
			DB.init();
			var authLogic = new AuthLogic(new AuthKarin());			
			
			Context.setUser(authLogic.currentUser);		
			//trace(Context.user);
			
			var ctx = new haxe.remoting.Context();			
			ctx.addObject("Server", new Server());
			if ( haxe.remoting.HttpConnection.handleRequest(ctx) ) {
				return;	
			}
			
			this.addModule(new Site());			
			
			
		} catch (e:Dynamic) onInitError(e);
        
    }	
	
}