package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.base.result.OdtResult;
import smd.server.base.result.TemplateResult;
import smd.server.ka.result.IndexResult;

/**
 * ...
 * @author Jonas Nyström
 */

class SiteController extends UserController
{

	@URL("/document/kursplan")
	public function kursplan() {						
		return  new IndexResult(loginUser, 'Contact sidebar', new OdtResult('_docs/kurs/Kursplan-2011-2012.odt', { } ).execute());
	}
	
	@URL("/document/studiehandledning")
	public function studiehandledning() {						
		return  new IndexResult(loginUser, 'Contact sidebar', new OdtResult('_docs/kurs/Studiehandledning-2011-2012.odt', { } ).execute());
	}	
	
	
	@URL("/odt2")
	public function odt2() {						
		return  new IndexResult(loginUser, 'Contact sidebar', new OdtResult('_docs/barockens-musiksyn.odt', { } ).execute());
	}
	
	
	
	@URL("/odt")
	public function odt() {						
		return  new IndexResult(loginUser, 'Contact sidebar', new OdtResult('_docs/test1.odt', { } ).execute());
	}
	
	@URL("/document")
	public function document() {						
		return new IndexResult(loginUser, 'Contact sidebar', '<p>Dokument</p>');
	}
	
	@URL("/contact")
	public function contact() {						
		return new IndexResult(loginUser, 'Contact sidebar', '<p>Contact content</p>');
	}
	
	@URL("/player")
	public function player() {						
		return new IndexResult(loginUser, 'Contact sidebar', 'Player');
	}		
	
	@URL("/scorx")
	public function scorx() {						
		return new IndexResult(loginUser, 'Contact sidebar', 'Scorx');
	}		

	@URL("/")
	public function index() {						
		return new IndexResult(loginUser, 'sidebar', new TemplateResult('templates/content/home.html', loginUser).execute());
	}
}