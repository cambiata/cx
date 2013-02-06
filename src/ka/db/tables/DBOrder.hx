package ka.db.tables;
import sys.db.Object;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("order")
class DBOrder extends Object {
	public var id : SId;
	@:relation(uid, cascade) public var user : DBUser;
	public var ordername: SString<32>;
	public var orderdate: SDate;
}