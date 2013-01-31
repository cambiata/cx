package smd.server.proto.base;

import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import neko.Web;
import smd.server.proto.publ.Site;

class BaseConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
    }
	
	/*
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
	*/
	
		
	override public function onHTTPError(error : HTTPException) : Void {
		trace(error.getMessage());
	}
	
	override public function onError(exception : Exception) : Void {				
		trace(exception.getMessage());
	}
	
	private function onInitError(error:Dynamic) {
		trace(Std.string(error));
	}
	
	
}