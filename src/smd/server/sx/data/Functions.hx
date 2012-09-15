package smd.server.sx.data;
import cx.FileTools;
import haxe.Serializer;
import neko.Web;
import smd.server.base.data.DataFunctions;
import smd.server.sx.Config;
import smd.server.sx.State;
import ka.tools.AdminGdata;
import ka.types.Roll;
import ka.types.Roller;
import ka.types.Scorxtillganglighet;
import ka.types.Scorxtillgangligheter;
import smd.server.sx.user.Access;
import smd.server.sx.user.AuthFile;


/**
 * ...
 * @author Jonas Nyström
 */

class Functions extends DataFunctions
{
	public function __hello() {
		State.messages.infos.push('Hello');
	}
	
	public function __scorx() {
		State.messages.infos.push('scorx');
		
		var scorxtg:Scorxtillgangligheter = AdminGdata.getScorxtillgangligheter();
		FileTools.putContent(Config.smdDir + 'scorxtillg.data', Serializer.run(scorxtg));
		
		var roller:Roller = AdminGdata.getRoller();
		FileTools.putContent(Config.smdDir + 'roller.data', Serializer.run(scorxtg));
	}
	
	public function __users() {
		State.messages.infos.push('users');
		try {
			Access.saveAuthInfoToFile(Config.authFile);
			State.messages.success.push('User database updated!');
		} catch (e:Dynamic) {
			State.messages.errors.push('Problem updating user database: ' + Std.string(e));
		}
	}
	
	public function __discussadd() {
		State.messages.infos.push('discuss add');
		
	}
	
	
	
}