package smd.server.base.auth;
import ka.types.Person;

/**
 * ...
 * @author Jonas Nyström
 */

interface IAuth 
{
	function check(user:String, pass:String):AuthResult ;
}