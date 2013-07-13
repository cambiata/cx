package karin.db;
import cx3.ConfigTools;
import cx3.FileTools;
import g2.GUser;
import gustav.Config;
import karin.db.DB;
import karin.tools.UserTools;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;
import sys.db.Connection;
import sys.db.Types;
import sys.db.Object;
import sys.db.TableCreate;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
class Gustavuser extends Object
{
	public var id: SString<13>;
	public var firstname: SString<32>;	
	public var lastname: SString<32>;
	public var email: SString<48>;
	public var last4: SString<4>;
	public var source: SString<1> = 'g';
	
	static public function create() {
		if ( !TableCreate.exists(Gustavuser.manager) )  TableCreate.create(Gustavuser.manager);	
	}
	
	static public function deleteAll() {		
		var sql = 'DELETE FROM "main"."Gustavuser"';
		DB.cnx.request(sql);
	}
	
	static public function getFromGUser(user:GUser):Gustavuser {
		var u = new Gustavuser();
		u.id = user.id;
		u.lastname = user.lastname;
		u.firstname = user.firstname;
		u.email = user.email.toLowerCase();
		u.last4 = user.last4.toLowerCase();
		return u;
	}
	
	static public function addVipusers(sqlFile:String) {
		
		//var dbFile = Config.filesPath + Config.vipusersSql;		
		var sqls = FileTools.getContent(sqlFile).split(';');
		for (sql in sqls) {
			if (sql.trim() == '') continue;
			DB.cnx.request(sql);
		}
	}
	
	public function toUser():User {
		var u:User = {
			id: 				UserTools.peronnrToId(this.id),
			firstname:			this.firstname,
			lastname:			this.lastname,
			pass: 				this.last4.toLowerCase(),
			category: 			(this.source == 'v') ? Std.string(UserCategory.Admin) : Std.string(UserCategory.Deltagare),
			user:				this.email.toLowerCase(),
		}
		return u;
	}
	
}