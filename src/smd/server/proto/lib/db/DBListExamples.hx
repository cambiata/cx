package smd.server.proto.lib.db;
import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author Jonas Nyström
 */

@:table("listexamples")
@:index(id,unique)
class DBListExamples extends Object {
	public var id			: SInt;
	public var info			: SString<48>;
	public var data			: SText;
}