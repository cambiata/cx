package ka.db.tables;
import sys.db.Object;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("gustavuser")
class DBGustavUser extends Object {
	public var id				: SString<13>;
	public var firstname		: SString<32>;
	public var lastname			: SString<32>;
	public var email			: SString<48>;
	public var pass				: SString<4>;
	public var korledare		: SString<48>;
	public var korledare_email 	: SString<48>;
}
