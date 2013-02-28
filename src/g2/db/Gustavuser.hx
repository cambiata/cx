package g2.db;
import g2.GUser;
import sys.db.Connection;
import sys.db.Types;
import sys.db.Object;

/**
 * ...
 * @author Jonas Nyström
 */


class Gustavuser extends Object
{
	public var id: SString<13>;
	public var firstname: SString<32>;	
	public var lastname: SString<32>;
	public var email: SString<48>;
	public var last4: SString<4>;
	
	static public function deleteAll(cnx:Connection) {
		var sql = 'DELETE FROM "main"."Gustavuser"';
		cnx.request(sql);
	}
	
	static public function getFromGUser(user:GUser):Gustavuser {
		var u = new Gustavuser();
		u.id = user.id;
		u.lastname = user.lastname;
		u.firstname = user.firstname;
		u.email = user.email;
		u.last4 = user.last4;
		return u;
	}
	
}