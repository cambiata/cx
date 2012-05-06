package nx.element;
import nx.element.base.Node;
import nx.element.pre.PreArpeggio;
import nx.element.pre.PreClef;
import nx.enums.ENoteValue;
import nx.enums.ENoteType;

/**
 * ...
 * @author Jonas Nyström
 */

interface INote {
	function getLevelTop():Int;
	function getLevelBottom():Int;	
	function getValue():ENoteValue;
	function getType():ENoteType;
}
 
class Note < T:Head<Dynamic> > extends Node<Head<Dynamic>>
{
	static public function getNew(?children:Array<Head<Dynamic>>, ?value:ENoteValue, ?type:ENoteType, ?text:String) {	
		var item = new Note<Head<Dynamic>>();
		if (children != null) {
			for (child in children) item.add(child);
			item.sortHeads();
		} else {
			item.children.push(Head.getNew());
		}
		
		if (value != null) 		item.value = value;
		if (type != null) 		item.type = type;
		if (text != null) 		item.text = text;
		return item;				
	}	
	
	public var value(default, null):ENoteValue;
	public var text:String;
	public var type:ENoteType;	
	
	public function new() 
	{
		this.children = new Array<Head<Dynamic>>(); 	
		this.value = ENoteValue.Nv4;
		this.type = ENoteType.Normal;
		this.text = '';		
	}
	
	public function getLevelTop():Int {
		return this.first.getLevel();
	}
	
	public function getLevelBottom():Int {
		return this.last.getLevel();
	}	
	
	public function getValue():ENoteValue {
		return this.value;
	}
	
	public function getType():ENoteType {
		return this.type;
	}
	
	private var clef:PreClef; 
	private function setClef(clef:PreClef) {
		this.clef = clef;
		return this;
	}
	private function getClef():PreClef {
		return this.clef;
	}
	
	private var arpeggio:PreArpeggio; 
	private function setArpeggio(arpeggio:PreArpeggio) {
		this.arpeggio = arpeggio;
		return this;
	}
	private function getArpeggio():PreArpeggio {
		return this.arpeggio;
	}
	
	//-----------------------------------------------------------------------------------------------------
	override public function toString():String {
		return super.toString() + '\t' + 'value:' + this.value + ', type:' + this.type;
	}	
	
	private function sortHeads() {
		this.children.sort(function(h1, h2) { 
			return Reflect.compare(h1.getLevel(), h2.getLevel());
		});
	}		
	
}


