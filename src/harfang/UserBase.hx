package harfang;
import sys.db.Manager.Manager;
import sys.db.Object;
import sys.db.Sqlite;
import sys.db.TableCreate;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

class User extends UserBase 
{
	public var firstname:SString<32>;
	public var lastname:SString<48>;
	
	public static function createAdmin() 
	{
		var u = new User();
		u.login	= "admin";
		u.pass	= "21232f297a57a5a743894a0e4a801fc3"; // MD5 for "admin"
		u.level	= 10;
		u.firstname = 'Admin';
		u.lastname = 'Admin';
		u.insert();				
	}
	
	public static function createJonas() 
	{
		var u = new User();
		u.login	= "jonasnys@gmail.com";
		u.pass	= "8b71ec74f8f0fc7a92d141e397dbedc5"; // MD5 for "cambiata"
		u.level	= 5;
		u.firstname = 'Jonas';
		u.lastname = 'Nyström';
		u.insert();				
	}		
	
	public static function createLillemor() 
	{
		var u = new User();
		u.login	= "Lillemor";
		u.pass	= "36d72c6a679b5992c42238425d2632cd"; // MD5 for "kak"
		u.level	= 5;
		u.firstname = 'Lillemor';
		u.lastname = 'Bodin Carlson';
		u.insert();				
	}		
	
	public static function createKakUser() 
	{
		var u = new User();
		u.login	= "deltagare";
		u.pass	= "d7d18cfb3a0d8293e2f5d94ea30e04d2"; // MD5 for "plus"
		u.level	= 5;
		u.firstname = 'Kursdeltagare';
		u.lastname = 'Körakademin';
		u.insert();				
	}		
	
	
}
 
class UserBase extends Object
{
	public var id		: SId;
	public var login	: SString<64>;
	public var pass		: SString<32>;
	public var level	: SInt;
			
	public function new() {
		super();
		level	= 0;
	}
	
	public static function createAdmin() 
	{
		var u = new User();
		u.login	= "admin";
		u.pass	= "21232f297a57a5a743894a0e4a801fc3"; // MD5 for "admin"
		u.level	= 10;
		u.insert();				
	}	
	
}
