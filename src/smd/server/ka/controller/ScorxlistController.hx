package smd.server.ka.controller;
import smd.server.base.controller.UserController;
import smd.server.base.result.ScorxResult;
import smd.server.base.result.TemplateResult;

/**
 * ...
 * @author Jonas Nyström
 */

class ScorxlistController extends UserController
{

	@URL("^/scorx/list/$")
	public function scorxlist() {						
		return new ScorxResult(null, this.loginUser, new TemplateResult('templates/scorx/sidebar.html').execute(), null);
	}		
	
	@URL("^/scorx/$")
	public function scorx() {						
		return new ScorxResult(null, this.loginUser, new TemplateResult('templates/scorx/sidebar.html').execute(), null);
	}	
	
}