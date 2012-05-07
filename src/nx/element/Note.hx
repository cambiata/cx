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
	function getText():String;
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
	
	
	public function new() 
	{
		this.children = new Array<Head<Dynamic>>(); 	
		this.value = ENoteValue.Nv4;
		this.type = ENoteType.Normal;
		this.text = '';		
	}
	
	public function getChildren():Array<Head<Dynamic>> {
		return this.children;
	}
	
	public function getLevelTop():Int {
		return this.first.getLevel();
	}
	
	public function getLevelBottom():Int {
		return this.last.getLevel();
	}	
	
	public var value(default, null):ENoteValue;
	public function getValue():ENoteValue {
		return this.value;
	}
	
	public var type:ENoteType;
	public function getType():ENoteType {
		return this.type;
	}
	
	private var clef:PreClef; 
	public function setClef(clef:PreClef) {
		this.clef = clef;
		return this;
	}
	public function getClef():PreClef {
		return this.clef;
	}
	
	private var arpeggio:PreArpeggio; 
	public function setArpeggio(arpeggio:PreArpeggio) {
		this.arpeggio = arpeggio;
		return this;
	}
	public function getArpeggio():PreArpeggio {
		return this.arpeggio;
	}
	
	private var text:String;
	public function setText(text:String) {
		this.text = text;
		return this;
	}
	
	public function getText():String {
		return this.text;
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
	
	//-----------------------------------------------------------------------------------------------------
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement('note');				
		
		for (head in this.children) {
			var headXml = head.toXml();
			xml.addChild(headXml);
		}
		
		xml.set('value', Std.string(this.getValue().value));
		xml.set('type', Std.string(this.getType()));			
		xml.set('text', Std.string(this.getText()));			
		
		return xml;
	}
	
	static public function fromXml(xmlStr:String):Note<Head<Dynamic>> {
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var heads = new Array<Head<Dynamic>>();
		
		for (h in xml.elementsNamed('head')) {
			var head = Head.fromXml(h.toString());
			heads.push(head);
		}

		var text:String;
		try text = xml.get('text');			
		
		var value:ENoteValue= null;
		var int = Std.parseInt(xml.get('value'));
		if (int != null) try value = ENoteValue.getFromValue(int);		
		
		var type:ENoteType = null;
		var str = xml.get('type');
		if (str != null) try type = Type.createEnum(ENoteType, str);
		
		var note = Note.getNew(heads, value, type, text);
		
		return note;
	}	
	
	
}


