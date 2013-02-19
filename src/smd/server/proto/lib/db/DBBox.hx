package smd.server.proto.lib.db;
import sys.db.Connection;
import sys.db.Object;
import sys.db.TableCreate;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("box")
class DBBox extends Object
{
	public var id			: SId;
	public var label		: SString<32>;
	public var info			: SString<64>;
	private var ids			: SText;
	private var category	: SString<24>;
	private var org			: SString<16>;
	private var ccode		: SString<16>;
	
	
	public function setIds(ids:Array<Int>) {
		this.ids = ids.join(',');
	}
	 
	public function getIds() {
		var a = this.ids.split(',');
		var aInt:Array<Int> = [];
		for (v in a) {
			aInt.push(Std.parseInt(v));
		}
		return aInt;		
	}
	
	public function setCategory(etype:EBoxType) {
		this.category = Std.string(etype);
	}
	
	public function getCategory():EBoxType {
		return Type.createEnum(EBoxType, this.category);
	}
	
	/*
	private function set_ids(ids:Array<Int>) {
		trace('set_ids');
		return this.ids = ids.join(',');
	}
	
	private function get_ids():Array<Int> {
		trace('get_ids');
		var a = this.ids.split(',');
		var aInt:Array<Int> = [];
		for (v in a) {
			aInt.push(Std.parseInt(v));
		}
		return aInt;
	}
	*/
	
	public function toTBox():TBox {
		return {
			id 		: this.id,
			label 	: this.label,
			info 	: this.info,
			org		: this.org,
			ccode	: this.ccode,
			ids 	: this.getIds(),
			category : this.getCategory(),
			
		}
	}
		
	static public function createTable(cnx:sys.db.Connection) {
		if (!TableCreate.exists(DBBox.manager)) TableCreate.create(DBBox.manager);
	}

	
}