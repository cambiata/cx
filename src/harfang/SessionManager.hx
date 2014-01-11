package harfang;
import harfang.UserBase.User;
import haxe.crypto.Md5;
import haxe.ds.StringMap.StringMap;
import haxe.web.Request;
import neko.Web;
import sys.db.Manager.Manager;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */
class SessionManager {
	
	public static var BASE_DIR			= Web.getCwd();
	public static var COOKIE_NAME		= "TEST";
	public static var DB_NAME			= BASE_DIR + "testdb.sqlite";
	public static var DEFAULT_LANG		= "fr";
	public static var SESSION_DELAY		= 3600;
	
	public static var sessions	: StringMap<Session>;
	public static var session	: Session;
	public static var ctx		: Dynamic;	
	
	static public function init(): Void {
		
		var debug = '';
		Manager.cnx	= Sqlite.open(DB_NAME);		
		Manager.initialize();		
		
		if (!TableCreate.exists(User.manager)) { TableCreate.create(User.manager); User.createAdmin(); User.createJonas(); User.createLillemor(); User.createKakUser(); };
		if (!TableCreate.exists(Session.manager)) TableCreate.create(Session.manager);		
		
		sessions = Session.all();		
		
		var sid	= Web.getCookies().get( COOKIE_NAME );
		debug += 'sid == $sid';
		if ( sid == null ) {
			
			sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
			session			= new Session( sid );
			session.lang	= DEFAULT_LANG;
			sessions.set( sid, session );
			debug += ('sid is now $sid');
		}else {
			session	= sessions.get( sid );
			if ( session == null ) {
				debug += ('session == null');
				sid	= Md5.encode( Std.string( Math.floor( Math.random() * 100000 ) ) );
				session			= new Session( sid );
				session.lang	= DEFAULT_LANG;
				sessions.set( sid, session );
			} else {
				debug += ('found session ' + session.lang + ' ' + session.history + ' ' + session.user);		
				
			}
		}
		
		Web.setCookie( COOKIE_NAME, sid, null, null, "/" );
		
		Session.commit( session );			
		
		//trace('<br/>' + debug);
		
	}
	
	static public function getUser(): User
	{
		return session.user;
	}
	
	static public function login(login:String, pass:String, redirectUrl:String = null):Bool 
	{
		var user = User.manager.select( $login == $login && $pass == $ { Md5.encode(pass) } );
		
		if ( user != null ) 
		{
			session.user	= user;			
			Session.commit(session);
			if (redirectUrl != null) Web.redirect(redirectUrl);
			return true;
		}		
        return false;		
	}
	
	static public function logout(redirectUrl:String = null): Void 
	{
		session.user = null;
		Session.commit(session);	
		if (redirectUrl != null) Web.redirect(redirectUrl);
	}
	
	
}