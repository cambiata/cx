package karin.server;
import cx.ConfigTools;
import haxe.Firebug;
import haxe.Session;
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
		
		
		
		try {			
			var ctx = new haxe.remoting.Context();			
			ctx.addObject("Server", new Server());
			if ( haxe.remoting.HttpConnection.handleRequest(ctx) ) {
				//trace('remoting request');
				return;
			}
		} catch (e:Dynamic) {
			trace('Remoting error ' + e);
		}
		
		try {
			ConfigTools.loadConfig(Config, Config.configFile);	
			SQLiteSession.setSavePath(Config.filesPath + 'sessions/');
			var authLogic = new AuthLogic(new AuthKarin(Config.filesPath + 'g2users.sqlite'));			
			Context.user = authLogic.currentUser;			
			/*
			//
			var authLogic = new AuthLogic(new AuthSqlite(ScorxDBTools.getCnx(Config.filesPath + Config.dbFile)));
			Context.user = authLogic.currentUser; 
			Context.transferData = Serializer.run(ContextTransferTool.getTransfer(Context.user));			
			*/
			
		} catch (e:Dynamic) onInitError(e);
		
		
        this.addModule(new Site());
    }	
	
}