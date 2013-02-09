package sx.db.tables;
import sys.db.Object;
import sys.db.Types;
/**
 * ...
 * @author Jonas Nyström
 */

@:table("box")
@:index(id,unique)
class DBBox extends Object
{
	public var id			: SString<24>;
	public var info			: SString<48>;
	private var ids			: SText;
	private var category	: SString<24>;
	
	
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
			id : this.id,
			info : this.info,
			ids : this.getIds(),
			category : this.getCategory(),
		}
	}
	

	
}