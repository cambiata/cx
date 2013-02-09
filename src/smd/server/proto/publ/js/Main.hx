package smd.server.proto.publ.js;

import cx.JQueryTools;
import haxe.Http;
import haxe.Json;
import haxe.Log;
import haxe.Unserializer;
import js.Cookie;
import js.JQuery;
import js.Lib;
import micromvc.client.Context;
import micromvc.client.Controller;
import micromvc.client.JQController;
import smd.server.proto.base.Message;
import smd.server.proto.UserTransfer;
import sx.type.TListExamples;

/**
 * ...
 * @author Jonas Nyström
 */

class Main {
	static function main() {				
		
		var context = new Context([PageController, HomeController]);
	}	
}

class UserController extends JQController {
	private var userTransfer:UserTransfer;
	public function new() {
		var userData = untyped Lib.window.userdata;
		var userTransfer:UserTransfer = Unserializer.run(userData);
		this.userTransfer = userTransfer;
		trace('userTransfer: ' + userTransfer);
		super();
	}	
}

class HomeController extends UserController {
	
	public function new() {
		super();
		trace('HomeController');
		switch(this.userTransfer.category) {
			case 'Admin': initAdmin(userTransfer);
			default: 
		}
	}	
	
	private var btnScorxList:JQuery;
	private var tbodyScorxList:JQuery;	
	
	private function initAdmin(userTransfer:UserTransfer) {
		trace('INIT ADMIN');
		btnScorxList = new JQuery('#btnScorxList');
		tbodyScorxList = new JQuery('#tbodyScorxList');
		btnScorxList.click(updateScorxList);
		updateScorxList(); // onvoke on display
	}	
	
	private function updateScorxList(e=null) {		
		var data = Http.requestUrl('_files/data/scorxlist.data');			
		var listExamples:TListExamples = Unserializer.run(data);
		//trace(listExamples);	
		var html = ''; 
		for (key in listExamples.keys()) {
			var item = listExamples.get(key);				
			html += Std.format('<tr><td>${item.bes}<br/>${item.ack}</td><td><b>${item.title}</b> ${item.subtitle}<br/>${item.originatorshorts.join(" • ")}</td></tr>');
		}
		//tbodyScorxList.append(html);		
		tbodyScorxList.html(html);
	}
	
}

@uri('/page/')
class PageController extends JQController {
	@id public var test:JQuery;
	@id public var btnTest:JQuery;
	
	public function new() {
		super();
		this.test.html('HEHE!');
		this.btnTest.click(function(e) {			
			var data = Http.requestUrl('_files/data/scorxlist.data');			
			var listExamples:TListExamples = Unserializer.run(data);
			trace(listExamples);
		});
	}
}


