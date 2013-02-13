package smd.server.proto.lib.auth;
import smd.server.proto.lib.user.User;

/**
 * ...
 * @author Jonas Nyström
 */

interface IAuthCheck 
{
	public function loginFailHandler(user:String, pass:String):Void;
	public function validUserHandler(user:String, pass:String):Bool;
	public function getUserHandler(user:String, pass:String):User ;
}