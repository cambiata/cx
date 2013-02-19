package smd.server.proto.lib.db;
import cx.Sys;
import sys.db.Connection;
import sys.db.Object;
import sys.db.TableCreate;
import sys.db.Types;

/**
 * ...
 * @author Jonas Nyström
 */

@:table('choir')
class DBChoir extends Object
{
	public var id:SId;
	public var name:SString<32>;
	public var ort:SString<32>;
	public var info:SText;
	public var lan:SString<2>;
	
	static public function createTable(cnx:Connection) {
		if (!TableCreate.exists(DBChoir.manager)) TableCreate.create(DBChoir.manager);
	}
}