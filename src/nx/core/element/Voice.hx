package nx.core.element;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.EVoiceType;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Voice 
{
	public function new(type:EVoiceType=null, notes:Array<Note> = null, direction:EDirectionUAD = null)  {
		this.type = (type != null) ? type : EVoiceType.Normal;
		if (notes == null) this.type = EVoiceType.Barpause;
		
		this.notes = (notes != null) ? Lambda.array(notes) : [new Note()];
		this.direction =(direction!= null) ? direction : EDirectionUAD.Auto;
	}

	public var type(default, null):EVoiceType;
	public var notes(default, null):Array<Note>;
	public var direction(default, null):EDirectionUAD;
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XVOICE 				= 'voice';
	static public var XTYPE 				= 'type';
	static public var XDIRECTION		= 'direction';
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement(XVOICE);				
		
		switch (this.type) {
			case EVoiceType.Barpause:
				// save no notes if barpause!
			default:
				for (note in this.notes) {
					var itemXml = note.toXml();
					xml.addChild(itemXml);
				}
		}
		
		if (this.type != EVoiceType.Normal) 				xml.set(XTYPE, 				Std.string(this.type));
		if (this.direction != EDirectionUAD.Auto) 		xml.set(XDIRECTION, 		Std.string(this.direction));
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Voice {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var notes:Array<Note> = [];
		
		for (itemXml in xml.elementsNamed(Note.XNOTE)) {
			var item = Note.fromXmlStr(itemXml.toString());
			notes.push(item);
		}	
		
		var type = EVoiceType.createFromString(xml.get(XTYPE));
		var direction = EDirectionUAD.createFromString(xml.get(XDIRECTION));
		
		
		return new Voice(notes, direction);
		
	}
	
	
	
	/*************************************************************
	 * Test functions
	 */
	
	static public function _test0() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			]);
	}

	static public function _test0Down() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			], EDirectionUAD.Down);
	}	
	
	static public function _test0Up() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			], EDirectionUAD.Up);
	}		
	
	
	static public function _test1() {
		return new Voice([
				new Note([new Head(-2)], ENoteValue.Nv2dot),
				new Note([new Head(-3)], ENoteValue.Nv4),
			]);
	}
	
	static public function _test2() {
		return new Voice([
				new Note([new Head(0)]),
				new Note([new Head(2)]),
				new Note([new Head(-1)]),
				new Note([new Head(-0)]),
			]);
	}
	
	static public function _test2Down() {
		return new Voice([
				new Note([new Head(3)]),
				new Note([new Head(4)]),
				new Note([new Head(2)]),
				new Note([new Head(2)]),
			], EDirectionUAD.Down);
	}		
	
	static public function _test2Up() {
		return new Voice([
				new Note([new Head(0)]),
				new Note([new Head(2)]),
				new Note([new Head(-1)]),
				new Note([new Head(0, ESign.Flat)]),
			], EDirectionUAD.Up);
	}	
	
	
	static public function _test3() {
		return new Voice([
				new Note([new Head(0)], ENoteValue.Nv4dot),
				new Note([new Head(2)], ENoteValue.Nv16),
				new Note([new Head(-1, ESign.Sharp)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv8),
				new Note([new Head(-3, ESign.Flat)], ENoteValue.Nv16),
				new Note([new Head(-1)], ENoteValue.Nv16),
				new Note([new Head(0)], ENoteValue.Nv4),
			]);
	}
	
	static public function _test3Up() {
		return new Voice([
				new Note([new Head(1)], ENoteValue.Nv4dot),
				new Note([new Head(-2)], ENoteValue.Nv16),
				new Note([new Head(-2, ESign.Sharp)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv8),
				new Note([new Head(-2, ESign.Flat)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv4),
			], EDirectionUAD.Up);
	}	

		
			
}


