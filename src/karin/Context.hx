package karin;
import haxe.Serializer;
import smd.server.proto.lib.user.User;

/**
 * ...
 * @author Jonas Nyström
 */
class Context
{
	static public var user:User;	
	static public var userSerialized:String;
	
	static public function setUser(_user:User) {
		user = _user;
		userSerialized = Serializer.run(_user);
	}
}