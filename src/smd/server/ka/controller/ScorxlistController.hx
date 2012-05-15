package smd.server.ka.controller;
import cx.FileTools;
import hxjson2.JSON;
import neko.Web;
import smd.server.base.controller.UserController;
import smd.server.base.result.ScorxResult;
import smd.server.base.result.TemplateResult;
import smd.server.base.SiteState;
import smd.server.ka.config.Config;
import sx.util.ScorxExamples;

/**
 * ...
 * @author Jonas Nyström
 */

class ScorxlistController extends UserController
{
	static private var listExamplesJsonFile:String = Web.getCwd() + 'data/list.json';
	
	@URL("^/scorx/list/$")
	public function scorxlist() {								
		if (!FileTools.exists(listExamplesJsonFile)) this.update();		
		var listExamplesJson = FileTools.getContent(listExamplesJsonFile);
		return listExamplesJson;		
	}		
	
	/*
	@URL("^/scorx/list/$")
	public function scorxlist() {						
		return new ScorxResult(null, this.authUser, new TemplateResult('templates/scorx/sidebar.html').execute(), null);
	}
	*/
	
	@URL("^/scorx/$")
	public function scorx() {						
		if (Web.getParams().get('f') == 'update') {
			this.update();
			SiteState.messages.infos.push('scorxlist updated!');
		}
		return new ScorxResult(null, this.authUser, new TemplateResult('templates/scorx/sidebar.html').execute(), null);
	}	
	
	
	private function update() {
		var path = Config.scorxroot;
		var subdirs = Config.scorxdirs.split(',');		
		var s = new ScorxExamples(path, subdirs); 	
		var listExamples = s.getListExamples();
		var listExamplesJson = JSON.encode(listExamples);
		FileTools.putContent(listExamplesJsonFile, listExamplesJson);		
	}
	
}