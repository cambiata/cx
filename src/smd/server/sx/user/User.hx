package smd.server.sx.user;
import cx.WebTools;
import neko.Web;
import smd.server.base.auth.AuthUser;
import cx.neko.NekoSession;
import smd.server.sx.State;
/**
 * ...
 * @author Jonas Nyström
 */

class User 
{
	static public var user:AuthUser;
	
	static public function getCurrentUser() :AuthUser{
		
		var authUser:AuthUser = getUserNull();
		var sessionDir = Web.getCwd() + Config.filesDir + 'sessions/';		
		var auth = new AuthDummy();		
		
		NekoSession.setSavePath(sessionDir);		
		NekoSession.domain = '.' + WebTools.getDomainInfo().maintop;
		
		// logga in eller logga ut...		
		
		if (Web.getMethod() == 'POST') {						
			var _user = Web.getParams().get('user');
			var _pass = Web.getParams().get('pass');
			var _useraction = Web.getParams().get('useraction');
			
			if (_useraction == 'logout') {					
				authUser = getUserNull();
				authUser.msg = 'Logged out';
				State.messages.infos.push('User logged out!');
			} else if (_useraction == 'login' && _user != '' && _pass != '') {				
				
				authUser = auth.check(_user, _pass);
				
				if (authUser.success) {					
					authUser.msg = 'Login ok';			
					authUser.pass = _pass;
					authUser.user = _user;
					State.messages.success.push('User logged in!');
				} else {
					authUser.msg = 'Login fail!';
					State.messages.errors.push('Login fail!');					
				}
			}
			
			NekoSession.set('authUser', authUser);
			NekoSession.close();			
		}		
		
		// Hämta användare från session...
		var loggedinUser = NekoSession.get('authUser');
		User.user = loggedinUser;
		
		return loggedinUser;		
	}
	
	static public function getUserNull():AuthUser {
		return {success:false, user:null, pass:null, msg:null, person:null, scorxids:[], scorxdirs:[], role:null};
	}	
	
	static public function checkRedirect() {
		
		if (User.user == null) return;
		
		if (User.user.success) {

			var currentDomain = WebTools.getDomainInfo().submain;
			var top = WebTools.getDomainInfo().topdomain;			
			
			var domain = '';
			if (user.user == 'kak') domain = 'korakademin.scorx';
			if (user.user == 'sensus') domain = 'sensus.scorx';
			
			if (currentDomain != domain) {				
				var url = 'http://' + domain + '.' + top;
				Web.redirect(url);
			}
		}
		
		if (!User.user.success) {
			var domain = WebTools.getDomainInfo().submain;
			var top = WebTools.getDomainInfo().topdomain;
			if (domain != 'scorx') {
				var url = 'http://scorx.' + top;
				Web.redirect(url);
			}			
		}
		
	}
}

import smd.server.base.auth.IAuth;
class AuthDummy implements IAuth {
	public function new() { }
	public function check(_user:String, _pass:String):AuthUser {
		var user:AuthUser = User.getUserNull();
		if (_user == 'kak' && _pass == 'kak') user.success = true;
		if (_user == 'sensus' && _pass == 'sensus') user.success = true;
		user.user = _user;
		user.pass = _pass;
		
		if (user.success) return user else return User.getUserNull();
		return user;
	}
}