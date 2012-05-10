package smd.server.base;
import smd.server.base.auth.AuthUser;
import smd.server.base.types.Messages;

/**
 * ...
 * @author Jonas Nyström
 */

class SiteState 
{

	static public var messages:Messages = {
		errors: [],
		infos: [],
		systems: [],
	}
	
	static public var user:AuthUser = null;	
	
}