package smd.server.base.types;
import smd.server.base.auth.AuthUser;
import smd.server.base.types.Messages;
/**
 * ...
 * @author Jonas Nyström
 */
typedef PageData = {
	title:String,
	user:AuthUser,	
	menu:String,
	sidebar:String,
	content:String,
	messages:Messages,
}
