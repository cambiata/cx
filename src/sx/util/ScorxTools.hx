package sx.util;
import cx.FileTools;
import ka.types.Scorxtillgangligheter;
import neko.Utf8;
import sx.type.THashIds;
import sx.type.TListExamples;
import sx.util.ScorxDb;
import sx.type.TAlternatives;
import sx.type.TExample;
import sx.type.TExamples;
import sx.type.TFiles;
import sx.type.TListExample;
import sx.type.TOriginator;
import sx.type.TOriginatorItems;
import sx.type.TOriginatorshort;
import sx.type.TOriginatorshorts;


/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
class ScorxTools 
{
	static public function getId(filename:String):Int {
		var idString = FileTools.getFirstFilenameSegment(filename).replace('_', '');		
		return Std.parseInt(idString);		
	}
	
	/*
	static public function getExamplesInDirectory(dir:String):TExamples {
		var examples = new TExamples();
		var files = FileTools.getFilesInDirectories(dir, '.sqlite');
		for (file in files) {
			examples.set(ScorxTools.getId(file), ScorxDb.getExample(file));
		}
		return examples;
	}
	*/
	
	static public function getIdsInDirectory(dir:String, subdirs:Array<String>=null):Array<Int> {		
		//var ids = new Array<Int>();		
		var files:TFiles = getFilesInDirectory(dir, subdirs);		
		//var keys = files.keys();
		//for (key in keys) ids.push(key);
		return getIdsFromFiles(files);
	}
	
	static public function getFilesInDirectory(dir:String, subdirs:Array<String>=null):TFiles {
		var ret = new TFiles();
		var dirs:Array<String> = [];

		if (subdirs != null) {
			for (subdir in subdirs) {
				var fulldir = dir + '/' + subdir;
				if (!Lambda.has(dirs, fulldir)) dirs.push(fulldir);
			}
		} else {
			dirs = [dir];
		}		
		
		var scorxFiles = new Array<String>();
		for (dr in dirs) {
			try {
				var files = FileTools.getFilesInDirectories(dr, '.sqlite');
				for (file in files) {
					scorxFiles.push(file);
				}		
			} catch (e:Dynamic) {
				
			}
		}		

		for (file in scorxFiles) {
			var id = ScorxTools.getId(file); 
			ret.set(id, file);
		}
		
		return ret;
	}
	
	static public function getIdsFromFiles(files:TFiles):Array<Int> {
		var ids = new Array<Int>();		
		var keys = files.keys();
		for (key in keys) ids.push(key);
		ids.sort(function(a, b) { return Reflect.compare(a, b); } );
		return ids;		
	}
	
	/*
	static public function getBesFromExample(example:TExample):String {
		for (cat in example.categories) {
			if (cat.categoryId == 'bes') return cat.value;			
		}
		return null;
	}

	static public function getAckFromExample(example:TExample):String {
		for (cat in example.categories) {
			if (cat.categoryId == 'ack') return cat.value;			
		}
		return null;
	}
	
	static public function getOriginatorshortsFromExample(example:TExample):TOriginatorshorts {
		var originatorshorts = new TOriginatorshorts();
		for (origItem in example.originatorItems) {
			var originatorshort = getOriginatorshortFormOriginator(origItem.originator);
			originatorshorts.push(originatorshort);
		}
		return originatorshorts;
	}
	*/
	
	static public function getOriginatorshort(originator:TOriginator):TOriginatorshort {
		var s:TOriginatorshort = '';
		if (originator.firstname != '') s += originator.firstname + ' ';
		s += originator.lastname;
		var b = originator.birth;
		var d = originator.death;
		var y = '(' + [b, d].join('-') + ')';
		if (y != '(-)') s += ' ' + y;		
		return s;
	}
	
	static public function addIdsToScorxtillgangligheter(scorxtg:Scorxtillgangligheter, scorxDir:String) :Scorxtillgangligheter {
		for (tg in scorxtg) {
			for (mapp in tg.mappar) {
				var ids = ScorxTools.getIdsInDirectory(scorxDir + mapp);				
				tg.ids = tg.ids.concat(ids);
			}
			tg.ids.sort(function(a, b) { return Reflect.compare(a, b); } );
		}		
		return scorxtg;
	}
	
	static public function getListExamples(scorxtg:Scorxtillgangligheter, scorxDir:String) : TListExamples {
		var listExamples = new TListExamples();		
		for (tg in scorxtg) {
			for (mapp in tg.mappar) {
				var dir = scorxDir + mapp;
				var files = ScorxTools.getFilesInDirectory(dir);		
				for (file in files) {
					var listExample = ExampleTools.getListExample(ScorxDb.getExample(file));
					listExamples.set(listExample.id, listExample);
				}				
			}
		}		
		return listExamples;
	}
	

}