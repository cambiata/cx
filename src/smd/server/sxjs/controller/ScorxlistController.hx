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
	private var listexamples:TListExamples;

	private var inputSearchTitle:DOMCollection;
	private var inputSearchBes:DOMCollection;
	private var inputSearchOrig:DOMCollection;
	
	private var searchTitle:String = '';
	private var searchBes:String = '';
	private var searchOrig:String = '';
	
	public function new(main:MainController) {
		//trace('ScorxlistController');
		this.main = main;
		this.ulScorxlist = this.findElement('#scorxlist');

		this.inputSearchTitle = this.findElement('#searchTitle');
		this.inputSearchTitle.keydown(onSearchTitle);		
		
		this.inputSearchBes = this.findElement('#searchBes');
		this.inputSearchBes.keydown(onSearchBes);		
		
		this.inputSearchOrig = this.findElement('#searchOrig');
		this.inputSearchOrig.keydown(onSearchOrig);		
		
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
	
	private function filterListexamples(listexamples:TListExamples, searchTitle:String='', searchBes='', searchOrig=''):TListExamples {
		var result = new TListExamples();		
		
		if (searchTitle != '') listexamples = filterTitle(listexamples, searchTitle);		
		if (searchBes != '') listexamples = filterBes(listexamples, searchBes);
		if (searchOrig != '') listexamples = filterOrig(listexamples, searchOrig);
		
		return listexamples;
	}
	
	private function filterTitle(listexamples:TListExamples, searchTitle:String = '') {
		var result = new TListExamples();		
		if (searchTitle == '') return listexamples;
		
		searchTitle = searchTitle.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			var indexOf = listexample.title.toLowerCase().indexOf(searchTitle);
			if (indexOf >= 0) {
				result.set(id, listexample);
			}				
		}
		return result;		
	}
	
	private function filterBes(listexamples:TListExamples, searchBes:String = '') {
		var result = new TListExamples();		
		if (searchBes == '') return listexamples;
		
		searchBes = searchBes.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			if (listexample.bes != null) {
				var indexOf = listexample.bes.toLowerCase().indexOf(searchBes);
				if (indexOf >= 0) {
					result.set(id, listexample);
				}				
			}
		}
		return result;		
	}	
	
	private function filterOrig(listexamples:TListExamples, searchOrig:String = '') {
		var result = new TListExamples();		
		if (searchOrig == '') return listexamples;
		
		searchOrig = searchOrig.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			if (listexample.originatorshorts != null) {
				var indexOf = listexample.originatorshorts.join(' ').toLowerCase().indexOf(searchOrig);
				if (indexOf >= 0) {
					result.set(id, listexample);
				}				
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
	
	private function onSearchBes (e) {
		TimerTools.timeout(function () { 
			this.searchBes = this.inputSearchBes.val();
			updateScorxitems();
		} );
	}	
	
	private function onSearchOrig (e) {
		TimerTools.timeout(function () { 
			this.searchOrig = this.inputSearchOrig.val();
			updateScorxitems();
		} );
	}
	
	private function updateScorxitems() {
		var listexamples = this.filterListexamples(this.listexamples, this.searchTitle, this.searchBes, this.searchOrig);
		removeScorxitems();
		addScorxitems(listexamples);
	}	
	
	
	
}



 
 