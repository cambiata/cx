package smd.rest.controller;
import cx.TokenTools;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class LoginController 
{

	private var user:TokenUser;
	static public var AUTH_COOKIE:String = 'Auth';
	public function new() 
	{
		var u = Web.getParams().get('u');
		var p = Web.getParams().get('p');		
		if (!this.checkValidUser(u, p)) {
			Web.setCookie(AUTH_COOKIE, '', Date.fromTime(Date.now().getTime() - (1000 * 60 * 60 * 1)));
			return;
		}
		
		var token = TokenTools.getToken( { u:u, p:p, e:Date.now()});
		
		this.user = TokenTools.getUser(token);
		
		Web.setCookie(AUTH_COOKIE, token, Date.fromTime(Date.now().getTime() - (1000 * 60 * 60 * 1)));				
	}
	
	public function getIndex() {
			trace('login');
			trace(this.user);
	}
	
	public function checkValidUser(u:String, p:String) :Bool {
		return (u == 'jonas' && p == '123');
	}
	
}

