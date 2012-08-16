package smd.server.sx.data;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.exceptions.Exception;
import smd.server.sx.Config;
import neko.Web;
import smd.server.sx.State;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class PageData {	
	static public function getData(sqlitefile:String = 'data/pages.sqlite'):Dynamic {		
		
		var file = Web.getCwd() + Config.filesDir + sqlitefile;
		//State.messages.infos.push(file + ' - ' + FileTools.exists(file));
		
		
		//-----------------------------------------------------------------------------------------------------
		
		// SAVE?
		var type:String = WebTools.getPostValue('type');
		switch (type) {
			case 'tag-update':
				var text = WebTools.getPostValue('text');
				var id = WebTools.getPostValue('id');			
				var tag = WebTools.getPostValue('tag');
				var sql = "UPDATE pagecontent set text='" + StringTools.urlDecode(text) + "' where rowid='" + id + "'";
				var updateID = SqliteTools.execute(file, sql);			
				State.messages.infos.push('Texttagg <b>' + tag + '</b> uppdaterad!');			
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
	
	static public function getSidmenuData(data:Dynamic, domainStr:String, templateDir:String, sqlitefile:String = 'data/pages.sqlite') {
		if (data.sidemenu == null) {
			
			var file = Web.getCwd() + Config.filesDir + sqlitefile;
			
			//State.messages.infos.push(WebTools.getUri().substr(1));
			var segments = WebTools.getUri().substr(1).split('/');
			
			//State.messages.infos.push(Std.string(segments));
			var checks:Array<String> = [];
			//var segementList:Array<String> = [];
			
			while (segments.length > 0) {
				checks.push('/' + segments.join('/'));
				segments.pop();				
			}
			//State.messages.infos.push(Std.string(checks));
			
			for (check in checks) {
				var sql = "select rowid, * from pagecontent where (tag = 'sidemenu' and domain = '" + State.domaintag + "' and page = '" + check + "')";
				//State.messages.infos.push(sql);
				var results = SqliteTools.execute(file, sql);								
				for (result in results) {
					data.sidemenu = { tag:result.tag, id: result.rowid, text: StringTools.htmlEscape(result.text) } ;
					//State.messages.errors.push(data.sidemenu);
					return data;
				}
			}
			
			/*
			for (segment in segments) {
				segementList.push(segment)
			}
			*/
			
			
			//var sidemenuFile = Web.getCwd() + templateDir + 'sidemenu/' + domainStr + '.html';
			
			/*
			if (FileTools.exists(sidemenuFile)) {
				var content = FileTools.getContent(sidemenuFile);
				data.sidemenu = {tag:'sidemenu', text:content}
			} else {
				data.sidemenu = {tag:'sidemenu', text:'no data: ' + sidemenuFile}
			}
			*/
		}		
		return data;
	}
	
}