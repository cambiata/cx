package smd.server.sx.user;
import cx.WebTools;
import neko.Web;
import smd.server.base.auth.AuthUser;
import cx.neko.NekoSession;
import smd.server.sx.State;
import smd.server.sx.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class User 
{

	static public var user:AuthUser;
	
	static public function getCurrentUser() :AuthUser {
		
		var authUser:AuthUser = getUserNull();
		var sessionDir = Web.getCwd() + Config.filesDir + 'sessions/';		
		var auth = new AuthSqlite(Web.getCwd() + Config.filesDir + Config.authSqliteFile, Web.getCwd() + Config.filesDir + Config.loginSqliteFile);
		
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
		return {success:false, user:null, pass:null, msg:null, person:null, scorxids:[], scorxdirs:[], role:null, logins:0};
	}


	static public function checkRedirect() {

		if (User.user == null) return;
		
		if (Web.getParams().get('editpage') == Config.secretKey) return;
		
		if (User.user.success) {
			
			var currentDomain = WebTools.getDomainInfo().submain;
			var top = WebTools.getDomainInfo().topdomain;			
			var domain = Config.homedomain;
			
			if (user.user == 'kak') domain = 'korakademin.scorx';
			if (user.user == 'sensus') domain = 'sensus.scorx';
			if (user.user == 'projekt' && user.pass == 'vivaldi') domain = 'projekt.scorx';
			
			if (user.role == 'Deltagare-KSU') domain = 'korakademin.scorx';
			if (user.role == 'Korledare-KSU') domain = 'korakademin.scorx';
			if (user.role == 'Deltagare-RKK') domain = 'korakademin.scorx';
			if (user.role == 'Administratör') domain = 'korakademin.scorx';
			if (user.role == 'Kantorsstuderande') domain = 'korakademin.scorx';
			if (user.role == 'Kantorsstuderande') domain = 'korakademin.scorx';
			
			if (user.role == 'Sensus30') domain = 'sensus.scorx';
			if (user.role == 'Projekt-Vivaldi') domain = 'projekt.scorx';
			
			var page = '';
			
			if (domain ==  'korakademin.scorx' && user.logins < 2) {
				page = '/firstlogin';				
			}
			
			if (currentDomain != domain) {				
				var url = 'http://' + domain + '.' + top + page;
				Web.redirect(url);
			}
			
		}
		
		if (!User.user.success) {
			var domain = WebTools.getDomainInfo().submain;
			var top = WebTools.getDomainInfo().topdomain;
			if (domain != 'scorx') {
				//var url = 'http://scorx.' + top
				var url = 'http://' + Config.homedomain;				
				Web.redirect(url);
			}			
		}
	}


	static public function updateUserdata() {		
		
		var updateaccess = (Web.getParams().get('access') == Config.secretKey);

		if (!updateaccess) return;
		
		try {
			Access.saveAuthInfoToSqlite(Web.getCwd() + Config.filesDir + Config.authSqliteFile);
			State.messages.success.push('User database updated!');
		} catch (e:Dynamic) {
			State.messages.errors.push('Problem updating user database: ' + Std.string(e));
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
		if (_user == 'projekt' && _pass == 'vivaldi') user.success = true;
		user.user = _user;
		user.pass = _pass;
		
		if (user.success) return user else return User.getUserNull();
		return user;
	}
}


