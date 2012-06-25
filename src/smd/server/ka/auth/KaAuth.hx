package smd.server.ka.auth;
import cx.Tools;
import haxe.Firebug;
import ka.tools.PersonerTools;
import ka.tools.PersonTools;
import ka.types.Person;
import neko.io.File;
import neko.io.FileInput;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.AuthTools;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.IAuth;
import haxe.io.Eof; 
import smd.server.base.SiteState;
//import smd.server.ka.config.Config;
import sx.util.ScorxTools;
/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;

class KaAuth implements IAuth {
	private var authFilename:String;
	private var scorxroot:String;
	public function new(authFilename:String, scorxroot:String) {
		this.authFilename = authFilename;
		this.scorxroot = scorxroot;
	}
	
	public function check(user:String, pass:String):AuthUser {		
		var authUser:AuthUser = AuthTools.getUserNull();
		
		var file:FileInput = null;
		try {
			file = neko.io.File.read(this.authFilename, false);			
		} catch (e:Dynamic) {
			SiteState.messages.infos.push("Can't read auth file " + this.authFilename);
			return authUser;			
		}
		
		
		try {
			while(true) {
				var line = file.readLine().trim();
				//Firebug.trace(line);
				if (line.startsWith(user)) {					
					var checkPass = line.split('|')[1];
					if (checkPass == pass) {
						file.close();
						var p = PersonTools.getFromString(line);										
						authUser.success = true;
						authUser.person = p;
						authUser.role = p.roll;
						authUser.user = p.fornamn + ' ' + p.efternamn;
						authUser.pass = p.xpass;
						
						var scorxdirsStr = Tools.stringAfterLast(line, '|');
						
						//-----------------------------------------------------------------------------------------------------						
						var scorxdirs = scorxdirsStr.split(',');
						var ids = ScorxTools.getIdsInDirectory(scorxroot, scorxdirs);
						
						authUser.scorxdirs = scorxdirs;						
						authUser.scorxids = ids; // ids.join(',');
						//SiteState.messages.infos.push(authUser.role);
						//-----------------------------------------------------------------------------------------------------
						authUser.msg = 'Authentication success: User ' + p.epost + ' ok!';
						return authUser;				
						break;						
					} else {
						file.close();
						authUser.msg = 'Authentication fail: Wrong password for user ' + user;
						return authUser;
					}
				}
				//trace(line);
			}
		} catch (e:Dynamic) {
			
		}			
		try {
			file.close();	
		} catch (e:Dynamic) {
			//Firebug.trace(e);
		}
		
		authUser.msg = 'Authentication fail: User ' + user + ' not found!';
		return authUser;
	}
	
	
}