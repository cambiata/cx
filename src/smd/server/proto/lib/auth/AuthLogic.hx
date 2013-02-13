package smd.server.proto.lib.auth;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;
import haxe.Session;
import neko.Web;
/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class AuthLogic 
{
	public var currentUser:User;
	
	private var authCheck:IAuthCheck;
	
	public function new(authCheck_:IAuthCheck) {
		this.authCheck = authCheck_;		
		Session.savePath = Config.filesPath + 'sessions/';
		Session.gcMaxLifeTime = 10;
		Session.start();		
		
		var loginAttempt = Web.getParams().get('login');
		switch (loginAttempt) {
			case 'login': loginUser(Web.getParams().get('user').trim(), Web.getParams().get('pass').trim());
			case 'logout': logoutUser();
			case 'check': getUserSession();
			default:
		}				
		this.currentUser = getUserSession();
		Session.close();
	}
	
	//-----------------------------------------------------------------------
	
	private function getUserSession():User {
		var user = Session.get('user');
		return user;
	}
	
	private function setUserSession(user:User) {
		Session.set('user', user);
	}
	
	private function removeUserSession() {
		Session.remove('user');
	}		
	
	public function loginUser(user:String, pass:String) {
		if (user == null) throw 'Login error: user is NULL';
		if (pass == null) throw 'Login error: pser is NULL';
		if (authCheck.validUserHandler(user, pass)) {
			setUserSession(authCheck.getUserHandler(user, pass));
		} else {
			authCheck.loginFailHandler(user, pass);
			logoutUser();			
		}
	}
	
	public function logoutUser() {
		removeUserSession();
	}		
	
	
}