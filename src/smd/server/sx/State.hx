package smd.server.sx;

//import smd.server.base.auth.AuthUser;
import cx.WebTools;
import smd.server.base.auth.AuthUser;
import smd.server.base.types.Messages;

/**
 * ...
 * @author Jonas Nyström
 */

class State 
{	
	
	static public var indexPage: String = WebTools.getDomainInfo().submain + '.html';
	
	static public var messages:Messages = {
		errors: [],
		success: [],
		infos: [],
		systems: [],
	}
	
	//static public var user:AuthUser = null;	
	
}