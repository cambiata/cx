package smd.server.sx;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import neko.Lib;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.Config;
import smd.server.sx.data.Functions;
import smd.server.sx.data.PageData;
import smd.server.sx.result.IndexResult;
import smd.server.sx.user.User;

import harfang.url.URLDispatcher;

class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
		this.addModule(new Site());			
		
		
		ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
		new Functions();
		User.getCurrentUser();
		User.checkRedirect();
		
		
		//State.messages.infos.push(Std.string(User.user));
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
		
		//Lib.println(error.getMessage());
		
		State.messages.errors.push(error.getErrorCode() + ': ' + error.getMessage());
		//error.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		
	}
	
	
	
	override public function onError(exception : Exception) : Void {		
		Lib.println(exception.getMessage());
		
		State.messages.errors.push(exception.getMessage());
		//exception.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		
	}
	
	
	
	
}