package smd.server.proto.lib.db;
import cx.EnumTools;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.UserCategory;
import sys.db.Object;
import sys.db.TableCreate;
import sys.db.Types;


/**
 * ...
 * @author Jonas Nyström
 */
@:table("user")
@:index(user,pass, unique)
class DBUser extends Object
{
	public var id				: SString<13>;
	private var category		: SString<24>;
	public var firstname		: SString<24>;
	public var lastname			: SString<32>;
	public var user				: SString<64>;
	public var pass				: SString<24>;
	
	
	public function getCategory():UserCategory {
		return EnumTools.createFromString(UserCategory, this.category);
	}
	
	public function setCategory(category:UserCategory) {
		this.category = Std.string(category);
	}
	
	public function toTUser():User {
		return {
			id: this.id,
			firstname: this.firstname,
			lastname: this.lastname,
			user: this.user,
			pass: this.pass,
			category: getCategory(),
		}
	}	
	
	/*
	static public function createTable(cnx:sys.db.Connection) {
		if (!TableCreate.exists(DBUser.manager)) TableCreate.create(DBUser.manager);
	}
	*/
	
}


/*

		var user = new DBUser();
		user.id = '11111111-1111';
		user.firstname = 'Jonas';
		user.lastname = 'Nyström';
		user.user = 'jon';
		user.pass = '123';
		user.setCategory(UserCategory.Deltagare);
		user.insert();
		
		var user = new DBUser();
		user.id = '11111111-1111';
		user.firstname = 'Adam';
		user.lastname = 'Andersson';
		user.user = 'a';
		user.pass = 'a';
		user.setCategory(UserCategory.Deltagare);
		user.insert();

		var user = new DBUser();
		user.id = '22222222-2222';
		user.firstname = 'Beda';
		user.lastname = 'Bengtsson';
		user.user = 'b';
		user.pass = 'b';
		user.setCategory(UserCategory.Deltagare);
		user.insert();
	
		var user = new DBUser();
		user.id = '33333333-3333';
		user.firstname = 'Cecilia';
		user.lastname = 'Cyndén';
		user.user = 'c';
		user.pass = 'c';
		user.setCategory(UserCategory.Deltagare);
		user.insert();		

		
*/