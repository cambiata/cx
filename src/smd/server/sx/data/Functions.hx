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
import sx.util.ScorxTools;


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
		State.messages.infos.push(Config.scorxDir);

		try {
			var roller:Roller = AdminGdata.getRoller();
			FileTools.putContent(Config.smdDir + 'roller.data', Serializer.run(roller));
		} catch (e:Dynamic) { State.messages.errors.push("Can't update roller data");}
		
		var scorxtg:Scorxtillgangligheter = null;
		
		try {
			scorxtg = AdminGdata.getScorxtillgangligheter();
			scorxtg = ScorxTools.addIdsToScorxtillgangligheter(scorxtg, Config.scorxDir);
			FileTools.putContent(Config.smdDir + 'scorxtillg.data', Serializer.run(scorxtg));
		} catch (e:Dynamic) { State.messages.errors.push("Can't update scorxtillg data");}
		
		if (scorxtg != null) {
			try {
				var listExamples = ScorxTools.getListExamples(scorxtg, Config.scorxDir);
				FileTools.putContent(Config.smdDir + 'scorxlist.data', Serializer.run(listExamples));
			} catch (e:Dynamic) { State.messages.errors.push("Can't update scorxlist data"); }
		}		
	}
	
	public function __users() {		
		try {
			FileTools.backup(Config.authFile, '_bak', 5);
			State.messages.success.push('Users list backup created!');
		} catch (e:Dynamic) {
			State.messages.errors.push('Could not create users backup!' + Std.string(e));
		}
			
		try {
			Access.saveAuthInfoToFile(Config.authFile);
			State.messages.success.push('Users list updated!');
		} catch (e:Dynamic) {
			State.messages.errors.push('Could not update user list: ' + Std.string(e));
		}
		
	}
	
	public function __discussadd() {
		State.messages.infos.push('discuss add');		
	}
	
	
	
}