package sx.type.utils;
import cx.ArrayTools;
import cx.EncodeTools;
import cx.StrTools;
import haxe.BaseCode;
import haxe.Http;
import haxe.Utf8;
import sx.type.TAlternative;
import sx.type.TFiles;
import sx.type.TOriginator;
import sx.type.TOriginators;
import sx.util.ExampleTools;
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
	
	static public function getOriginatorsHash(files:TFiles)  {		
		
		var oshortOriginator = new Hash<TOriginator>();
		var oshortIds = new Hash<Array<Int>>();
		
		var catValues = new Hash<TAlternative>();
		var catValuesIds = new Hash<Array<Int>>();
		
		var catdyns = new Array<String>();
		var catdynsIds = new Hash<Array<Int>>();
		
		
		for (id in files.keys()) {			
			
			var file = files.get(id);			

			var originators = ScorxDb.getOriginators(file);			
			for (originator in originators) {				
				var short = ScorxTools.getOriginatorshort(originator, false);
				oshortOriginator.set(short, originator);
				if (! oshortIds.exists(short)) oshortIds.set(short, new Array<Int>());
				oshortIds.get(short).push(id);
			}
			
			var categories = ScorxDb.getCategories(file); 
			for (category in categories) {
				var key = category.categoryId + ExampleTools.SEPARATOR_CATITEM + category.value;
				catValues.set(key, category);
				if (! catValuesIds.exists(key)) catValuesIds.set(key, new Array<Int>());
				catValuesIds.get(key).push(id);				
			}
			
			var categories = ScorxDb.getCategoriesDyn(file);
			for (category in categories) {
				var key = category.categoryId.toLowerCase();
				if (! Lambda.has(catdyns, key)) catdyns.push(key);
				
				//var keyValue = key + ExampleTools.SEPARATOR_CATITEM + category.value;				
				if (! catdynsIds.exists(key)) catdynsIds.set(key, new Array<Int>());
				catdynsIds.get(key).push(id);				
			}
			
		}

		trace(catdyns);
		
		//return result;
		
		return { 
			oshortOriginators:oshortOriginator,
			oshortIds:oshortIds,
			catValues:catValues,
			catValuesIds:catValuesIds,
			catdyns:catdyns,
			datdynsIds:catdynsIds,
		}
		
	}
	
	
	
	

	
}