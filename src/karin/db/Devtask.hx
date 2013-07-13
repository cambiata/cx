package karin.db;

import cx3.ConfigTools;
import karin.Config;
import karin.types.Devitem;
import sys.db.Connection;
import sys.db.Sqlite;
import sys.db.Types;
import sys.db.Object;
import sys.db.Manager;
import sys.db.TableCreate;

/**
 * ...
 * @author Jonas Nyström
 */

class Devtask extends Object 
{
	
	
	
	public var id: 				SId;
	public var subject:			SEnum<Devtasksubject>;
 	public var label: 			SString<24>;
	public var info:			SString<128>;
	public var started: 		SNull<SDate>;
	public var finished: 		SNull<SDate>;
	public var status: 			SEnum<Devtaskstatus>;
	public var comment: 		SNull<SString<128>>;
	public var prio:			SEnum<Devtaskprio>;
	
	static public function deleteAll() {
		var sql = 'DELETE FROM "main"."Devtask"';
		DB.cnx.request(sql);
	}	
	
	static public function create() {
		if ( !TableCreate.exists(Devtask.manager) )  TableCreate.create(Devtask.manager);	
	}
	
	static public var cnx:Connection = getCnx();
	
	static public function getCnx():Connection {		
		ConfigTools.loadConfig(Config, Config.configFile);
		var dbFile = Config.filesPath + Config.devtasksDbFile;		
		var cnx = Sqlite.open(dbFile);
		Manager.cnx = cnx;		
		return cnx;
	}
	
	static public function getAll() {
		getCnx();
		var devtasks = Devtask.manager.all();
		return devtasks;				
	}
	
	public function toDevitem():Devitem {
		var item:Devitem = {
			id:			this.id,
			prio:		this.prio,
			subject:	this.subject,
			label:		this.label,
			info:		this.info,
			started:	this.started,
			finished:	this.finished,
			status:		this.status,
			comment:	this.comment,
		}
		return item;
	}
	
}

