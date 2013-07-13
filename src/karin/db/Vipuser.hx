package karin.db;
import cx3.ConfigTools;
import g2.GUser;
import karin.db.DB;
import sys.db.Connection;
import sys.db.Sqlite;
import sys.db.Manager;
import sys.db.Types;
import sys.db.Object;
import sys.db.TableCreate;
import karin.Config;

/**
 * ...
 * @author Jonas Nyström
 */
class Vipuser extends Object
{
	public var id: SString<13>;
	public var firstname: SString<32>;	
	public var lastname: SString<32>;
	public var email: SString<48>;
	public var last4: SString<4>;
	public var source: SString<1> = 'v';
	
	static public function deleteAll() {
		var sql = 'DELETE FROM "main"."Vipuser"';
		DB.cnx.request(sql);
	}
	
	static public function create() {
		if ( !TableCreate.exists(Vipuser.manager) )  TableCreate.create(Vipuser.manager);	
	}	
	
	/*
	static public function getFromGUser(user:GUser):Vipuser {
		var u = new Vipuser();
		u.id = user.id;
		u.lastname = user.lastname;
		u.firstname = user.firstname;
		u.email = user.email;
		u.last4 = user.last4;
		return u;
	}
	*/
	
	public function getGustavuser():Gustavuser
	{
		var guser = new Gustavuser();
		guser.id = this.id;
		guser.lastname = this.lastname;
		guser.firstname = this.firstname;
		guser.email = this.email;
		guser.last4 = this.last4;
		return guser;
	}
	
	static public function createVips() {
		var vuser = new Vipuser();
		vuser.firstname = 'Jonas';
		vuser.lastname = 'Nyström';
		vuser.email = 'jon';
		vuser.last4 = '123';
		vuser.id = '196612228616';
		vuser.insert();
		
		var vuser = new Vipuser();
		vuser.firstname = 'Karin';
		vuser.lastname = 'Sensusson';
		vuser.email = 'karin';
		vuser.last4 = 'test';
		vuser.id = '199912312222';
		vuser.insert();		
	}
	
	/*
	static public function getVips() {		
		
		ConfigTools.loadConfig(Config, Config.configFile);
		var dbFile = Config.filesPath + Config.vipusersDbFile;		
		var cnx = Sqlite.open(dbFile);
		Manager.cnx = cnx;		
		var vipusers = Vipuser.manager.all();
		return vipusers;
	}
	*/
	
}