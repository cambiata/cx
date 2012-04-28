package smd.server.ka.auth;
import ka.tools.PersonerTools;
import ka.tools.PersonTools;
import ka.types.Person;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.IAuth;
import haxe.io.Eof; 
/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;

class KaAuth implements IAuth {
	private var authFilename:String;
	public function new(authFilename:String) {
		this.authFilename = authFilename;
	}
	
	public function check(user:String, pass:String):AuthResult {		
		var ret:AuthResult = { person:null, msg:null };
		//var id = user + '|' + pass;
		//trace(id);
		var file = neko.io.File.read(this.authFilename, false);				
		try {
			while(true) {
				var line = file.readLine().trim();
				if (line.startsWith(user)) {					
					var checkPass = line.split('|')[1];
					if (checkPass == pass) {
						file.close();
						var p = PersonTools.getFromString(line);										
						ret.person = p;
						ret.msg = 'Authentication success: User ' + p.epost + ' ok!';
						return ret;				
						break;						
					} else {
						file.close();
						ret.msg = 'Authentication fail: Wrong password for user ' + user;
						return ret;
					}
				}
				trace(line);
			}
		} catch (e:Dynamic) {
			
		}
			
		file.close();	
		ret.msg = 'Authentication fail: User ' + user + ' not found!';
		return ret;
	}
	
	
}