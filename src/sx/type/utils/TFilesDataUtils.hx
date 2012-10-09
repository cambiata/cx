package sx.type.utils;
import sx.type.TFiles;
import sx.type.TOriginator;
import sx.type.TOriginators;
import sx.util.ScorxDb;
import sx.util.ScorxTools;

/**
 * ...
 * @author Jonas Nyström
 */

class TFilesDataUtils 
{

	static public function list (files:TFiles) {
		for (file in files) {
			trace(file);			
		}		
	}
	
	static public function getOriginatorsHash(files:TFiles) : Hash<TOriginator> {		
		var result = new Hash<TOriginator>();
		
		for (file in files) {			
			var originators = ScorxDb.getOriginators(file);			
			for (originator in originators) {				
				var short = ScorxTools.getOriginatorshort(originator);
				result.set(short, originator);
			}
		}
		
		return result;
	}
	

	
}