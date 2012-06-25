package smd.server.ka.controller;
import cx.FileTools;
import haxe.Firebug;
import hxjson2.JSON;
import neko.Web;
import smd.server.base.controller.UserController;
import smd.server.base.result.ScorxResult;
import smd.server.base.result.TemplateResult;
import smd.server.base.SiteState;
import smd.server.ka.config.Config;
import sx.util.ListExamplesTools;
import sx.util.ScorxExamples;

/**
 * ...
 * @author Jonas Nyström
 */

 using sx.util.ListExamplesTools;

class ScorxlistController extends UserController
{
	
	
	@URL("^/scorx/list/$")
	public function scorxlist() {								
		if (!FileTools.exists(Config.cacheDir + Config.scorxlistFilename)) this.update();				
		
		/*
		var listExamplesJson = FileTools.getContent(Config.cacheDir + Config.scorxlistFilename);
		return listExamplesJson;	
		*/
		
		
		
		
		//new ScorxExamples(Config.scorxroot).saveListExamples(Config.cacheDir + 'scorxlist.json');
		
		
		var s = new ScorxExamples(null); 	
		s.loadListExamples(Config.cacheDir + Config.scorxlistFilename);		
		var listExamples = s.getListExamples();
		listExamples = ListExamplesTools.getInSubdirs(listExamples, Config.scorxdirs.split(','));
		var listExamplesJson = JSON.encode(listExamples);
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
		if (!FileTools.exists(Config.cacheDir + Config.scorxlistFilename)) this.update();						
		
		SiteState.messages.infos.push(Config.scorxroot);
		SiteState.messages.infos.push(Config.scorxdirs);
		SiteState.messages.success.push(Std.string(SiteState.user));
		return new ScorxResult(null, this.authUser, new TemplateResult('templates/scorx/sidebar.html').execute(), null);
		
	}	
	
	//-----------------------------------------------------------------------------------------------------	
	
	private function update() {
		var path = Config.scorxroot;
		var subdirs = Config.scorxdirs.split(',');		
		var s = new ScorxExamples(path, subdirs); 	
		
		/*
		var listExamples = s.getListExamples();
		var listExamplesJson = JSON.encode(listExamples);
		
		FileTools.putContent(Config.cacheDir + Config.scorxlistFilename, listExamplesJson);		
		*/
		
		s.saveListExamples(Config.cacheDir + Config.scorxlistFilename);
		
	}
	
}