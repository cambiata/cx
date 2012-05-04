package smd.server.ka.controller;
import smd.server.base.controller.UserController;
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

	@URL("/doc/([a-zA-Z]+)", "g")
	public function doc(param : String='document') {						
		//return  new IndexResult(null, loginUser, null, 'info ' + param );
		var content = null;
		if (param.toLowerCase() != 'index') content = new OdtResult('_docs/' + param.toLowerCase() + '.odt', { } ).execute();
		return  new IndexResult(null, loginUser, null, content );		
	}	
	
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String='INFORMATION') {						
		//return  new IndexResult(null, loginUser, null, 'info ' + param );
		var content = null;
		if (param.toLowerCase() != 'index') content = new TemplateResult('templates/info/' + param.toLowerCase() + '.html').execute();
		return  new IndexResult(null, loginUser, null, content );		
	}
	
	@URL("/document/kursplan")
	public function kursplan() {						
		return  new IndexResult(loginUser, null, new OdtResult('_docs/kurs/Kursplan-2011-2012.odt', { } ).execute());
	}
	
	@URL("/document/studiehandledning")
	public function studiehandledning() {						
		return  new IndexResult(loginUser, null, new OdtResult('_docs/kurs/Studiehandledning-2011-2012.odt', { } ).execute());
	}	
	
	@URL("/odt2")
	public function odt2() {						
		return  new IndexResult(loginUser, null, new OdtResult('_docs/barockens-musiksyn.odt', { } ).execute());
	}
	
	@URL("/information")
	public function odt() {						
		return  new IndexResult(loginUser, null, '<h1>Information...</h1>');
	}
	
	@URL("/document")
	public function document() {						
		return new IndexResult(loginUser, null, '<p>Dokument</p>');
	}
	
	@URL("/contact")
	public function contact() {						
		return new IndexResult(loginUser, null, '<p>Contact content</p>');
	}
	
	@URL("/player")
	public function player() {						
		return new IndexResult(loginUser, null, 'Player');
	}		
	
	@URL("/scorx")
	public function scorx() {						
		return new ScorxResult(loginUser, null);
	}	
	
	/*
	@URL("/([a-zA-Z]+)", "g")
	public function index(param : String = null) {
		var content = null;
		if (param.toLowerCase() != 'index') content = new TemplateResult('templates/content/' + param.toLowerCase() + '.html').execute();
		return  new IndexResult(null, loginUser, null, content );
	}		
	*/
	
	
	@URL("/")
	public function index() {						
		return new IndexResult(loginUser, null, null);
	}
	
}