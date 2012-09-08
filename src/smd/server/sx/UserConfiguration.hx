package smd.server.sx;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
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
		
		
		ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
		new Functions();
		User.updateUserdata();
		User.getCurrentUser();
		User.checkRedirect();		
		
		
		/*
		this.addModule(new Site());			
		
		ConfigTools.loadConfig(Config, Web.getCwd() + Config.configFile);
		new Functions();
		User.updateUserdata();
		User.getCurrentUser();
		User.checkRedirect();
		*/
		
		//State.messages.infos.push(Std.string(User.user));
		//State.messages.infos.push('Hello World');
		//State.messages.errors.push('This is an error');
		
    }
	
	
    public override function init() {
        super.init();
        this.addModule(new Site());
    }	
		
	
	
	
	override public function onHTTPError(error : HTTPException) : Void {
		
		Lib.println(error.getMessage());
		/*
		State.messages.errors.push(error.getErrorCode() + ': ' + error.getMessage());
		//error.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		*/
	}
	
	
	
	override public function onError(exception : Exception) : Void {		
		Lib.println(exception.getMessage());
		/*
		State.messages.errors.push(exception.getMessage());
		//exception.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		*/
	}
	
	
	
	
}