package sx.test.app.dev;
import cx.CacheTools;
import cx.FileTools;
import cx.OdtTools;
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
		/*		
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
		FileTools.putContent('data/list.json', JSON.encode(listExamples));
		trace(listExamples);
		*/

		//-----------------------------------------------------------------------------------------------------
		
		/*
		 * Create table of content OdtTools 
		 */
		
		/*
		var path = "D:/dropbox_scorxmedia/My Dropbox/kursverksamhet/korakademin/pedagogiskt material/PrimaVista/odt-2012/termer";
		var files = FileTools.getFilesInDirectories(path, '.odt', false);
		trace(files);

		var html = OdtTools.getMeta();
		var tocs:Array<OdtTOC> = [];
		for(file in files) {
			trace(file);
			var ze = OdtTools.getZipEntries(file);
			html += OdtTools.getHtmlFromContent(OdtTools.getXmlParts(ze), ze);
			var toc = OdtTools.getTOC(OdtTools.getContentXmlStr(ze), file);
			
			tocs = tocs.concat(toc);
			//trace(toc);			
		}
		trace(tocs);
		//trace(files[7]);
		//html += OdtTools.getHtmlFromOdt(files[7], false);
		
		FileTools.putContentExecute('termer.html', html);
		*/
	}
	
}