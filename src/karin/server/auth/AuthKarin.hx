package karin.server.auth;
import g2.db.Gustavuser;
import smd.server.proto.lib.auth.IAuthCheck;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;

/**
 * ...
 * @author Jonas Nyström
 */
class AuthKarin implements IAuthCheck
{
	
	public function new(g2usersFile:String) 
	{
		var cnx = sys.db.Sqlite.open(g2usersFile);
		sys.db.Manager.cnx = cnx;
		sys.db.Manager.initialize();
	}	
	
	
	public function loginFailHandler(user:String, pass:String):Void 
	{
		trace('AuthSqlite loginFailHandler');
	}
	
	public function validUserHandler(user:String, pass:String):Bool 
	{
		
		var gustavusers = Gustavuser.manager.search( { email:user, last4:pass } );		
		if (gustavusers.length != 1) return false;
		return true;
	}
	
	public function getUserHandler(user:String, pass:String):User 
	{
		
		var gustavusers = Gustavuser.manager.search( { email:user, last4:pass } );			
		if (gustavusers.length != 1) throw "ERROR getUserHandler";
		
		
		var gustavuser = gustavusers.first();	
		var user:User = {
			id: Std.string(gustavuser.id),
			firstname: Std.string(gustavuser.firstname),
			lastname: Std.string(gustavuser.lastname),
			user: Std.string(gustavuser.email),
			category:UserCategory.Deltagare,
			pass: Std.string(gustavuser.last4),
		}		
		
		return user;
	}
	
}