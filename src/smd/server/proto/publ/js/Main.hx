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
import smd.server.proto.ContextTransfer;
import smd.server.proto.ContextTransfer.ContextTransferTool;
import smd.server.proto.service.ServiceResult;
import smd.server.proto.User.UserCategory;
import sx.db.tables.TBox;
import sx.db.tables.TUserBoxes;
import sx.type.TListExamples;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class Main {
	static function main() {				
		
		var context = new Context([PageController, HomeController]);
	}	
}

class UserController extends JQController {
	private var domain:String;
	private var contextTransfer:ContextTransfer;
	
	public function new() {
		this.domain = Lib.document.domain;
		var contextTransferData = Reflect.field(Lib.window, ContextTransferTool.transferDataTag);		
		this.contextTransfer = Unserializer.run(contextTransferData);
		trace(this.contextTransfer);
		super();
	}	
}

class HomeController extends UserController {
	
	public function new() {
		super();
		trace('HomeController');
		//trace(this.contextTransfer.userSub.category);
		//trace(UserCategory.Admin);
		if (this.contextTransfer.userSub == null) {
			// nothing
		} else if (this.contextTransfer.userSub.category == UserCategory.Admin) initAdmin(this.contextTransfer);		
	}	
	
	override private function onHashChange(hash:String) {
		if (this.contextTransfer.userSub == null) {
			// nothing
		} else if (this.contextTransfer.userSub.category == UserCategory.Admin) onHashChangeAdmin(hash);
	}
	
	private var btnScorxList:JQuery;
	private var tbodyScorxList:JQuery;	
	private var btnLoadBoxes:JQuery;
	private var divBoxes:JQuery;
	
	private function initAdmin(contextTransfer:ContextTransfer) {
		trace('INIT ADMIN');
		btnScorxList = new JQuery('#btnScorxList');
		btnScorxList.click(updateScorxList);
		
		tbodyScorxList = new JQuery('#tbodyScorxList');
		btnLoadBoxes = new JQuery('#btnLoadBoxes');
		btnLoadBoxes.click(updateBoxes);
		divBoxes = new JQuery('#divBoxes');
		
		//--------------------------
		// invoke on display
		updateBoxes(); 		
		updateScorxList();
	}	
	
	
	private function updateScorxList(e=null) {		
		var data = Http.requestUrl('_files/data/scorxlist.data');			
		var listExamples:TListExamples = Unserializer.run(data);
		displayListExamples(listExamples);
	}
	
	private function displayListExamples(listExamples:TListExamples) {
		var html = ''; 
		for (key in listExamples.keys()) {
			var item = listExamples.get(key);				
			html += Std.format('<tr><td>${item.bes}<br/>${item.ack}</td><td><b>${item.title}</b> ${item.subtitle}<br/>${item.originatorshorts.join(" • ")}</td></tr>');
		}
		tbodyScorxList.html(html);		
	}
	
	
	private var linkBoxes:Array<JQuery>;
	
	private function updateBoxes(e = null) {	
		Lib.alert('update boxes');
		this.linkBoxes = [];
		var uri = 'user/boxes/' + this.contextTransfer.userSub.id;
		var url = 'http://service.' + this.domain + '/' + uri;
		trace(url);
		var data = Http.requestUrl(url);	
		var result:ServiceResult = Unserializer.run(data);
		trace(result);
		var userBoxes:TUserBoxes = Unserializer.run(result.data);
		trace(Std.string(userBoxes));
		
		divBoxes.html('');
		
		var i = 0;
		for (userBox in userBoxes) {
			var boxId:String = userBox.box.id;
			var html = Std.format('<a class="shortcut" href="#" id="linkBox${boxId}"><i class="shortcut-icon icon-list-alt" id="linkBox${boxId}"></i><span class="shortcut-label" id="linkBox${boxId}">${boxId}</span></a>');
			divBoxes.append(html);			
			var linkBox = new JQuery('#linkBox' + boxId);
			linkBox.click(clickLinkBox);
			i++;
		}
	}
	
	private function clickLinkBox(e = null) {
		var id = Std.string(e.target.id).replace('linkBox', '');
		//Lib.alert(id);
		loadBox(id);
	}
	
	private function loadBox(boxid:String) {
		var uri = 'user/box/' + this.contextTransfer.userSub.id + '/' + boxid;
		var url = 'http://service.' + this.domain + '/' + uri;
		var data = Http.requestUrl(url);	
		var result:ServiceResult = Unserializer.run(data);		

		var userBoxes:TUserBoxes = Unserializer.run(result.data);		
		trace(userBoxes);
		var listExamples:TListExamples = Unserializer.run(result.data2);
		trace(listExamples);
		displayListExamples(listExamples);
	}
	
	
	private var ajaxHeader:JQuery;
	private var ajaxContent:JQuery;	
	private function onHashChangeAdmin(hash:String) {		
		if (hash == null || hash == 'null') return;
		trace('onHashChangeAdmin ' + hash);
		this.ajaxHeader = new JQuery('#ajaxHeader');
		this.ajaxContent = new JQuery('#ajaxContent');		
		this.ajaxHeader.html(hash);
		trace(this.domain);
		var suburl = StringTools.replace(hash, '#', '');
		var url = 'http://service.' + this.domain + '/' + suburl;
		trace(url);
		var html = Http.requestUrl(url);
		
		this.ajaxContent.html(html);
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


