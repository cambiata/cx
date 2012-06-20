package smd.server.base.auth;
import ka.types.Person;

/**
 * ...
 * @author Jonas Nyström
 */

typedef AuthUser = {
	success:Bool,
	user:String,
	pass:String,
	msg:String,	
	person:Person,
	scorxids:Array<Int>,
	scorxdirs:Array<String>,
	role:String,
}

