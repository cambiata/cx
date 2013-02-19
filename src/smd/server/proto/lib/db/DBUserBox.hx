package smd.server.proto.lib.db;
import smd.server.sx.data.ScorxData;
import sys.db.Object;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("userbox")
@:id(uid, bid)
class DBUserBox extends Object
{
	@:relation(uid) public var user	: DBUser;
	@:relation(bid) public var box	: DBBox;
	public var info			: SText;
	public var start		: SDate;
	public var stop			: SDate;
	public var activation	: SDateTime;
	
	public function toTUserBox():TUserBox {
		return {
			user: this.user.toTUser(),
			box: this.box.toTBox(),
			info: this.info,
			start: this.start,
			stop: this.stop,
			activation: this.activation,
		}
	}
	
	static public function createTable(cnx:sys.db.Connection) {
		if (!sys.db.TableCreate.exists(DBUserBox.manager)) sys.db.TableCreate.create(DBUser.manager);
	}	
	
}