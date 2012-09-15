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
		var sessionDir = Config.filesDir + 'sessions/';		
		//var auth = new AuthSqlite(Config.authSqliteFile, Config.loginSqliteFile);
		var auth = new AuthFile(Config.authFile, Config.loginFile);
		
		NekoSession.setSavePath(sessionDir);		
		NekoSession.domain = '.' + WebTools.getDomainInfo().mainTop;
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
					
					authUser.logins = auth.checkLogin(authUser);
					
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

		function redirectTo(uri:String) {
			var url = 'http://' + uri;		
			Web.redirect(url);
		}		
		
		
		if (Web.getParams().get('editpage') == Config.secretKey) return;
		
		var currentDomain = WebTools.getHostName();
		var top = WebTools.getDomainInfo().topdomain;			
		var domain = Config.homedomain; // WebTools.domainparts(Config.homedomain).maindomain;
		var redirect = '';
		
		if (User.user == null) {
			if (currentDomain != Config.homedomain) redirect = domain;						
		} else if (!User.user.success) {
			if (currentDomain != Config.homedomain) redirect = domain;						
		} else if (User.user.success) {
		
			switch (user.role) {				
				case 
				'Deltagare-KSU',
				'Korledare-KSU',
				'Deltagare-RKK',
				'Administratör',
				'Kantorsstuderande'				
				: domain = 'korakademin.scorx';								
				case 'Sensus30': domain = 'sensus.scorx';
				case 'Projekt-Vivaldi': domain = 'projekt.scorx';				
				default : domain = 'scorx';
			}
		
			var page = '';
			
			if (domain ==  'korakademin.scorx' && user.logins < 1) {
				page = '/dok/kurs/first';				
			}
			
			if (WebTools.getDomainInfo().subMain != domain) {
				redirect = domain + '.' + top + page;
			}
			
			//State.messages.infos.push(WebTools.getDomainInfo().subMain + ' ' + domain );
			//if (currentDomain != domain) redirect = domain + '.' + top + page;		
			//if (currentDomain != domain
		}

		//State.messages.infos.push(WebTools.getDomainInfo().subMain + ' ' + currentDomain + ' ' + domain + '  redirect:' + redirect);
		
		if (redirect != '') redirectTo(redirect);
		
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


