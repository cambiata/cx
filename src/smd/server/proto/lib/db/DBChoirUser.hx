package smd.server.proto.lib.db;
import cx.EnumTools;
import sys.db.Connection;
import sys.db.Object;
import sys.db.Types;
import sys.db.TableCreate;

/**
 * ...
 * @author Jonas Nyström
 */

@:table('choir_user')
@:id(user, choir, role)
class DBChoirUser extends Object
{
	@:relation(user, cascade) public var user: DBUser;
	@:relation(choir, cascade) public var choir	: DBChoir;	
	private var role:SString<24>;
	
	
	public function setRole(role:EChoirRole) {
		this.role = Std.string(role);
	}
	
	public function getRole():EChoirRole {
		return EnumTools.createFromString(EChoirRole, this.role);
	}
	
	
}