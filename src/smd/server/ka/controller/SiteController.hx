package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.base.result.HtmlWrappedResult;
import smd.server.base.result.OdtResult;
import smd.server.base.result.ScorxResult;
import smd.server.base.result.TemplateResult;
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
		if (param.toLowerCase() != 'default') content = new TemplateResult('_docs/page/' + param.toLowerCase() + '.html').execute();
		return  new IndexResult(null, this.authUser, null, content );		
	}		
	
	
	@URL("/doc/([a-zA-Z]+)", "g")
	public function doc(param : String='default') {						
		var content = null;
		if (param.toLowerCase() != 'default') content = new OdtResult('_docs/' + param.toLowerCase() + '.odt', { } ).execute();
		return  new IndexResult(null, this.authUser, null, content );		
	}	
	
	
	/*
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String='default') {						
		var content = null;
		if (param.toLowerCase() != 'default') content = new TemplateResult('templates/info/' + param.toLowerCase() + '.html').execute();
		return  new IndexResult(null, this.authUser, null, content );		
	}
	*/
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String='default') {						
		var content = null;
		if (param.toLowerCase() != 'default') {
			//content = new OdtResult('_docs/info/' + param.toLowerCase() + '.odt', { }, '_docs/info/doc_' + param.toLowerCase() + '.html' ).execute();
			content = new HtmlWrappedResult('_docs/info/' + param.toLowerCase() + '.html', { }, '_docs/info/doc_' + param.toLowerCase() + '.html' ).execute();
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