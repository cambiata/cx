package smd.server.sx.controller;
import harfang.controller.AbstractController;

/**
 * ...
 * @author Jonas Nyström
 */

class MediaController extends AbstractController
{

	
	override public function handleBefore()	{
		
	}
	
	@URL("/media")
	public function media() {			
		//this.data.layout = { id:0, text:'list' };
		//return new IndexResult(State.indexPage, this.data, Config.templatesDir);
		return "Media hej hopp";

	}		
	
}