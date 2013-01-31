package smd.server.proto.tools;

//import cx.SqliteTools;
import neko.Lib;
import sys.db.SpodInfos;
import sys.db.Sqlite;
import sys.db.TableCreate;

/**
 * ...
 * @author Jonas Nyström
 */

class Main 
{

	static public function main() 
	{
		trace('tools');
		
		var cnx = Sqlite.open('test.sqlite');
		sys.db.Manager.cnx = cnx;		
		
		if (!TableCreate.exists(DBUser.manager)) {
			TableCreate.create(DBUser.manager);			
			cnx.request('CREATE UNIQUE INDEX "userpass" ON "user" ("user" ASC, "pass" ASC)');
		}
		
		if (!TableCreate.exists(DBOrder.manager)) TableCreate.create(DBOrder.manager);				
		
		
		sys.db.Manager.initialize();		
		
		/*
		var u = new DBUser();
		u.id = '19661222-8616';
		u.firstname = 'Jonas';
		u.lastname = 'Nyström';
		u.user = 'jon';
		u.pass = 'abc';		
		u.insert();				
		*/
		
		//var users = DBUser.manager.all();
		var user = DBUser.manager.all().first();
		//for (user in users) {
		trace(user.firstname);
		//}		
		
		var o = new DBOrder();
		o.user = user;
		o.ordername = "Test order";		
		o.orderdate = Date.now();
		o.insert();				
		
	}
	
}

import sys.db.Object;
import sys.db.Types;

/*
class User extends Object {
	public var id: SId;
	public var name: SString<32>;
}
*/
@:table("user")
@:index(user,pass,unique)
class DBUser extends Object {
	public var id			: SString<13>;
	public var firstname	: SString<32>;
	public var lastname		: SString<32>;
	public var user			: SString<32>;
	public var pass			: SString<16>;
	public var email		: SString<48>;
}

@:table("order")
class DBOrder extends Object {
	public var id : SId;
	@:relation(uid) public var user : DBUser;
	public var ordername: SString<32>;
	public var orderdate: SDate;
}


