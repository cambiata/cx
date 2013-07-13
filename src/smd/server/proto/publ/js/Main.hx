package smd.server.proto.publ.js;

import cx.JQueryTools;
import cx.PathTools;
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
import sx.db.tables.TUserBox;
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

class MainController extends JQController {
	private var domain:String;
	private var contextTransfer:ContextTransfer;
	
	public function new() {
		this.domain = Lib.document.domain;
		var contextTransferData = Reflect.field(Lib.window, ContextTransferTool.transferDataTag);		
		this.contextTransfer = Unserializer.run(contextTransferData);
		super();
	}	
	
	private function ajaxRequest(uri:String) : ServiceResult {
		var host = PathTools.addSlash('http://service.' + this.domain);
		var url = host + uri;
		var data = Http.requestUrl(url);	
		//var result:ServiceResult = Unserializer.run(data);
		var result:ServiceResult = Json.parse(data);
		return result;
	}
}

class HomeController extends MainController {
	public function new() {
		super();
		trace('HomeController');
		//trace(this.contextTransfer.userSub.category);
		//trace(UserCategory.Admin);
		if (this.contextTransfer.userSub == null) {
			// nothing
		} else if (this.contextTransfer.userSub.category == UserCategory.Deltagare) initDeltagare(this.contextTransfer);		
	}	
	
	//----------------------------------------------------------------
	
	private var btnScorxList:JQuery;
	private var tbodyScorxList:JQuery;	
	private var btnLoadBoxes:JQuery;
	private var divBoxes:JQuery;
	private var divBoxinfo:JQuery;
	
	
	
	private function initDeltagare(contextTransfer:ContextTransfer) {
		trace('INIT DELTAGARE');
		btnScorxList = new JQuery('#btnScorxList');
		btnScorxList.click(updateScorxList);		
		tbodyScorxList = new JQuery('#tbodyScorxList');
		btnLoadBoxes = new JQuery('#btnLoadBoxes');
		btnLoadBoxes.click(updateBoxes);
		divBoxes = new JQuery('#divBoxes');
		divBoxinfo = new JQuery('#divBoxinfo');
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
	
	private function displayListExamples(listExamples:TListExamples, userBox:TUserBox=null) {
		var html = ''; 
		for (key in listExamples.keys()) {
			var item = listExamples.get(key);				
			html += Std.format('<tr><td ><small>${item.bes}<br/>${item.ack}</small></td><td><b>${item.title}</b> <small>${item.subtitle}</small><br/><small>${item.originatorshorts.join(" • ")}</small></td></tr>');
		}
		tbodyScorxList.html(html);		
		
		this.divBoxinfo.html('');	
		
		trace(userBox);
		
		//this.divBoxinfo.html('');
		//this.divBoxinfo.hide(1);
		this.divBoxinfo.removeAttr('class');

		if (userBox == null) {
			
		} else {
			
			var html = '';		
			//Std.format('<div class="boxinfo ${userBox.box.org}">') +
			html += Std.format('	<img class="pull-right" src="/img/${userBox.box.org}.png" />');
			html += Std.format('	<p class="boxtitle">${userBox.box.label}</p>');
			html += Std.format('	<p>${userBox.box.info}</p>');
			//html += Std.format('	Materialet tillgängligörs genom att du är deltagare i kursverksamhet organiserad av <b>${userBox.box.org}</b>. Du behöver känna till att...</p>');
			//Std.format('</div>');
			trace(html);
			this.divBoxinfo.html(html);
			this.divBoxinfo.addClass('boxinfo');
			this.divBoxinfo.addClass(userBox.box.org);			
		}
		
		
		
	}
	
	private function updateBoxes(e = null) {	
		var uri = 'user/boxes/' + this.contextTransfer.userSub.id;
		var result:ServiceResult = ajaxRequest(uri);		
		var userBoxes:TUserBoxes = Unserializer.run(result.data);
		trace(Std.string(userBoxes));
		divBoxes.html('');
		var i = 0;
		for (userBox in userBoxes) {
			var boxId:String = userBox.box.id;
			var label:String = userBox.box.label;
			var html = Std.format('<a class="${userBox.box.org} shortcutx" href="#" id="linkBox${boxId}"><span class="shortcut-label" id="linkBox${boxId}"><b id="linkBox${boxId}">${label}</b><br/><small id="linkBox${boxId}">${userBox.box.info} (${userBox.box.ccode})</small></span></a>');
			//var html = Std.format('<a class="btn btn-block" href="#" id="linkBox${boxId}"><span class="shortcut-label" id="linkBox${boxId}"><b id="linkBox${boxId}">${label}</b><br/><small id="linkBox${boxId}">${userBox.box.info} (${userBox.box.ccode})</small></span></a>');
			divBoxes.append(html);			
			var linkBox = new JQuery('#linkBox' + boxId);
			linkBox.click(clickLinkBox);
			i++;
		}
	}
	
	private function clickLinkBox(e = null) {
		var id = Std.string(e.target.id).replace('linkBox', '');
		loadBox(id);
	}
	
	private function loadBox(boxid:String) {
		var uri = 'user/box/' + this.contextTransfer.userSub.id + '/' + boxid;
		var result:ServiceResult = ajaxRequest(uri);	
		trace(result);
		var userBox:TUserBox = Unserializer.run(result.data);		
		trace(userBox);
		
		//var userBox:TUserBox = userBoxes.shift();
		var listExamples:TListExamples = Unserializer.run(result.data2);
		//trace(listExamples);
		displayListExamples(listExamples, userBox);
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


