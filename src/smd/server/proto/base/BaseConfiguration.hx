package smd.server.proto.base;

import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import harfang.url.URLDispatcher;
import haxe.Log;
import neko.Lib;
import neko.Web;

class BaseConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
    }
		
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.print('onHTTPError');
		Lib.print(error.getMessage());
	}
	
	override public function onError(exception : Exception) : Void {				
		Lib.print('onError');
		Lib.print(exception.getMessage());
	}
	
	private function onInitError(error:Dynamic) {
		Lib.print('onInitError');
		Lib.print(Std.string(error));		
	}
	
	/*
	public static function trace(v : Dynamic, ?inf : haxe.PosInfos ) {
		var type = if( inf != null && inf.customParams != null ) inf.customParams[0] else null;
		if( type != "warn" && type != "info" && type != "debug" && type != "error" )
			type = if( inf == null ) "error" else "log";

		var str = inf.fileName + ":" + inf.lineNumber + " : ";
		try str += Std.string(v) catch( e : Dynamic ) str += "???";

		neko.Lib.print('<script type="text/javascript">console.'+type+'(decodeURIComponent("'+StringTools.urlEncode(str)+'"))</script>');
	}
	*/
	
}