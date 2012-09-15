package smd.server.sx.data;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.exception.Exception;
import haxe.Utf8;
import smd.server.sx.Config;
import neko.Web;
import smd.server.sx.Site;
import smd.server.sx.State;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class PageData {	
	/*
	static public function getDataX(sqlitefile:String = 'data/pages.sqlite'):Dynamic {		
		var file = Config.filesDir + sqlitefile;
		//State.messages.infos.push(file + ' - ' + FileTools.exists(file));
		//-----------------------------------------------------------------------------------------------------
		
		// SAVE?
		var type:String = WebTools.getPostValue('type');
		switch (type) {
			case 'tag-update':
				//try {
				var text = WebTools.getPostValue('text');
				var id = WebTools.getPostValue('id');			
				var tag = WebTools.getPostValue('tag');
				
				text = text.urlDecode().replace("'", '&rsquo;');
				
				var sql = "UPDATE pagecontent set text='" + text + "' where rowid='" + id + "'";
				var updateID = SqliteTools.execute(file, sql);			
				State.messages.infos.push('Texttagg <b>' + tag + '</b> uppdaterad!');			
				//} catch (e:Dynamic) {
				//	State.messages.errors.push('ERROR: ' + Std.string(e));
				//}
			case 'tag-new':
				var insertObject = {
					domain: WebTools.getPostValue('domain'),
					page: StringTools.urlDecode(WebTools.getPostValue('uri')),
					tag:WebTools.getPostValue('tag'),
					text:StringTools.urlDecode(WebTools.getPostValue('text')),
				}
				var sql = SqliteTools.getInsertStatement(insertObject, 'pagecontent');
				var insertId = SqliteTools.insert(file, sql);
				State.messages.success.push('Texttagg skapad! : ' + insertId);
			case 'tag-delete': 	
				var id = WebTools.getPostValue('id');			
				var sql = 'DELETE from pagecontent where rowid="' + id + '"';
				var ret = SqliteTools.execute(file, sql);
				State.messages.success.push('Texttagg borttagen');
			default:
			
		}
		
		//State.messages.infos.push('Savepage: '  + checksavepage);
		
		
		//-----------------------------------------------------------------------------------------------------
		
		if (!FileTools.exists(file)) throw new Exception('Can\'t find pagedata file ' + file);
		var cnx = SqliteTools.getCnx(file);
		var page = WebTools.getUri();
		//var domain = WebTools.getDomainInfo().submain;
		var sql = "select rowid, * from pagecontent where (domain = '" + State.domaintag + "' and page = '" + page + "')";
		var results = SqliteTools.execute(file, sql);
	
		var data:Dynamic = { };
		for (result in results) {
			
			if (Std.string(result.tag).startsWith('info-')) {
				State.messages.infos.push(result.text);
			} else if (Std.string(result.tag).startsWith('error-')) {
				State.messages.errors.push(result.text);
			} else {
				Reflect.setField(data, result.tag, { text: result.text, id: result.rowid } );
			}
			
		}
		
		Reflect.setField(data, 'editpage', (Web.getParams().get('editpage') == Config.secretKey));
		if (data.editpage == true) {
			data.items = [];
			for (result in results) {
				data.items.push( { tag:result.tag, id: result.rowid, text: StringTools.htmlEscape(result.text) } );
			}
		}
		
		Reflect.setField(data, 'messages', State.messages);
		Reflect.setField(data, 'domain', State.domaintag);
		Reflect.setField(data, 'uri', WebTools.getUri());
		
		//-----------------------------------------------------------------------------------------------------
		return data;		
	}
	*/
	
	
	static public function getSidmenuData(data:Dynamic, domainStr:String, templateDir:String, sqlitefile:String = 'data/pages.sqlite') {
		if (data.sidemenu == null) {			
			for (check in State.pagePaths) {
				var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.sidemenu';
				if (FileTools.exists(filename)) {
					var text = FileTools.getContent(filename);
					data.sidemenu = { tag:'sidemenu', id: 0, text: text } ;
					return data;
				}				
			}
		}		
		return data;
	}

	static public function getData(data:Dynamic=null, _domain='', _uri='') : Dynamic {
		var uri = (_uri != '') ? _uri : WebTools.getUri();
		//uri = (uri == '') ? '/' : uri;
		var domain = (_domain != null) ? _domain : State.domaintag;
		var page = WebTools.slashToUnderscores(uri);
		
		var filename = domain + '.' + page + '.';
		var dir = Config.contentDir;
		var files = FileTools.getFilesNamesInDirectory(dir, '', filename);
		
		//State.messages.infos.push(files.toString());
		
		var data = (data != null) ? data : { };
		
		for (file in files) {
			var tag = FileTools.getExtension(file);
			var text = FileTools.getContent(Config.contentDir + file);
			Reflect.setField(data, tag, { text: text, id: 0 } );
		}		
		
		Reflect.setField(data, 'messages', State.messages);
		Reflect.setField(data, 'domain', State.domaintag);
		Reflect.setField(data, 'uri', WebTools.getUri());		
		
		
		return data; 
		
	}
	

	

}