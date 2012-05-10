package smd.server.base.auth;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.IAuth;
import cx.neko.NekoSession;
import cx.Web;
import smd.server.base.SiteState;
import smd.server.ka.auth.KaAuth;

/**
 * ...
 * @author Jonas Nyström
 */

class AuthTools {	
	
	static public function getCurrentUser(auth:IAuth):AuthUser {
		var loginUser:AuthUser = getUserNull();
		NekoSession.setSavePath(neko.Web.getCwd() + 'session/');		
		// logga in eller logga ut...
		if (Web.getMethod() == 'POST') {						
			var user = Web.getParams().get('user');
			var pass = Web.getParams().get('pass');
			
			if (user == 'logout') {					
				loginUser = getUserNull();
				loginUser.msg = 'Logged out';
				SiteState.messages.infos.push('User logged out!');
			} else if (user != '' && pass != '') {
				// try to log in...
				
				//var authResult:AuthResult = new KaAuth(Web.getCwd() + 'autentisering.dat').check(user, pass);
				
				var authResult:AuthResult = auth.check(user, pass);
				
				if (authResult.success) {					
					//if (true) {					
					loginUser.user = authResult.person.fornamn + ' ' + authResult.person.efternamn;
					loginUser.pass = authResult.person.xpass;
					loginUser.msg = 'Login ok';
					SiteState.messages.infos.push('Login ok');
					
				} else {
					loginUser = getUserNull();
					loginUser.msg = 'Login fail!';
					SiteState.messages.errors.push('Login fail!');
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
		var authResult:AuthResult = new KaAuth('autentisering.dat').check(user, pass);		
		return authResult.success;
	}
	
	static public function getUserNull():AuthUser {
		return {success:false, user:null, pass:null, msg:null, person:null};
	}
}