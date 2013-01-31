package smd.server.proto;
import haxe.Session;
import neko.Web;


/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class Users
{
	static public var currentUser:User; 
	
	static public function init(loginFailHandler_: String -> String -> Bool=null) {		
		loginFailHandler = loginFailHandler_;
		
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
	}
	
	static private var loginFailHandler: String -> String -> Bool;
	
	static public function loginUser(user:String, pass:String) {
		if (user == null) throw 'Login error: user is NULL';
		if (pass == null) throw 'Login error: pser is NULL';
		if (validUser(user, pass)) {
			//trace('LOGIN: ' + user + ' / ' + pass);						
			setUserSession(getUser(user, pass));
		} else {
			//trace('LOGIN FAIL');
			//trace(loginFailHandler);
			if (loginFailHandler != null) loginFailHandler(user, pass);
			logoutUser();			
		}

	}
	
	static public function logoutUser() {
		//trace('LOGOUT');
		removeUserSession();
	}
	
	static public function validUser(user:String, pass:String):Bool {		
		if (user == 'jon' && pass == '123') return true;
		return false;
	}
	
	static public function getUser(user:String, pass:String): User {
		
		var user:User = {
			id:				'19661222-8616',
			firstname:		'Jonas',
			lastname:		'Nyström',
			user:			user,
			pass:			pass,
		}
		return user;
	}
	
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
	
}

