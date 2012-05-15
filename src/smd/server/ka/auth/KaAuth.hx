package smd.server.ka.auth;
import cx.Tools;
import ka.tools.PersonerTools;
import ka.tools.PersonTools;
import ka.types.Person;
import smd.server.base.auth.AuthResult;
import smd.server.base.auth.AuthTools;
import smd.server.base.auth.AuthUser;
import smd.server.base.auth.IAuth;
import haxe.io.Eof; 
import smd.server.base.SiteState;
import smd.server.ka.config.Config;
import sx.util.ScorxTools;
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
	
	public function check(user:String, pass:String):AuthUser {		
		var authUser:AuthUser = AuthTools.getUserNull();
		var file = neko.io.File.read(this.authFilename, false);				
		try {
			while(true) {
				var line = file.readLine().trim();
				if (line.startsWith(user)) {					
					var checkPass = line.split('|')[1];
					if (checkPass == pass) {
						file.close();
						var p = PersonTools.getFromString(line);										
						authUser.success = true;
						authUser.person = p;
						var scorxdirs = Tools.stringAfterLast(line, '|');
						
						//-----------------------------------------------------------------------------------------------------						
						SiteState.messages.infos.push(scorxdirs);
						SiteState.messages.infos.push(Config.scorxroot);
						var ids = ScorxTools.getIdsInDirectory(Config.scorxroot, scorxdirs.split(','));
						authUser.scorxids = ids.join(',');
						SiteState.messages.infos.push(authUser.scorxids);
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
		file.close();	
		authUser.msg = 'Authentication fail: User ' + user + ' not found!';
		return authUser;
	}
	
	
}