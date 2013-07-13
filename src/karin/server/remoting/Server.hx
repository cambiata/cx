package karin.server.remoting;
import cx3.FileTools;
import haxe.Json;
import haxe.Serializer;
import karin.Config;
import karin.Context;
import karin.db.Devtask;
import karin.db.Gustavuser;
import karin.types.Devintems;
import karin.types.Devitem;
import karin.types.DTasks;
import karin.types.EResult;
import smd.server.proto.lib.user.User;
import smd.server.proto.lib.user.Users;

/**
 * ...
 * @author Jonas Nyström
 */
class Server
{
	public function new() {	}

	public function foo(x, y) { return x + y; }
	
	public function getUser() {
		return Context.user;
	}
	
	public function adminGetAllUsers(id:String) {
		var gusers = Gustavuser.manager.all();		
		var users:Users = new Users();	
		
		for (guser in gusers) {			
			var u = guser.toUser();
			users.push(u);
		}		
		return users;
	}
	
	public function adminGetDTasks()/*:DTasks*/ {
		try { //
			// dtasks data
			var data = FileTools.getContent(Config.filesPath + Config.dtasksFile);
			var dTasks:DTasks = Json.parse(data);
			
			// html template
			var filename = Config.filesPath + 'html/client/devtask.html';			
			var html = FileTools.getContent(filename);	
			
			return EResult.Success(dTasks, html);			
		} catch (e:Dynamic) {
			return EResult.Error(Std.string(e));
		}
		return EResult.Error('SHOULD NOT HAPPEN');
	}
	
	public function siteGetHtml(filename:String) {
		try {
			var filename = Config.filesPath + filename;			
			var html = FileTools.getContent(filename);			
			return EResult.Success(html);
			
			//return EResult.Success('HTML... ' + filename);
		} catch (e:Dynamic) {
			return EResult.Error(Std.string(e));
		}
		return EResult.Error('SHOULD NOT HAPPEN');
		
	}
	
	
	public function adminGetRoadmap() {
		
		var items = Devtask.getAll();
		var devitems:Devintems = new Devintems();
		for (item in items) {
			devitems.push(item.toDevitem());
		}
		return devitems;
	}
	
	/*
	public function adminSetRoadmapItem(item:Devitem):EResult {
		//return 'ITEM: ' + Std.string(item);		
		try {
			Devtask.getCnx();
			var task = Devtask.manager.get(item.id);		
			var newTask:Bool = (task == null);
		
			if (newTask) task = new Devtask();		
		
			task.label = item.label;
			task.prio = item.prio;
			task.info = item.info;
			task.subject = item.subject;
			task.status = item.status;
			task.comment = item.comment;
			if (newTask) task.started = Date.now();
			task.finished = Date.now();
			
			if (newTask) task.insert() else task.update();		

			return (newTask) ? EResult.Insert : EResult.Update ;
		} catch (e:Dynamic) {
			return EResult.Error(Std.string(e));
		}
		return EResult.void;
	}
	
	public function adminDeleteRoadmapItem(id):EResult {		
		try {
			Devtask.getCnx();
			var u = Devtask.manager.get(id);
			if ( u != null ) u.delete();
			return EResult.Delete;
		} catch (e:Dynamic) {
			return EResult.Error(Std.string(e));
		}		
		return EResult.void;		
	}
	*/
	
	
	
	
}