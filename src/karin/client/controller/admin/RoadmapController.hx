package karin.client.controller.admin;
import cx.EnumTools;
import haxe.Json;
import karin.types.DTasks;
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

	@id private var sortPrio:JQuery;
	@id private var sortStatus:JQuery;
	@id private var sortSubject:JQuery;
	@id private var sortDate:JQuery;
	
	@id private var divItems:JQuery;
	
	private var devitems:Devintems;
	
	public function new() {
		super();
		trace('RoadmapController');		
		getDTasks();
	}
	
	/*
	private function fsortSubject() {
		devitems.sort(function(a, b) return Reflect.compare(Std.string(a.subject.getIndex()) + a.label, Std.string(b.subject.getIndex()) + b.label));				
	}	
	
	private function fsortPrio() {
		devitems.sort(function(a, b) return Reflect.compare(a.prio.getIndex(), b.prio.getIndex()));		
	}
	
	private function fsortStatus() {
		devitems.sort(function(a, b) return Reflect.compare(a.status.getIndex(), b.status.getIndex()));		
	}
	*/
	
	private var dtasks:DTasks;
	
	private function getDTasks() 
	{
		this.cnx.Server.adminGetDTasks.call([], function(result:EResult) {									
			switch(result) {
				case EResult.Success(data): 
					this.dtasks = data;
					trace(this.dtasks);
					updateDTasks();
				case EResult.Error(msg):
					Lib.alert(msg);
				default:
			}			
		});			
	}	
	
	private function updateDTasks() 
	{		
		var html = '';
		for (item in this.dtasks) {			
			html += '<div class="tasks">';
			html += Std.format('
				<div class="task">
					<p><span class="tasktitle">${item.subject} - ${item.title}</span><br/>${item.info}</p>
				</div>
			');
			if (item.comments.length > 0) {
				html += '<div class="task"><table class="table" style="margin-bottom:4px;">';
				for (comment in item.comments) {
					html += Std.format(
					'<tr>					
					<td >${comment.info}</td>
					<td >${comment.prio}</td>
					<td >${comment.date}</td>
					<td >${comment.sign}</td>
					</tr>');
				}
				html += '</table></div>';
			}
			html += '</div>';
		}		
		this.divItems.html(html);	
	}
	
}