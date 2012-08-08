package smd.server.sx.controller;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.controller.AbstractController;
import harfang.exceptions.Exception;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.config.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends AbstractController
{
	static private var domainIndexPage:String = WebTools.getDomainInfo().domain + '.html';

	/*
	public function new() {
		this.domainIndexPage = ;
		trace(this.domainIndexPage);
	}
	*/
	
	@URL("^/$")
	public function index() { 			
		return new TemplateResult(domainIndexPage, PageData.getData(), Config.templatesDir);
	}
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String = 'default') {			
		return param;		
	}
}

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