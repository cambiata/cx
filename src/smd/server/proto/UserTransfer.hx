package smd.server.proto;

/**
 * ...
 * @author Jonas Nyström
 */

typedef UserTransfer =
{
	id:String,
	user:String,
	firstname:String,
	lastname:String,
	category:String,	
}

class UserTransferTool {
	static public function getUserTansfer(user:User):UserTransfer {
		if (user == null) return null;
		return { user:user.user, firstname:user.firstname, lastname:user.lastname, category:user.category, id:user.id };
	}	
	
}