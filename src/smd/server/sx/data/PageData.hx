package smd.server.sx.data;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.exceptions.Exception;
import smd.server.sx.Config;
import neko.Web;

/**
 * ...
 * @author Jonas Nyström
 */

class PageData {	
	static public function getData(sqlitefile:String='templates/pages.sqlite'):Dynamic {		
		var file = Web.getCwd() + Config.filesDir + sqlitefile;
		
		if (!FileTools.exists(file)) throw new Exception('Can\'t find pagedata file ' + file);
		var cnx = SqliteTools.getCnx(file);
		var page = WebTools.getUri();
		var domain = WebTools.getDomainInfo().domain;
		var sql = "select * from pagecontent where (domain = '" + domain + "' and page = '" + page + "')";
		var results = SqliteTools.execute(file, sql);
		var data:Dynamic = { };
		for (result in results) {
			Reflect.setField(data, result.tag, result.text);
		}
		
		Reflect.setField(data, 'editpage', (Web.getParams().get('editpage') == Config.secretKey));
		if (data.editpage == true) {
			data.items = [];
			for (result in results) {
				data.items.push( { tag:result.tag, text: StringTools.htmlEscape(result.text) } );
			}
		}
		
		return data;		
	}
	
}