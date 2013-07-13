package g2.db;
import sys.db.Connection;
import sys.db.Types;
import sys.db.Object;

/**
 * ...
 * @author Jonas Nyström
 */

class Order extends Object {
	public var id:SId;
	public var label:SString<24>;	
    public var userId:SString<13>;
	@:skip public var user(get,set):Gustavuser;
    @:skip var _user:Gustavuser = null;
    function get_user()    {
        #if server
            if (_user == null && userID != null)
                _user = Gustavuser.manager.get(userId);
        #end
        return _user;
    }
    function set_user(v:Gustavuser) {
        _user = v;
        if (v == null) throw "user:User cannot be null";
        userId = v.id;
        return _user;
    }		
}