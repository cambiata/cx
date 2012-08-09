package smd.server.sx;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import neko.Lib;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.Config;
import smd.server.sx.data.PageData;

class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
		this.addModule(new Site());			
		
		ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
		
		//State.messages.infos.push('Hello World');
		//State.messages.errors.push('This is an error');
		
		/*
		try {
			ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
			new Functions();
			SiteState.user = AuthTools.getCurrentUser(new KaAuth(Config.authFile, Config.scorxroot), Config.sessionDir);						
		} catch (e:String) {
			SiteState.messages.errors.push(e);
		}
		*/
    }
	
	override public function onHTTPError(error : HTTPException) : Void {
		
		State.messages.errors.push(error.getErrorCode() + ': ' + error.getMessage());
		
		error.uri = Web.getURI();
		var output = new TemplateResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		
		
		//Lib.println(new TemplateResult(State.indexPage, PageData.getData(), Config.templatesDir));
		
	}
	
	override public function onError(exception : Exception) : Void {		
		//trace(State.indexPage);
		State.messages.errors.push(exception.getMessage());
		
		exception.uri = Web.getURI();
		var output = new TemplateResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		
		//Lib.println(new TemplateResult(State.indexPage, null, Config.templatesDir));
		
	}
	
	
	
}