package smd.server.sx.data;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.exception.Exception;
import haxe.Template;
import haxe.Utf8;
import neko.FileSystem;
import neko.Lib;
import smd.server.sx.Config;
import neko.Web;
import smd.server.sx.Site;
import smd.server.sx.State;
import smd.server.sx.user.User;

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
	
	
	
	
	static public function getSidmenuData(data:Dynamic, domainStr:String, templateDir:String) {
		if (data.sidemenu == null) {			
			for (check in WebTools.pagePaths) {
				var pagepath = FileTools.stripLastSlash(Config.contentDir + WebTools.domaintag + check); 
				var filename = pagepath + '/' + 'sidemenu.html';
				//trace(filename);
				//var filename = Config.contentDir + State.domaintag + '.' +  WebTools.slashToUnderscores(check) + '.sidemenu';
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

		var data = (data != null) ? data : { };
		var uri = (_uri != '') ? _uri : WebTools.getUri();
		var domain = (_domain != null) ? _domain : WebTools.domaintag;
		
		//-------------------------------------------------------------------------------------------------
		
		/*
		var editpage = (User.user != null) ? (User.user.role == 'Administratör') : false;
		editpage = (Web.getParams().get('editpage') == Config.secretKey);
		var editpagehtml = '';
		
		var editfield = Web.getParams().get('editfield');
		var editfielddata:String = null;
		var savefielduri:String = null;
		
		
		Reflect.setField(data, 'editpage', editpage);		
		*/
		
		//-------------------------------------------------------------------------------------------------

		var pagepath = FileTools.stripLastSlash(Config.contentDir + domain + uri); 

		if (FileTools.exists(pagepath)) {
			var files = FileTools.getFilesNamesInDirectory(pagepath + '/', 'html');
			for (file in files) {
				var filename = pagepath + '/' + file;
				var tag = FileTools.getFilename(filename, false);
				var text = FileTools.getContent(filename);
				
				// apply template data...
				var t = new haxe.Template(text);
				text = t.execute(data);				
				
				Reflect.setField(data, tag, { text: text, id: 0 } );
			}			
		} else {			
			State.messages.debugs.push("pagepath doesn't exist");
		}
		
		
		//-------------------------------------------------------------------------------------------------
	
		/*
		var page = WebTools.slashToUnderscores(uri);
		var filename = domain + '.' + page + '.';
		var dir = Config.contentDir;
		var files = FileTools.getFilesNamesInDirectory(dir, '', filename);
		
		for (file in files) {
			var tag = FileTools.getExtension(file);
			var text = FileTools.getContent(Config.contentDir + file);
			Reflect.setField(data, tag, { text: text, id: 0 } );
			
		}		
		*/
		
		//----------------------------------------------------------------------------------------
		
		Reflect.setField(data, 'messages', State.messages);
		Reflect.setField(data, 'domain', WebTools.domaintag);
		Reflect.setField(data, 'uri', WebTools.getUri());		
		
		//----------------------------------------------------------------------------------------		

		/*
		Reflect.setField(data, 'editpagehtml', editpagehtml);		
		Reflect.setField(data, 'editfield', editfield);		
		Reflect.setField(data, 'editfielddata', editfielddata);		
		*/
		
		//----------------------------------------------------------------------------------------		
		
		
		
		return data; 
		
	}
	

	

}