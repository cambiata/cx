package smd.server.ka;

import harfang.configuration.AbstractServerConfiguration;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import hxjson2.JSON;
import neko.Lib;
import smd.server.ka.Site;


class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
        this.addModule(new Site());	
    }
	
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.println(JSON.encode(error));
	}
	
	override public function onError(exception : Exception) : Void {
		Lib.println(exception);
	}
	
}