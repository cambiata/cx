package smd.server.sx.user;
import cx.FileTools;
import cx.SqliteTools;
import ka.tools.PersonTools;
import ka.types.Person;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.IAuth;

/**
 * ...
 * @author Jonas Nyström
 */

class AuthSqlite implements IAuth {
	
	private var filename:String;
	private var loginFilename:String;
	
	public function new(filename:String, loginFilename:String='') { 
		this.filename = filename;
		this.loginFilename = loginFilename;
	}
	
	public function check(user_:String, pass_:String):AuthUser {
		var sql = "select * from personer where (epost = '" + user_ + "' and xpass = '" + pass_ + "')";
		var results = SqliteTools.select(this.filename, sql);
		var authUser:AuthUser = { success:false, user:null, pass:null, msg:null, person:null, scorxids:[], scorxdirs:[], role:null, logins:0 };
		var personData = results.first();
		if (personData != null) {
			var person:Person = PersonTools.getPersonNull();
			person.fornamn = personData.fornamn;
			person.efternamn = personData.efternamn; 
			person.personnr = personData.personnr;
			person.kor = personData.kor;
			person.roll = personData.roll;
			authUser.success = true;
			authUser.pass = personData.xpass;
			authUser.user = personData.epost;
			authUser.person = person;
			authUser.role = personData.roll;
			authUser.scorxdirs = personData.scorxtillg.split(',');			
			authUser.logins = addLogin(authUser, this.loginFilename);			
		}
		return authUser;
	}
	
	public function addLogin(authUser:AuthUser, loginFilename:String) : Int {
		
		if (!FileTools.exists(loginFilename)) throw ('Login sqlite file does not exist! ' + loginFilename);

		var sql = 'select * from "logins" where user = "' + authUser.user + '"';
		var result = SqliteTools.select(loginFilename, sql);
		var count = result.length;

		var datetime:Date = Date.now();
		var insertObj = { user:authUser.user, datetime:Std.string(datetime) };
		var sql = SqliteTools.getInsertStatement(insertObj, 'logins');
		var insert = SqliteTools.insert(loginFilename, sql);
		
		return count;
		
	}
	
}

typedef TLogin = {
	user:String,
	datetime:Date,
}