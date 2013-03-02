package karin.server.controller;
import harfang.controller.AbstractController;
import karin.Context;
import karin.Config;
import neko.Web;
import smd.server.base.result.TemploResult;
/**
 * ...
 * @author Jonas Nyström
 */
class InfoController extends AbstractController
{
	@URL("/info/scorx")
	public function scorx() { 	
		return new TemploResult('info-scorx.mtt', Context, Config.filesPath);
	}		
	
	@URL("/info/kontakt")
	public function kontakt() { 			
		return new TemploResult('info-kontakt.mtt', Context, Config.filesPath);
	}
}