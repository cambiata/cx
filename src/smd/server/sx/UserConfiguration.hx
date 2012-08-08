package smd.server.sx;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import neko.Lib;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.config.Config;

class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
		this.addModule(new Site());			
		
		ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
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
		error.uri = Web.getURI();
		var output = new TemplateResult('error/httpError.html', error, Config.templatesDir).execute();
		Lib.print(output);
	}
	
	override public function onError(exception : Exception) : Void {		
		exception.uri = Web.getURI();
		var output = new TemplateResult('error/Error.html', exception, Config.templatesDir).execute();
		Lib.print(output);
	}
	
	
	
}