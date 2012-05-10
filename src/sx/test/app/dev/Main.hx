package sx.test.app.dev;
import cx.CacheTools;
import cx.FileTools;
import hxjson2.JSON;
import sx.type.TListExamples;
import sx.type.TSupplyState;
import sx.util.ScorxExamples;

import sx.util.ScorxTools;


/**
 * ...
 * @author Jonas Nyström
 */
using sx.util.ListExamplesFilters;
using sx.util.ListExamplesTools;

class Main 
{	
	static function main() 
	{
		var path = "D:/dropbox_scorxmedia/My Dropbox/smd/smdfiles/scorx";
		var subdirs = ['fbr1', 'fbr2'];

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
		
		/*
		listExamples = listExamples.filterIncludeIds([44]);
		listExamples.setStop(Date.fromString('2012-02-01'), [44]);
		listExamples = listExamples.filterDates(Date.fromString('2013-01-15'));		
		*/
		FileTools.putContent('data/list.json', JSON.encode(listExamples));
		trace(listExamples);
		

	}
	
}