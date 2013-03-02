package karin.client.controller.admin;
import cx.EnumTools;
#if haxe3
import js.Browser;
#else

#end

import karin.db.Devtaskprio;
import karin.db.Devtaskprio.DevtaskprioTool;
import karin.types.Devintems;
import karin.types.Devitem;
import karin.types.EResult;
import micromvc.client.JQController;

import smd.server.proto.lib.user.User;
import js.Lib;
import js.JQuery;
import smd.server.proto.lib.user.Users;
import karin.db.Devtaskstatus;
import karin.db.Devtasksubject;

/**
 * ...
 * @author Jonas Nyström
 */

 using StringTools;
 using Lambda;
 using cx.EnumTools;
 using karin.db.Devtaskprio.DevtaskprioTool;
 using karin.db.Devtasksubject.DevtasksubjectTool;
 using karin.db.Devtaskstatus.DevtaskstatusTool;
 
@uri('/admin/roadmap')  
class RoadmapController extends RemotingController {	

	@id private var button1:JQuery; 	
	@id private var tableItems:JQuery;
	@id private var tableStatus:JQuery;
	
	@id private var nId:JQuery;
	@id private var nPrio:JQuery;
	@id private var nSubject:JQuery;
	@id private var nStatus:JQuery;
	@id private var nLabel:JQuery;
	@id private var nInfo:JQuery;
	@id private var nCreate:JQuery;
	
	@id private var sortPrio:JQuery;
	@id private var sortStatus:JQuery;
	@id private var sortSubject:JQuery;
	@id private var sortDate:JQuery;
	
	@id private var btnCreate:JQuery;
	@id private var modTask:JQuery;
	
	
	private var devitems:Devintems;
	
	public function new() {
		super();
		trace('RoadmapController');	
		getRoadmap();		
		initForm();
		
		this.sortPrio.click(function(e) {
			fsortPrio();
			updateRoadmap();
		} );
		
		this.sortSubject.click(function(e) {
			fsortSubject();
			updateRoadmap();
		} );		
		
		this.sortStatus.click(function(e) {
			fsortStatus();
			updateRoadmap();
		} );
		
		this.btnCreate.click(function(e) {
			initForm();
			showModal();
		});
		
	}
	
	private function fsortSubject() {
		
		devitems.sort(function(a, b) return Reflect.compare(Std.string(a.subject.getIndex()) + a.label, Std.string(b.subject.getIndex()) + b.label));				
	}
	
	private function fsortPrio() {
		
		//devitems.sort(function(a, b) return Reflect.compare(DevtaskprioTool.getIndex(a.prio), DevtaskprioTool.getIndex(b.prio)));		
		devitems.sort(function(a, b) return Reflect.compare(a.prio.getIndex(), b.prio.getIndex()));		
	}
	
	private function fsortStatus() {
		devitems.sort(function(a, b) return Reflect.compare(a.status.getIndex(), b.status.getIndex()));		
	}
	
	private function initForm() 
	{
		this.nPrio.html('');
		var html = '';
		for (opt in Type.getEnumConstructs(Devtaskprio)) {
			html += Std.format('<option value="$opt" >$opt</option>');
		}
		this.nPrio.append(html);
		
		this.nSubject.html('');
		var html = '';
		for (opt in Type.getEnumConstructs(Devtasksubject)) {
			html += Std.format('<option value="$opt" >$opt</option>');
		}
		this.nSubject.append(html);		

		this.nStatus.html('');
		var html = '';
		for (opt in Type.getEnumConstructs(Devtaskstatus)) {
			html += Std.format('<option value="$opt" >$opt</option>');
		}
		this.nStatus.append(html);			
		
		this.nCreate.click(function(e) { 			
			var item:Devitem = {
				id: Std.parseInt(this.nId.val()),
				label: this.nLabel.val(),
				info: this.nInfo.val(),
				prio: EnumTools.createFromString(Devtaskprio, this.nPrio.val()),
				subject: EnumTools.createFromString(Devtasksubject, this.nSubject.val()),
				status: EnumTools.createFromString(Devtaskstatus, this.nStatus.val()),
				started: null,
				finished: null,
				comment: null,
			}
			
			/*
			var info = this.nInfo.val();
			var status = this.nStatus.val();
			var prio = this.nPrio.val();
			trace([label, info, status, prio]);
			*/
			
			if (item.label == '') {
				Lib.alert('Ange en titel för momentet');
				return;
			}
			
			if (item.info == '') {
				Lib.alert('Ange kortfattad info för momentet');
				return;
			}
			
			this.cnx.Server.adminSetRoadmapItem.call([item], function(result:EResult) {			
				trace('Result: ' + result);		
				
				switch (result) {
					case EResult.Insert:
						hideModal();						
						getRoadmap();
					case EResult.Update:						
						hideModal();						
						getRoadmap();
						//Lib.alert('Examplet är uppdaterat');
					case EResult.Error(msg): {
						Lib.alert(msg);
					}
					default:
				}
				
			});				
			
		} );
		
	}
	
	private function getRoadmap() {
		this.cnx.Server.adminGetRoadmap.call([], function(devitems:Devintems) {			
			this.devitems = devitems;
			//sortSubject();
			updateRoadmap();
		});	
	}
	
	private function updateRoadmap() {
		var html = '';
		for (item in this.devitems) {			
			html += Std.format(
			'<tr>
			<td class="${item.status}-${item.prio}">${item.prio}</td>
			<td  class="${item.status}"><b>${item.subject} - ${item.label}</b><br/>${item.info}</td>
			<td class="${item.status}">${item.status}</td>
			<td class="${item.status}">${item.started}<br/>${item.finished}</td>
			<td  >
				<a id="editItem${item.id}" >Edit</a>
				<a id="delItem${item.id}">Del</a>
			</td>
			<tr>');
		}
		this.tableItems.html(html);
		
		var editItems = new JQuery("[id^=editItem]");
		editItems.click(function(e) {
			var id = Std.parseInt(e.target.id.replace('editItem', ''));
			editItem(id);
		});

		var delItems = new JQuery("[id^=delItem]");
		delItems.click(function(e) {
			
			#if haxe3
			if (! Browser.window.confirm('Vill du ta bort detta utvecklingssteg?')) return;
			#else
			if (! Lib.window.confirm('Vill du ta bort detta utvecklingssteg?')) return;
			#end
			
			
			var id = e.target.id.replace('delItem', '');			
			delItem(id);
		});
	}
	
	private function editItem(id) {
		
		var items = Lambda.filter(this.devitems, function(i) { 
			return (i.id == id);
			} ).array();
			
		var item = items[0];			
		trace(item);
		
		this.nId.val(Std.string(item.id));
		this.nLabel.val(item.label);
		this.nInfo.val(item.info);
		this.nPrio.val(Std.string(item.prio));
		this.nStatus.val(Std.string(item.status));
		this.nSubject.val(Std.string(item.subject));
		trace('edit');
		showModal();
	}
	
	private function delItem(id) {
		this.cnx.Server.adminDeleteRoadmapItem.call([id], function(result:EResult) {				
			switch(result) {
				case EResult.Delete:
					getRoadmap();
				case EResult.Error(msg):
					Lib.alert(msg);
				default:
			}
			
		});
		
	}
	
	private function showModal() {
		trace('show');
		untyped __js__("$('#modTask').modal('show')");
	}
	
	private function hideModal() {
		untyped __js__("$('#modTask').modal('hide')");
	}
}