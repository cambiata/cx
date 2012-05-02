package smd.server.base.auth;
import ka.types.Person;

/**
 * ...
 * @author Jonas Nyström
 */

typedef AuthResult = {
	success:Bool,
	person:Person,
	msg:String,	
}