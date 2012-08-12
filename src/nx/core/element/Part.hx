package nx.core.element;

/**
 * ...
 * @author Jonas Nyström
 */

class Part 
{
	public function new(voices:Iterable<Voice>=null) {
		this.voices = (voices != null) ? Lambda.array(voices) : [new Voice()];
	}
	
	public var voices(default, null):Array<Voice>;
	
	/*************************************************************
	 * XML functions
	 */
	
	static public var XPART 				= 'part';
	//static public var XDIRECTION		= 'direction';
	
	public function toXml():Xml {		
		
		var xml:Xml = Xml.createElement(XPART);				
		
		for (voice in this.voices) {
			var itemXml = voice.toXml();
			xml.addChild(itemXml);
		}
		
		//if (this.direction != EDirectionUAD.Auto) 		xml.set(XDIRECTION, 		Std.string(this.direction));
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Part {	
		
		var xml = Xml.parse(xmlStr).firstElement();
		
		var voices:Array<Voice> = [];
		
		for (itemXml in xml.elementsNamed(Voice.XVOICE)) {
			var item = Voice.fromXmlStr(itemXml.toString());
			voices.push(item);
		}	
		
		//var direction = EDirectionUAD.createFromString(xml.get(XDIRECTION));
		
		return new Part(voices);
		
	}
	
}

