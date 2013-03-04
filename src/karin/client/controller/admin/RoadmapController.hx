package karin.client.controller.admin;
import cx.EnumTools;
import haxe.Json;
import haxe.Template;
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
 
enum Sort {
	None;
	Prio;
	Subject;
}
 
@uri('/admin/roadmap')  
class RoadmapController extends RemotingController {	

	@id private var sortPrio:JQuery;
	@id private var sortSubject:JQuery;
	
	@id private var cbShowReady:JQuery;

	@id private var divItems:JQuery;
	
	private var devitems:Devintems;
	
	public function new() {
		super();
		trace('RoadmapController');		
		this.sort = Sort.None;
		getDTasks();
		
		
		this.cbShowReady.click(function(e) { 			
			trace('h');
			updateDTasks();
			
		} );
		
		this.sortPrio.click(function(e) { 
			this.sort = Sort.Prio;
			updateDTasks();
			} );

		this.sortSubject.click(function(e) { 
			this.sort = Sort.Subject;
			updateDTasks();
			
			} );
			
			
		
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
	private var dtasksTemplate:String; // html
	private var sort:Sort;
	
	private function getDTasks() 
	{
		this.cnx.Server.adminGetDTasks.call([], function(result:EResult) {									
			switch(result) {
				case EResult.Success(data, data2, data3): 
					this.dtasks = data;
					this.dtasksTemplate = data2;
					trace(this.dtasks);
					//trace(this.dtasksTemplate);
					updateDTasks();
				case EResult.Error(msg):
					Lib.alert(msg);
				default:
			}			
		});			
	}	
	
	private function updateDTasks() 
	{		
		var tasks = filterTasks(this.dtasks, getShowReady());				
		//var tasks = this.dtasks;
		
		switch (this.sort) {
			case Sort.Prio:
				tasks.sort (function(a, b) { 				
					return Reflect.compare(a.prio, b.prio);				
				} );
				tasks.reverse();
			case Sort.Subject: 
				tasks.sort (function(a, b) { 				
					return Reflect.compare(a.subject + a.title, b.subject + b.title);				
				} );
			default:
		}
		
		var context = { tasks:tasks, showReady:getShowReady() };
		var html = new Template(this.dtasksTemplate).execute(context);
		this.divItems.html(html);			
	}
	
	private function filterTasks(tasks:DTasks, showReady:Bool) {
		if (!showReady) {
			tasks = Lambda.filter(tasks, function(task) { 
				return task.prio != 0;
			} ).array();
		}
		
		return tasks;
	}
	
	private function getShowReady():Bool {
		return this.cbShowReady.is(':checked');
	}
	
}