package smd.server.sx.controller;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.controller.AbstractController;
import harfang.exceptions.Exception;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.Config;
import smd.server.sx.data.PageData;
import smd.server.sx.State;

/**
 * ...
 * @author Jonas Nyström
 */

class IndexController extends AbstractController
{
	//static private var domainIndexPage:String = WebTools.getDomainInfo().domain + '.html';

	/*
	public function new() {
		this.domainIndexPage = ;
		trace(this.domainIndexPage);
	}
	*/
	
	@URL("^/$")
	public function index() { 			
		return new TemplateResult(State.indexPage, PageData.getData(), Config.templatesDir);
	}
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String = 'default') {			
		return new TemplateResult(State.indexPage, PageData.getData(), Config.templatesDir);
	}
}

