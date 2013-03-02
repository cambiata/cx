package karin.client.controller;
import haxe.remoting.HttpAsyncConnection;
import js.Lib;
import js.JQuery;
import micromvc.client.JQController;


/**
 * ...
 * @author Jonas Nyström
 */
class RemotingController extends JQController {

	private var cnx:HttpAsyncConnection;
	
	public function new() {
		super();
		#if haxe3
		var URL = js.Browser.location.host;
		#else
		var URL = Lib.window.location.host;
		#end
		trace('Client: Server url = $URL');		
		this.cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
		this.cnx.setErrorHandler( function(err) { trace("Client Error : " + Std.string(err)); } );				
	}	
}