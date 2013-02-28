package karin.client;

import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{
	
	static function main() 
	{		
		var URL = js.Browser.location.host;
		trace('Client: Server url = $URL');
		
		var cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
		cnx.setErrorHandler( function(err) { trace("Client Error : "+Std.string(err)); } );
		
		// call Server.foo
		cnx.Server.foo.call([1, 2], function(val) {
				trace('Result from Server.foo: $val');
			});		
	}
	
}