package smd.server.proto.publ.controller;
import cx.ValidationTools;
import harfang.controller.AbstractController;
import harfang.exception.Exception;
import ka.tools.PersonTools;
import ka.tools.UserTools;
import mtwin.mail.Part;
import mtwin.mail.Smtp;
import neko.Lib;
import neko.Web;
import smd.server.proto.base.controller.UserController;
import smd.server.base.result.TemploResult;
import smd.server.proto.Config;
import smd.server.proto.Context;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends UserController
{

	@URL("/loginfail/([0-9a-zA-Z@._]+)/([0-9a-zA-Z]+)")
	public function loginfail(user:String, pass:String) { 							
		if (user == 'jon' && pass == 'abc') {
			Web.redirect('/register/' + user + '/' + pass);
			return;
		} 
		// count fails
		//return 'loginfail: ' + user + ' ' + pass; // new TemploResult('start.mtt', Context, Config.filesPath);
		Web.redirect('/');				
	}		
	
	@URL("/register/([0-9a-zA-Z@._]+)/([0-9a-zA-Z]+)")
	public function register(user:String, pass:String) { 						
		trace([user, pass]);
		return new TemploResult('register.mtt', Context, Config.filesPath);
	}	
	
	@URL("/page")
	public function page() { 			
		return new TemploResult('page.mtt', Context, Config.filesPath);
	}		

	//------------------------------------------------------------------------------
	// Home
	
	@URL("^/$")
	public function home() { 	
		return new TemploResult('home.mtt', Context, Config.filesPath);		
	}		
	
	public function homeDeltagare() {
		return new TemploResult('home-user.mtt', Context, Config.filesPath);
	}
	
	public function homeAdmin() {
		return new TemploResult('home-admin.mtt', Context, Config.filesPath);
	}	
	
	
}