package smd.server.base.controller;
import cx.neko.NekoSession;
import cx.Web;
import harfang.controller.AbstractController;
import harfang.module.Module;

/**
 * ...
 * @author Jonas Nyström
 */

class UserController extends AbstractController {
	private var loginUser:LoginUser;
	
	override public function init(module:Module):Void {
		super.init(module);
		this.loginUser = UserTools.getCurrentUser();		
	}
	
}

class UserTools {	
	static public function getCurrentUser():LoginUser {
		var loginUser:LoginUser = getUserNull();
		NekoSession.setSavePath(Web.getCwd() + 'session/');

		// logga in eller logga ut...
		if (Web.getMethod() == 'POST') {			
			
			var user = Web.getParams().get('user');
			var pass = Web.getParams().get('pass');
			
			if (user == 'logout') {					
				loginUser = getUserNull();
				loginUser.msg = 'Logged out';
			} else if (user != '' && pass != '') {
				// try to log in...
				if (getUserAuth(user, pass)) {					
					loginUser.user = user;
					loginUser.pass = pass;
					loginUser.msg = 'Login ok';
				} else {
					loginUser = getUserNull();
					loginUser.msg = 'Login fail!';
				}
			}
			NekoSession.set('loginUser', loginUser);
			NekoSession.close();
			return loginUser;
		}
		
		// Hämta användare från session...
		var loggedinUser = NekoSession.get('loginUser');
		return loggedinUser;
	}
	
	static public function getUserAuth(user:String, pass:String):Bool {
		if (user != 'jonas') return false;
		if (pass != '1234') return false;
		return true;
	}
	
	static public function getUserNull():LoginUser {
		return {user:null, pass:null, msg:null};
	}
}


typedef LoginUser = {
	user:String,
	pass:String,	
	msg:String,
}