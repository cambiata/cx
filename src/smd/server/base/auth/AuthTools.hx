package smd.server.base.auth;
import haxe.Firebug;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.IAuth;
import cx.neko.NekoSession;
import cx.Web;
import smd.server.base.SiteState;
import smd.server.ka.auth.KaAuth;
import smd.server.ka.config.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class AuthTools {	
	
	static public function getCurrentUser(auth:IAuth, sessionDir:String):AuthUser {
		var authUser:AuthUser = getUserNull();
		
		NekoSession.setSavePath(sessionDir);		
		//NekoSession.setSavePath(neko.Web.getCwd() + 'session/');		
		
		// logga in eller logga ut...
		if (Web.getMethod() == 'POST') {						
			var user = Web.getParams().get('user');
			var pass = Web.getParams().get('pass');
			
			if (user == 'logout') {					
				authUser = getUserNull();
				authUser.msg = 'Logged out';
				SiteState.messages.infos.push('User logged out!');
			} else if (user != '' && pass != '') {
				// try to log in...
				//var authResult:AuthResult = new KaAuth(Web.getCwd() + 'autentisering.dat').check(user, pass);
				//var authResult:AuthResult = auth.check(user, pass);
				authUser = auth.check(user, pass);
				//SiteState.messages.infos.push(Std.string(authResult));
				if (authUser.success) {					
					//if (true) {					
					//authUser.user = authResult.person.fornamn + ' ' + authResult.person.efternamn;
					//authUser.pass = authResult.person.xpass;
					//authUser.role = authResult.person.roll;
					//authUser.person = authResult.person;
					//authUser.scorxdirs = authResult.person.
					//authUser.scorxdirs = 
					authUser.msg = 'Login ok';
					SiteState.messages.success.push('Login ok');
	
					/*
					NekoSession.set('authUser', authUser);
					NekoSession.close();			
					return authUser;
					*/
				} else {
					//authUser = getUserNull();
					authUser.msg = 'Login fail!';
					SiteState.messages.errors.push('Login fail!');
					/*
					NekoSession.set('authUser', authUser);
					NekoSession.close();			
					return authUser;										
					*/
				}
			}
			
			NekoSession.set('authUser', authUser);
			NekoSession.close();			
			//Firebug.trace(authUser);
			//return authUser;			
			
		}
		
		// Hämta användare från session...
		var loggedinUser = NekoSession.get('authUser');
		return loggedinUser;
	}
	
	static public function getUserAuth(user:String, pass:String):Bool {
		var authResult:AuthResult = new KaAuth(Config.authDir + Config.authFilename,  Config.scorxroot).check(user, pass);		
		return authResult.success;
	}
	
	static public function getUserNull():AuthUser {
		return {success:false, user:null, pass:null, msg:null, person:null, scorxids:[], scorxdirs:[], role:null};
	}
}