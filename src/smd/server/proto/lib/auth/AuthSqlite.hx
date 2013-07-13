package smd.server.proto.lib.auth;
import smd.server.proto.lib.ScorxDBTools;
import smd.server.proto.lib.db.DBUser;
import smd.server.proto.lib.user.User;
import sys.db.Connection;

/**
 * ...
 * @author Jonas Nyström
 */

class AuthSqlite implements IAuthCheck
{
	var cnx:Connection;
	public function new(cnx:Connection) 
	{
		this.cnx = cnx;
	}	
	
	
	public function loginFailHandler(user:String, pass:String):Void 
	{
		trace('AuthSqlite loginFailHandler');
	}
	
	public function validUserHandler(user:String, pass:String):Bool 
	{
		trace('AuthSqlite validUserHandler' + user + ' ' + pass);
		var users = DBUser.manager.search( { user:user, pass:pass } );
		if (users.length != 1) return false;
		return true;
		
	}
	
	public function getUserHandler(user:String, pass:String):User 
	{
		trace('AuthSqlite getUserHandler' + user + ' ' + pass);
		var users = DBUser.manager.search( { user:user, pass:pass } );				
		if (users.length != 1) throw "ERROR getUserHandler";
		var user = users.first().toTUser();
		return user;
	}
}