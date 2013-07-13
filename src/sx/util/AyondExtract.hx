package sx.util;

import cx.ArgTools;
import cx.ArrayTools;
import cx.ExcelTools;
import cx.FileTools;
import neko.Lib;
import sx.type.TExample;
import sx.util.AyondExtract;
import sx.util.ScorxDb;
import sx.util.ScorxTools;

/**
 * ...
 * @author Jonas Nyström
 */
class AyondExtract
{

	static public function extract() 
	{
		
		//var dir = 'C:/Dropbox/smd/smdfiles/scorx/sg-010/';
		//var file = '00000017.du-ljuvaste-barn-satb.bach.sqlite';
		//var example = ScorxDb.getExample(dir + file);
		//trace(example);
		
		//trace(example.categories);
		//for (cat in example.categories) trace(cat);
		//for (item in example.originatorItems) trace(item);
		
		
		var mainDir =  'C:/Dropbox/smd/smdfiles/scorx/';
		var dirs = FileTools.getDirectories(mainDir);
		var count = 1;
		
		var allKeys = new Array<String>();
		
		for (dir in dirs) {
			//trace(dir);
			var files = FileTools.getFilesNamesInDirectory(dir, 'sqlite');
			for (file in files) {
				var example = ScorxDb.getExample(dir + '/' + file);
				var metadata = getMetadata(example);
				var keys = ArrayTools.fromHashKeys(metadata.keys());
				allKeys = ArrayTools.unique(Lambda.array(Lambda.concat(allKeys, keys)));
				//trace(allKeys);
				count++;
			}
		}

		trace(allKeys);
		
		
		var row = 0;
		ExcelTools.start('test.xls');
		
		for (i in 0...allKeys.length) {
			ExcelTools.writeString(row, i, allKeys[i]);
		}
		
		row++;
		
		for (dir in dirs) {
			var files = FileTools.getFilesNamesInDirectory(dir, 'sqlite');
			for (file in files) {
				var example = ScorxDb.getExample(dir + '/' + file);
				var metadata = getMetadata(example);

				for (i in 0...allKeys.length) {
					var key = allKeys[i];
					if (metadata.exists(key)) {
						ExcelTools.writeString(row, i, metadata.get(allKeys[i]));
					}
				}
				
				
				row++;
			}
		}
		
		
		
		
		
		
		ExcelTools.finish();
		
		
	}
	
	static public function getMetadata(example:TExample) {
		var metadata:Hash<String> = new Hash<String>();
		
		metadata.set('title', example.information.title);
		metadata.set('subtitle', example.information.subtitle);
		metadata.set('sorttitle', '');
		for (cat in example.categories) {
			if (metadata.exists(cat.categoryId.toLowerCase())) {
				metadata.set(cat.categoryId.toLowerCase(), metadata.get(cat.categoryId.toLowerCase()) + ';' + cat.value);
			} else {
				metadata.set(cat.categoryId.toLowerCase(), cat.value);
			}
		}
		
		for (cat in example.categoriesDynamic) {
			metadata.set(cat.categoryId.toLowerCase(), cat.value);
		}
		
		for (item in example.originatorItems) {
			if (metadata.exists(item.type.toLowerCase())) {
				metadata.set(item.type.toLowerCase(), metadata.get(item.type.toLowerCase()) + ';' + ScorxTools.getOriginatorshort(item.originator));
			} else {
				metadata.set(item.type.toLowerCase(), ScorxTools.getOriginatorshort(item.originator));
			}
		}
		
		//trace (metadata);
		
		
		return metadata;
	}
	
	
}