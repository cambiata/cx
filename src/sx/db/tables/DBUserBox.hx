package sx.db.tables;
import smd.server.sx.data.ScorxData;
import sys.db.Object;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("userbox")
@:id(userid, box)
class DBUserBox extends Object
{
	public var userid		: SString<13>;
	@:relation(box, cascade) public var box	: DBBox;
	public var info			: SText;
	public var start		: SDate;
	public var stop			: SDate;
	public var activation	: SDateTime;
	
	public function toTUserBox():TUserBox {
		return {
			userid: this.userid,
			box: this.box.toTBox(),
			info: this.info,
			start: this.start,
			stop: this.stop,
			activation: this.activation,
		}
	}
	
}