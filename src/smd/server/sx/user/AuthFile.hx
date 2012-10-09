package smd.server.sx.user;
import cx.FileTools;
import cx.StrTools;
import cx.TextfileDB;
import neko.io.File;
import neko.io.FileInput;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.IAuth;
import ka.tools.PersonTools;
import ka.types.Person;


/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class AuthFile implements IAuth
{
	private var filename:String;
	private var loginFilename:String;
	
	public function new(filename:String, loginFilename:String='') { 
		this.filename = filename;
		if (!FileTools.exists(this.filename)) throw "File for authorization doesn't exist";
		this.loginFilename = loginFilename;
	}	
	
	public function check(user_:String, pass_:String):AuthUser {	
		var authUser:AuthUser = User.getUserNull();
		
		var file:FileInput = null;
		try {			
			file = File.read(this.filename, false);			
		} catch (e:Dynamic) {
			return authUser;			
		}		
		
		
		try {
			while(true) {

				var line = file.readLine().trim();
				
				if (line.startsWith(user_)) {					
					
					var checkPass = line.split('|')[1];
					
					if (checkPass == pass_) {
						file.close();

						var p = PersonTools.getFromString(line);		
						
						authUser.success = true;
						authUser.person = p;
						authUser.role = p.roll;
						authUser.user = user_; 
						authUser.pass = p.xpass;						
						var scorxdirsStr = StrTools.afterLast(line, '|');
						
						//-----------------------------------------------------------------------------------------------------						
						var scorxdirs = scorxdirsStr.split(',');
						authUser.scorxdirs = scorxdirs;						
						//-----------------------------------------------------------------------------------------------------
						authUser.msg = 'Authentication success: User ' + p.epost + ' ok!';
						
						addLogin(authUser);
						authUser.logins = checkLogin(authUser);
						
						return authUser;				
						break;						
					} else {
						file.close();
						authUser.msg = 'Authentication fail: Wrong password for user ' + user_;
						return authUser;
					}
				}
				//trace(line);
			}
		} catch (e:Dynamic) {
			
		}	
		
		return authUser; // null
	}
	
	public function addLogin(authUser:AuthUser) : Int {
		if (authUser.user == null) return 0;
	
		
	
		var tdbFile = this.loginFilename + 'x';
		var tdb = new TextfileDB(tdbFile);
		
		var count = 0;
		
		if (tdb.exists(authUser.user)) {
			count = Std.parseInt(tdb.get(authUser.user));
			tdb.set(authUser.user, Std.string(count+1));
			return count;
			
		} else {
			tdb.set(authUser.user, '1');
		}
			
		
		
		
		/*
		var file:FileInput = null;
		if (!FileTools.exists(this.loginFilename)) {
			FileTools.putContent(this.loginFilename, '');
		}
		
		var count = 0;
		
		file = File.read(this.loginFilename, false);		
		try {
			while(true) {
				var line = file.readLine().trim();
				if (line.startsWith(authUser.user)) {					
					try {
						var content = FileTools.getContent(this.loginFilename);
						var count = Std.parseInt(line.split(':')[1]);
						count += 1;
						var contentBefore = content.substr(0, content.indexOf(line));
						var contentAfter = content.substr(content.indexOf(line) + line.length);
						var newLine = authUser.user + ':' + count;
						var newContent = contentBefore + contentAfter + newLine;
						//trace(newContent);
						FileTools.putContent(this.loginFilename, contentBefore + contentAfter + newLine);
						//trace('found');
						return count;
					} catch (e:Dynamic) {
					}
				} else {
				}
			}
		} catch (e:Dynamic) {
			//trace('user not found in logfile');
			//var file = File.write(this.loginFilename, false);
			//file.writeString(authUser.user + ':' + count++);
			var content = FileTools.getContent(this.loginFilename);
			var newLine = '\n' + authUser.user + ':' + 0;
			FileTools.putContent(this.loginFilename, content + newLine);
			return 0;
		}			
		*/
		
		return 0;
		
	}	
	
	public function checkLogin(authUser:AuthUser) : Int {
		if (authUser.user == null) return 0;
		
		var tdbFile = this.loginFilename + 'x';
		var tdb = new TextfileDB(tdbFile);
		
		var count = 0;
		
		if (tdb.exists(authUser.user)) {
			count = Std.parseInt(tdb.get(authUser.user));
			tdb.set(authUser.user, Std.string(count));
			return count;
			
		} else {
			tdb.set(authUser.user, '1');
		}
		
		/*
		
		var file:FileInput = null;
		if (!FileTools.exists(this.loginFilename)) {
			FileTools.putContent(this.loginFilename, '');
		}
		
		
		file = File.read(this.loginFilename, false);		
		try {
			while(true) {
				var line = file.readLine().trim();
				if (line.startsWith(authUser.user)) {					
					try {
						//var content = FileTools.getContent(this.loginFilename);
						var count = Std.parseInt(line.split(':')[1]);
						//count += 1;
						return count;
					} catch (e:Dynamic) {
					}
				} else {
				}
			}
		} catch (e:Dynamic) {
			var content = FileTools.getContent(this.loginFilename);
			var newLine = '\n' + authUser.user + ':' + count++;
			FileTools.putContent(this.loginFilename, content + newLine);
			return 0;
		}			
		*/
		
		return 0;
		
	}	
	
}