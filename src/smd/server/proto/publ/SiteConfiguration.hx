package smd.server.proto.publ;

import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.configuration.AbstractServerConfiguration;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Firebug;
import haxe.Json;
import haxe.Log;
import haxe.Serializer;
import neko.Lib;
import neko.Web;
import smd.server.proto.lib.auth.AuthSqlite;

import smd.server.proto.lib.ScorxDBTools;

import smd.server.proto.base.BaseConfiguration;
import smd.server.proto.base.Message;


import smd.server.proto.Context;
import smd.server.proto.ContextTransfer;
import smd.server.proto.lib.auth.AuthDummy;
import smd.server.proto.lib.auth.AuthLogic;

import smd.server.proto.lib.auth.IAuthCheck;
import smd.server.proto.publ.Site;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;
import smd.server.proto.ContextTransfer.ContextTransferTool;

class SiteConfiguration extends BaseConfiguration {
	
    public override function init() {
        super.init();		
		//Log.trace = SiteConfiguration.trace;	
		Log.trace = Firebug.trace;
		try {
			ConfigTools.loadConfig(Config, Config.configFile);			
			//Context.user = Auth.check(new AuthDummy()); // validUserHandler, getUserHandler, loginFailHandler);
			
			
			//var authLogic = new AuthLogic(new AuthDummy());
			var authLogic = new AuthLogic(new AuthSqlite(ScorxDBTools.getCnx(Config.filesPath + Config.dbFile)));
			Context.user = authLogic.currentUser; 
			Context.transferData = Serializer.run(ContextTransferTool.getTransfer(Context.user));			
			
			
			
		} catch (e:Dynamic) onInitError(e);
        this.addModule(new Site());
    }	
	

	
	public static function trace(v : Dynamic, ?inf : haxe.PosInfos ) {
		var type = if( inf != null && inf.customParams != null ) inf.customParams[0] else null;
		if( type != "warn" && type != "info" && type != "debug" && type != "error" )
			type = if( inf == null ) "error" else "log";

		var code = inf.fileName + ":" + inf.lineNumber;
		
		var str:String = '';
		try str = Std.string(v) catch( e : Dynamic ) str += "???";

		//neko.Lib.print('<script type="text/javascript">console.' + type + '(decodeURIComponent("' + StringTools.urlEncode(str) + '"))</script>');
		var message:Message = { type:type, message:str, ref:code };
		Context.traces.push(message);
		
	}
	
	
	
}
/*
import harfang.configuration.AbstractServerConfiguration;
class SiteConfiguration extends AbstractServerConfiguration {
	public function new() {
		super();
	}
}
*/