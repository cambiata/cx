package smd.server.sxjs.controller;
import cx.TimerTools;
import haxe.Http;
import haxe.Unserializer;
import smd.server.sxjs.MainController;

import sx.type.TListExample;
import sx.type.TListExamples;
import smd.server.sxjs.widget.scorx.Scorxitem;
import sx.type.TOriginatorshorts;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
class ScorxlistController extends Controller
{		
	private var main:MainController;
	private var ulScorxlist:DOMCollection;
	private var inputSearchTitle:DOMCollection;	
	private var searchTitle:String = '';
	private var listexamples:TListExamples;
	
	public function new(main:MainController) {
		trace('ScorxlistController');
		this.main = main;
		this.ulScorxlist = this.findElement('#scorxlist');
		this.inputSearchTitle = this.findElement('#searchTitle');
		this.inputSearchTitle.keydown(onSearchTitle);		
		var data = Http.requestUrl('/sx/list');
		this.listexamples = Unserializer.run(data);	
		
		//trace(this.listexamples);
		
		this.updateScorxitems();
	}
	

	
	private function removeScorxitems() {
		var liScorxitems = this.ulScorxlist.find('#scorxitem');
		this.ulScorxlist.removeChildren(null, liScorxitems);
	}
	
	private function addScorxitems(listexamples:TListExamples) {
		var ids = listexamples.keys();
		for (id in ids) {
			var listexample = listexamples.get(id);
			var scorxitem = new Scorxitem(this.main, listexample);
			//var sdi = new ScorxDataItem(listexample);
			//var sdw = new ScorxDataWidget(sdi);
			this.ulScorxlist.append(scorxitem);
		}				
	}
	
	private function filterListexamples(listexamples:TListExamples, searchTitle:String=''):TListExamples {
		var result = new TListExamples();		
		
		searchTitle = searchTitle.toLowerCase();
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			
			if (searchTitle != '') {
				var indexOf = listexample.title.toLowerCase().indexOf(searchTitle);
				if (indexOf >= 0) {
					result.set(id, listexample);
				}				
			} else {
				result.set(id, listexample);
			}
			
		}

		return result;
	}
	
	private function onSearchTitle (e) {
		TimerTools.timeout(function () { 
			this.searchTitle = this.inputSearchTitle.val();
			updateScorxitems();
		} );
	}
	
	private function updateScorxitems() {
		var listexamples = this.filterListexamples(this.listexamples, this.searchTitle);
		removeScorxitems();
		addScorxitems(listexamples);
	}	
	
	
	
}



 
 