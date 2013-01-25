package smd.server.proto;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import neko.Web;
import smd.server.proto.Site;

import harfang.url.URLDispatcher;

class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
		
		/*
		Log.trace = Firebug.trace;		
		ConfigTools.loadConfig(Config, Config.configFile);
		new Functions();		
		User.getCurrentUser();
		User.checkRedirect();	
		State.getAlerts();
		*/
    }
	
	
    public override function init() {
        super.init();
        this.addModule(new Site());
    }	
		
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.println(error.getMessage());
	}
	
	override public function onError(exception : Exception) : Void {		
		Lib.println(exception.getMessage());
	}
	
}