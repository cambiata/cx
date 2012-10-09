package sx.type.utils;
import cx.ArrayTools;
import sx.type.TFiles;
import sx.util.ScorxTools;
import cx.StrTools;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
class TFilesUtils 
{

	static public  function getFilesFromDirs(basePath:String, dirs:Array<String>):TFiles {
		var files:TFiles = new TFiles();		
		for (subdir in dirs) {
			var dir = basePath + subdir;
			var joinFiles = ScorxTools.getFilesInDirectory(dir);			
			files = ScorxTools.joinFiles(files, joinFiles);
		}				
		return files;
	}
	
	static public  function getFilenames(files:TFiles) :IntHash<String> {		
		var result = new IntHash<String>();
		var ids = ScorxTools.getIdsFromFiles(files);		
		for (id in ids) {
			var filename = files.get(id);
			var shortFilename = filename.substr(filename.lastIdxOf('/', 2));
			result.set(id, shortFilename);
		}		
		return result;		
	}

	static public  function getDirectories(files:TFiles):Array<String> {
		var result = ['- Alla kataloger'];
		for (id in files.keys()) {
			var filename = files.get(id);
			var shortFilename = filename.substr(filename.lastIdxOf('/', 2));
			var dirsName = shortFilename.substr(0, shortFilename.lastIndexOf('/'));
			result.push(dirsName);			
		}		
		
		result = ArrayTools.unique(result);
		return result;				
	}
	
	static public function getFilesShortnames(files:TFiles, filterDir='') {
		var result = new Array<String>();
		
		var ids = ScorxTools.getIdsFromFiles(files);
		
		for (id in ids) {
			var filename = files.get(id);
			
			if (filterDir != '') {
				if (filename.indexOf(filterDir) == -1)  continue;
			}
			var shortFilename = filename.substr(filename.lastIdxOf('/'));
			result.push(shortFilename);
		}
		
		return result;
	}

	
}