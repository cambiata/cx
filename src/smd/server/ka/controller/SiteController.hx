package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.base.result.HtmlWrappedResult;
import smd.server.base.result.OdtResult;
import smd.server.base.result.ScorxResult;
import smd.server.base.result.TemplateResult;
import smd.server.base.SiteState;
import smd.server.ka.config.Config;
import smd.server.ka.result.IndexResult;

/**
 * ...
 * @author Jonas Nyström
 */

class SiteController extends UserController
{

	
	@URL("/page/([a-zA-Z]+)", "g")
	public function page(param : String='default') {						
		var content = null;
		var dir = Config.docsDir + 'page/';
		if (param.toLowerCase() != 'default') content = new TemplateResult(dir + param.toLowerCase() + '.html').execute();
		return  new IndexResult(null, this.authUser, null, content );		
	}		
	
	
	@URL("/doc/([a-zA-Z]+)", "g")
	public function doc(param : String='default') {						
		var content = null;
		var dir = Config.docsDir;
		if (param.toLowerCase() != 'default') content = new OdtResult(Config.docsDir + param.toLowerCase() + '.odt', { } ).execute();
		return  new IndexResult(null, this.authUser, null, content );		
	}	
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String='default') {						
		var content = null;
		var dir = Config.docsDir + 'info/';
		if (param.toLowerCase() != 'default') {
			content = new HtmlWrappedResult(dir + param.toLowerCase() + '.html', { }, dir + 'doc_' + param.toLowerCase() + '.html' ).execute();
		}
		return  new IndexResult(null, this.authUser, null, content );		
	}	
	
	@URL("/kurs/([a-zA-Z]+)", "g")
	public function kurs(param : String='default') {						
		var content = null;
		var dir = Config.docsDir + 'kurs/';
		if (param.toLowerCase() != 'default') {
			content = new HtmlWrappedResult(dir + param.toLowerCase() + '.html', { }, dir + 'doc_' + param.toLowerCase() + '.html' ).execute();
		}
		return  new IndexResult(null, this.authUser, null, content );		
	}		
	
	@URL("/form/([a-zA-Z]+)", "g")
	public function form(param : String='default') {						
		var content = null;
		var dir = Config.docsDir + 'form/';
		if (param.toLowerCase() != 'default') {
			content = new HtmlWrappedResult(dir + param.toLowerCase() + '.html', { }, dir + 'doc_' + param.toLowerCase() + '.html' ).execute();
		}
		return  new IndexResult(null, this.authUser, null, content );		
	}		
	
	
	@URL("/contact")
	public function contact() {						
		return new IndexResult(this.authUser, null, '<p>Contact content</p>');
	}
	
	@URL("/player")
	public function player() {						
		return new IndexResult(this.authUser, null, 'Player');
	}		
	


	
}