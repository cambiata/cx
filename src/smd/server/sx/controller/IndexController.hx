package smd.server.sx.controller;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.controller.AbstractController;
import harfang.controller.result.ActionResult;
import harfang.exception.Exception;
import neko.Web;
//
import smd.server.base.result.TemplateResult;
import smd.server.ka.data.KaAccess;
import smd.server.sx.Config;
import smd.server.sx.data.DocumentData;
import smd.server.sx.data.DocumentData.TDocument;
import smd.server.sx.data.PageData;
import smd.server.sx.result.IndexResult;
import smd.server.sx.State;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class IndexController extends AbstractController
{
	//static private var domainIndexPage:String = WebTools.getDomainInfo().domain + '.html';
	
	private var data:Dynamic;
	
	override public function handleBefore()	{
		this.data = PageData.getData({}, State.domaintag);
		this.data = PageData.getSidmenuData(this.data, State.domaintag, Config.templatesDir);
	}
	
	@URL("^/$")
	public function index() { 			
		return new IndexResult(Config.indexPage, this.data);
	}
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String = 'default') {				
		return new IndexResult(Config.indexPage, this.data);
	}

	@URL("/nav/([a-zA-Z]+)", "g")
	public function nav(param : String = 'default') {					
		return new IndexResult(Config.indexPage, this.data);
	}

	/*
	@URL("/scorx/info")
	public function scorxlist(param : String = 'default') {			
		var param = param.substr(0, -1);
		this.data.layout = { id:0, text:'list' };
		this.data.scorxmode = 'sx/info';
		return new IndexResult(State.indexPage, this.data);
	}		
	*/

	@URL("/scorx/list/")
	public function scorxlist() {			
		this.data.layout = { id:0, text:'list' };
		this.data.scorxmode = 'list.html';		
		return new IndexResult(Config.indexPage, this.data);
	}			
	
	
	
	@URL("/scorx/([a-zA-Z0-9/]+)$")
	public function scorxpar(param : String = 'default') {			
		var param = param.substr(0, -1);
		var params = param.split('/');
		this.data.layout = { id:0, text:'list' };
		var params0 = params[0];
		var params1 = (params.length > 1) ? params[1] : '0' ;
		
		this.data.scorxmode = 'sx/' + params0 + '/' + params1;
		
		return new IndexResult(Config.indexPage, this.data);
	}			
	
	
	
	@URL("/scorx/")
	public function scorx() {			
		this.data.layout = { id:0, text:'list' };
		this.data.scorxmode = 'sx';
		this.data.scorxid = 0;
		return new IndexResult(Config.indexPage, this.data);
	}			
	
	@URL("/video/([a-zA-Z0-9/]+)", "g")
	public function video(param : String = 'default', par2='hej') {	
		this.data.layout = { id:0, text:'video' };
		this.data.param = param.substr(0, param.length - 1);		
		return new IndexResult(Config.indexPage, this.data);
	}
	
	@URL("/firstlogin")
	public function firstlogin() {			
		this.data.layout = { id:0, text:'nav' };
		return new IndexResult(Config.indexPage, this.data);
	}		
	
	
	@URL("/dok/([a-zA-Z]+)", "g")
	public function dok(param : String = 'default') {					
		var tag = 'site' + WebTools.getUri().replace('/', '_');
		var doc:TDocument = DocumentData.getDocument(tag);
		
		this.data.content = {tag:'content', text:doc.text};
		this.data.title = { tag:'title', text:'title' };
		this.data.layout = { tag:'document', text:'document' };
		return new IndexResult(Config.indexPage, this.data);
	}
	
	@URL("^/access/$")
	public function access() {		
		//return new IndexResult(State.indexPage, this.data, Config.templatesDir);
		//return 'access';
		
		var m = '';
		KaAccess.update(Web.getCwd() + 'auth.txt', function(msg:String) {
			//Firebug.trace(msg);
			m = msg;
		});		
		return m + ' - access';
		
	}
	
	
}
