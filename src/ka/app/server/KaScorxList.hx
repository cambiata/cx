package ka.app.server;
import cx.CacheTools;
import cx.ConfigTools;
import neko.Web;
import smd.server.ka.config.Config;
import sx.type.TListExamples;
import sx.util.ScorxExamples;

/**
 * ...
 * @author Jonas Nyström
 */

class KaScorxList 
{

	static public function main() 
	{
		
		trace('KaScorxList');
		ConfigTools.loadConfig(Config, Web.getCwd() + 'conf/Config.txt');
		trace(Config.scorxroot);
		trace(Config.scorxdirs);
		

		
		var listExamples:TListExamples = CacheTools.getObject('listExamples.data', 20, 
				function() {
					trace('reload...');
					var s = new ScorxExamples(path, subdirs); 	
					var le = s.getListExamples();
					return le;
				},
				function() {
					trace('from cache ' + CacheTools.getFileAgeSeconds('listExamples.data'));					
				}
			);
			
		//FileTools.putContent('data/list.json', JSON.encode(listExamples));
		//trace(listExamples);		
		
		
	}
	
}