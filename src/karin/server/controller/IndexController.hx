package karin.server.controller;
import cx.FileTools;
import harfang.controller.AbstractController;
import karin.Context;
import neko.Web;

import smd.server.base.result.TemploResult;

/**
 * ...
 * @author Jonas Nyström
 */
class IndexController extends AbstractController
{
	@URL("^/$")
	public function home() { 	
		return new TemploResult('home.mtt', Context, Config.filesPath);
	}		
	
	@URL("/page")
	public function page() { 			
		return new TemploResult('page.mtt', Context, Config.filesPath);
	}
}