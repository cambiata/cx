package ka.db;
import cx.Sys;
import sys.db.Connection;
import ka.db.tables.DBUser;
import ka.db.tables.DBOrder;
import ka.db.tables.DBGustavUser;
import sys.db.TableCreate;
import sys.db.Sqlite;
/**
 * ...
 * @author Jonas Nyström
 */

class DBTools 
{
	public function new() 
	{
		
	}
	
	static public function getCnx(filename:String) {
		return Sqlite.open(filename);
	}
	
	static public function deleteTables(cnx:Connection) {
		trace('delete');
		try { cnx.request('DROP TABLE "main"."user"'); } catch (e:Dynamic) { trace(Std.string(e)); }
		try { cnx.request('DROP TABLE "main"."order"');} catch (e:Dynamic) { trace(Std.string(e)); }
		try { cnx.request('DROP TABLE "main"."gustavuser"');} catch (e:Dynamic) { trace(Std.string(e)); }
	}
	
	static public function createTables(cnx:Connection) {
		sys.db.Manager.cnx = cnx;				
		
		if (!TableCreate.exists(DBUser.manager)) {
			TableCreate.create(DBUser.manager);			
			cnx.request('CREATE UNIQUE INDEX "userpass" ON "user" ("user" ASC, "pass" ASC)');
		}
		
		if (!TableCreate.exists(DBOrder.manager)) {
			TableCreate.create(DBOrder.manager);				
		}
		
		if (!TableCreate.exists(DBGustavUser.manager)) {
			TableCreate.create(DBGustavUser.manager);				
		}
		
		sys.db.Manager.initialize();			
	}
	
	static public function createDefaultData(cnx:Connection) {
		sys.db.Manager.cnx = cnx;	
		sys.db.Manager.initialize();		
		
		var user = new DBUser();
		user.id = '19661222-8616';
		user.firstname = 'Jonas';
		user.lastname = 'Nyström';
		user.email = 'jonasnys@gmail.com';
		user.user = 'jon';
		user.pass = 'abc';		
		user.insert();				
		
		var order = new DBOrder();
		order.user = user;
		order.ordername = 'Testorder for ' + user.firstname + ' ' + user.lastname;
		order.orderdate = Date.now();
		order.insert();
		
		var guser = new DBGustavUser();
		guser.firstname = 'Jonas';
		guser.lastname = 'Nyström';
		guser.email = 'jonasnys@gmail.com';
		guser.id = '19661222-8616';
		guser.pass = '8616';
		guser.korledare = 'Nisse Körsvängen';
		guser.korledare_email = 'nisse@korsvangen.com';
		guser.insert();
		
		
	}

	
}