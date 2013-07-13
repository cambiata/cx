package smd.server.proto;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserSub;

/**
 * ...
 * @author Jonas Nyström
 */

typedef ContextTransfer =
{
	userSub:UserSub,
}

class ContextTransferTool {
	
	static public var transferDataTag:String = '__CONTEXT_TRANSFER';
	
	static public function getTransfer(user:User):ContextTransfer {		
		
		//------------------------------
		var userSub:UserSub;		
		
		if (user != null) {
			userSub = {
				id : user.id,
				category : user.category,
				firstname : user.firstname,
				lastname : user.lastname,
				user : user.user,
			}
			
		} else {
			userSub = null;
		}
		
		//------------------------------
		var contextTransfer:ContextTransfer = {
			userSub: userSub,
		}
		return contextTransfer; 
		
		
		/*
		if (user == null) return null;
		return { user:user.user, firstname:user.firstname, lastname:user.lastname, category:user.category, id:user.id };
		*/
	}	
	
}

/*

typedef UserSub = {
	id:String,
	category:String,
	firstname:String,
	lastname:String,
	user:String,
}

*/