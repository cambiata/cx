package ka.db.tables;
import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author Jonas Nyström
 */

@:table("user")
@:index(id,unique)
class DBUser extends Object {
	public var id			: SString<13>;
	public var firstname	: SString<32>;
	public var lastname		: SString<32>;
	public var user			: SString<32>;
	public var pass			: SString<16>;
	public var email		: SString<48>;
}
