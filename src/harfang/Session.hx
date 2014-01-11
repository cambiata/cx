package harfang;
import haxe.crypto.Md5;
import haxe.ds.StringMap.StringMap;
import haxe.web.Request;
import neko.Web;
import sys.db.Manager.Manager;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.db.Types;
import harfang.UserBase.User;
/**
 * ...
 * @author Jonas Nyström
 */
typedef Stamp = {
	public var date		: Float;
	public var uri		: String;
	public var params	: StringMap<String>;
}


class Session extends Object{
	
	public var id		: SId;
	public var sid		: SString<32>;
	public var ip		: SString<15>;
	@:relation( uid )
	public var user		: SNull<User>;
	public var lang		: SString<2>;
	public var ctx		: SNull<SData<Dynamic>>;
	public var history	: SData<Array<Stamp>>;
	
	public static function all( lock = true ) {
		var h	= new StringMap();
		for ( sess in manager.all( lock ) ) {
			h.set( sess.sid, sess );
		}
		return h;
	}
	
	public static function commit( session : Session ) {
		//trace(session.user);
		if ( session.id != null ) {
			session.update();
		}else {
			session.insert();
		}
	}
	
	public function new( sid : String ) {
		super();
		this.sid 	= sid;
		
		ip			= Web.getClientIP();
		history		= [];
		// needed to initialize default serialized data value "null"
		ctx			= null;
	}
}