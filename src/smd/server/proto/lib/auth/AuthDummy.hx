package smd.server.proto.lib.auth;
import harfang.exception.Exception;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;

/**
 * ...
 * @author Jonas Nyström
 */

class AuthDummy implements IAuthCheck
{

	public function new() 
	{
		
	}
	
	public function loginFailHandler(user:String, pass:String):Void {
		trace('CUSTOM loginFailHandler');		
	}
	public function validUserHandler(user:String, pass:String):Bool {
		trace('CUSTOM validUserHandler');
		if (user == 'jon' && pass == '123') return true;
		if (user == 'anna' && pass == 'a') return true;
		return false;		
	}
	public function getUserHandler(user:String, pass:String):User {
		trace('CUSTOM getUserHandler');
		if (user == 'jon') return {
			id:				'19661222-8616',
			firstname:		'Jonas',
			lastname:		'Nyström',
			category:		UserCategory.Deltagare,
			user:			user,
			pass:			pass,
		}
		
		if (user == 'anna') return {
			id:				'11111111-1111',
			firstname:		'Anna',
			lastname:		'Andersson',
			category:		UserCategory.Deltagare,
			user:			user,
			pass:			pass,
		}		
		
		throw new Exception('Did not find user in custom getUserHandler. This should not happen!');
		return null;		
	}
	
}