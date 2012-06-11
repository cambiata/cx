package smd.rest.controller;
import cx.TokenTools;

/**
 * ...
 * @author Jonas Nyström
 */

class HomeController {
	public function new() {}
	public function getIndex() {
		return 'index';
	}
	
	public function getToken(u:String, p:String) {
		var token = TokenTools.getToken( { u:u, p:p, e:Date.now() } );
		return token;
	}
	
	public function getUser(token:String) {
		var user = TokenTools.getUser(token);
		trace(user);
		return user.u;
	}
	
	
}