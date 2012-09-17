package smd.server.sx.controller;
import harfang.controller.AbstractController;
import haxe.Json;
import smd.server.sx.Config;
import smd.server.sx.data.ScorxData;
import smd.server.sx.Site;
import smd.server.sx.State;
import smd.server.sx.result.IndexResult;
import sx.type.TListExample;

/**
 * ...
 * @author Jonas Nyström
 */

class MediaController extends AbstractController
{

	
	override public function handleBefore()	{
		
	}
	
	@URL("/sx/info/([a-zA-Z0-9/]+)$")
	public function sxinfo(param = '') {		
		var param = param.substr(0, -1);
		var scorxid = Std.parseInt(param);
		return "SX Info " + scorxid;
	}		
	
	@URL("/sx/list")
	public function sxlist() {			
		var domainkategori = "#" + State.domaintag;
		var ids = ScorxData.getScorxtillgangligheterIds(domainkategori);
		var listexamples = ScorxData.getListexamples(ids);
		
		var scorxitems = new Array<TListExample>();
		
		for (id in listexamples.keys()) {
			scorxitems.push(listexamples.get(id));
		}
		
		/*
		var data = { scorxitems:scorxitems };
		return new IndexResult(Config.scorxlistPage, data);
		*/
		
		return Json.stringify(scorxitems);
		
		//return "SX List";
	}		
	
	@URL("/sx/")
	public function sx() {			
		return "SX";
	}	
	
	
}