package smd.server.proto;

import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import smd.server.proto.Site;

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
		Log.trace = Firebug.trace;	
		Config.init();
		trace(State.domaintag);
		
		
        this.addModule(new Site());
    }	
		
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.println(error.getMessage());
	}
	
	override public function onError(exception : Exception) : Void {		
		Lib.println('EXCEPTION:');
		Lib.println(exception.getMessage());
	}
	
}