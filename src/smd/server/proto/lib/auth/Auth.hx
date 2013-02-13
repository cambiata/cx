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
class Auth
{
	static public var currentUser:User; 
	
	static public function check (authCheck:IAuthCheck=null) {		
		if (authCheck == null) authCheck = new AuthDummy();
		
		loginFailHandler 	=  authCheck.loginFailHandler;
		validUserHandler 	=  authCheck.validUserHandler;
		getUserHandler 		=  authCheck.getUserHandler;
		
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
		
		currentUser = getUserSession();
		
		Session.close();
		
		return currentUser;
	}
	
	//--------------------------------------------------------------------------

	static private var loginFailHandler: String -> String -> Void;
	static private var validUserHandler: String -> String -> Bool;
	static private var getUserHandler: String -> String -> User;
	
	//--------------------------------------------------------------------------
	
	static public function defaultGetUserHandler(user:String, pass:String): User {		
		trace('DEFAULT GetUserHandler: ' + user + ' ' + pass);
		var user:User = {
			id:				'19800520-1234',
			firstname:		'Anna',
			lastname:		'Andresson',
			category:		UserCategory.Deltagare,
			user:			user,
			pass:			pass,
		}
		return user;
	}
	
	static public function defaultValidUserHandler(user:String, pass:String):Bool {		
		trace('DEFAULT ValidUserHandler: ' + user + ' ' + pass);
		if (user == 'jon' && pass == '123') return true;
		return false;
	}	
	
	static public function defaultLoginFailHandler(user:String, pass:String) {	
		trace('DEFAULT LoginFailHandler: ' + user + ' ' + pass);
	}
	
	//-----------------------------------------------------------------------
	
	static private function getUserSession():User {
		var user = Session.get('user');
		return user;
	}
	
	static private function setUserSession(user:User) {
		Session.set('user', user);
	}
	
	static private function removeUserSession() {
		Session.remove('user');
	}		
	
	static public function loginUser(user:String, pass:String) {
		if (user == null) throw 'Login error: user is NULL';
		if (pass == null) throw 'Login error: pass is NULL';
		if (validUserHandler(user, pass)) {
			setUserSession(getUserHandler(user, pass));
		} else {
			loginFailHandler(user, pass);
			logoutUser();			
		}
	}
	
	static public function logoutUser() {
		removeUserSession();
	}	

}

