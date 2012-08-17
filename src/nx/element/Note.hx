package nx.element;
import cx.EnumTools;
import nx.Constants;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Note  
{

	public function new(heads:Iterable<Head>=null, notevalue:ENoteValue=null, direction:EDirectionUAD=null, type:ENoteType=null, text='') {
		this.heads 				= (heads != null) ? Lambda.array(heads) : [new Head()];
		this.notevalue		= (notevalue != null) ? notevalue : ENoteValue.Nv4;
		this.direction 			= (direction != null) ? direction : EDirectionUAD.Auto;
		this.type				= (type != null) ? type : ENoteType.Normal ;
		this.text				= text;

		this._sortHeads();
	}

	//-----------------------------------------------------------------------------------------------------
	
	public var heads(default, null):Array<Head>;
	public var notevalue(default, null):ENoteValue;
	public var direction(default, null):EDirectionUAD;
	public var type(default, null):ENoteType;
	public var text(default, null):String;

	//-----------------------------------------------------------------------------------------------------
	
	private function _sortHeads()  {
		this.heads.sort(function(a, b) { return Reflect.compare(a.level, b.level); } );
	}
	
	/************************************************************************
	 * XML functions
	 * 
	 ************************************************************************/
	
	static public var XNOTE 			= 'note'; 
	static public var XVALUE 			= 'value';
	static public var XDIRECTION	= 'direction';
	static public var XTYPE				= 'type';
	static public var XTEXT				= 'text';
	 
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement(XNOTE);				
		
		for (head in this.heads) {
			var headXml = head.toXml();
			xml.addChild(headXml);
		}
		
		if (this.notevalue != ENoteValue.Nv4) 		xml.set(XVALUE, 			Std.string(this.notevalue.value));
		if (this.direction != EDirectionUAD.Auto) 	xml.set(XDIRECTION, 		Std.string(this.direction));
		if (this.type != ENoteType.Normal)			xml.set(XTYPE, 				Std.string(this.type));			
		if (this.text != '')									xml.set(XTYPE, 				Std.string(this.text));			
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Note {
		var xml = Xml.parse(xmlStr).firstElement();		
		var heads:Array<Head> = [];		
		for (h in xml.elementsNamed(Head.XHEAD)) {
			var head = Head.fromXmlStr(h.toString());
			heads.push(head);
		}

		var value = 			ENoteValue.getFromValue(Std.parseInt(xml.get(XVALUE)));		
		var direction = 		EDirectionUAD.createFromString(xml.get(XDIRECTION));
		var type = 				ENoteType.createFromString(xml.get(XTYPE));
		var text = 				xml.get(XTYPE);
		
		var note = new Note(heads, value, direction, type, text);
		
		return note;
	}		 
	 
}
