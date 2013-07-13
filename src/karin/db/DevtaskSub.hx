package karin.db;

import sys.db.Connection;
import sys.db.Types;
import sys.db.Object;

/**
 * ...
 * @author Jonas Nyström
 */


// @:table("tablename") 						// use custom table name
// @:index(field1,field2,...,[unique])			// create index for fields
// @:id(gid,uid) 								// create unique index for multi fields
class DevtaskSub extends Object 
{
	
	public var id:								SId;
	@:relation(devtaskId) public var devtask: 	Devtask;
 	public var label:							SString<128>;
	
	public var date:							SDate;
	public var prio:							SEnum<Devtaskprio>;
	public var status:							SEnum<Devtaskstatus>;
	
	
	// @:skip public var nonDbField: Int;		// don't use in db
	
	//--------------------------------------------------------------------
	
	static public function deleteAll(cnx:Connection) {
		var sql = 'DELETE FROM "DevtaskSub"';
		cnx.request(sql);
	}	
	
	static public function create() {
		if ( !TableCreate.exists(DevtaskSub.manager) )  TableCreate.create(DevtaskSub.manager);	
	}	
	
	
}