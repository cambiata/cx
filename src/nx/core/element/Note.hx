package nx.core.element;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */

class Note  
{

	public function new(heads:Iterable<Head>=null, notevalue:ENoteValue=null, direction:EDirectionUAD=null) {
		
		this.heads = (heads != null) ? Lambda.array(heads) : [new Head()];
		this.notevalue = (notevalue != null) ? notevalue : ENoteValue.Nv4;
		this.direction = (direction != null) ? direction : EDirectionUAD.Auto;

		this._sortHeads();
	}

	//-----------------------------------------------------------------------------------------------------
	
	public var heads(default, null):Array<Head>;
	public var notevalue(default, null):ENoteValue;
	public var direction(default, null):EDirectionUAD;

	//-----------------------------------------------------------------------------------------------------
	
	private function _sortHeads()  {
		this.heads.sort(function(a, b) { return Reflect.compare(a.level, b.level); } );
	}
	
	/************************************************************************
	 * XML functions
	 * 
	 ************************************************************************/
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement('note');				
		
		for (head in this.heads) {
			var headXml = head.toXml();
			xml.addChild(headXml);
		}
		
		xml.set('value', Std.string(this.notevalue.value));
		xml.set('direction', Std.string(this.direction));
		//xml.set('type', Std.string(this.));			
		//xml.set('text', Std.string(this.));			
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Note {
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var heads:Array<Head> = [];
		
		for (h in xml.elementsNamed('head')) {
			var head = Head.fromXmlStr(h.toString());
			heads.push(head);
		}

		/*
		var text:String;
		try text = xml.get('text');			
		*/
		
		var value:ENoteValue= null;
		var int = Std.parseInt(xml.get('value'));
		if (int != null) {
			value = ENoteValue.getFromValue(int);		
		}
		
		var direction:EDirectionUAD = null;
		var str = xml.get('direction');
		if (str != null) try { direction = Type.createEnum(EDirectionUAD, str); }				
		
		
		/*
		var type:ENoteType = null;
		var str = xml.get('type');
		if (str != null) try type = Type.createEnum(ENoteType, str);
		*/
		
		var note = new Note(heads, value, direction);
		
		return note;
	}		 
	 
}
