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
	/*
	@URL("^/mail/([0-9a-zA-Z@._]+)")
	public function mail(to:String) { 
		
		//var to = 'jonasnys@gmail.com';
		//trace(to);
		if (! ValidationTools.isValidEmail(to)) throw new Exception('Invalid email: ' + to);
		
		var from = 'info@scorx.org';		
		var p = new Part("multipart/alternative");
		p.setHeader("From",from);
		p.setHeader("To",to);
		p.setDate();
		p.setHeader("Subject","A Haxe e-mail !");
		var h = p.newPart("text/html");
		var t = p.newPart("text/plain");
		h.setContent("<html><p>some html ...</p></html>");
		t.setContent("some plain text...");

		try {
			Smtp.send( "scorx.org", from, to, p.get() );		
		} catch (e:Dynamic) {
			throw new Exception('SMPT Connection error');
		}		
	}
	*/

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
		
	
	
	@URL("^/$")
	public function home() { 	
		if (Context.user == null) return new TemploResult('start.mtt', Context, Config.filesPath);
		return new TemploResult('home-user.mtt', Context, Config.filesPath);
	}		
	
	
}