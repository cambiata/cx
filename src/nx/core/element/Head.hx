package nx.core.element;
import cx.EnumTools;
import nx.enums.ESign;
import nx.enums.ETie;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.EnumTools;
class Head  
{
	
	public function new(level:Int=0, sign:ESign=null, tie:ETie=null)  {
		//trace(sign);
		this.level = level;
		this.sign = (sign == null) ? ESign.None : sign;
		this.tie = tie;
		//trace(this.sign);
	}
	
	public var level(default, null):Int;
	public var sign(default, null):ESign;
	public var tie(default, null):ETie;
	
	//-----------------------------------------------------------------------------------------------------
	/*
	public function toString():String {
		return '- Head:' + this.level + ':' + this.sign;
	}
	*/
	
	/************************************************************************
	 * XML functions
	 * 
	 ************************************************************************/
	static public var XHEAD 		= 'head';
	static public var XLEVEL 		= 'level';
	static public var XSIGN 		= 'sign';
	static public var XTIE 			= 'tie';
	
	 
	public function toXml():Xml {		
		var xml:Xml = Xml.createElement(XHEAD);		
		xml.set(XLEVEL, Std.string(this.level));		
		if (this.sign != ESign.None) xml.set(XSIGN, Std.string(this.sign));				
		if (this.tie != null) xml.set(XTIE, Std.string(this.tie));						
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String) {		
		var xml = Xml.parse(xmlStr).firstElement();		
		
		var level:Int = 0;		
		try level = Std.parseInt(xml.get(XLEVEL));			
		
		var sign = ESign.createFromString(xml.get(XSIGN));
		var tie = ETie.createFromString(xml.get(XTIE));
		
		var head = new Head(level, sign, tie);		
		return head;
	}	 
		
}

class RHead extends Head {
	
	public function new() {		
		var level = Std.int(Math.random() * 10 - 5);
		var sign:ESign = null;
		var rSign:Int = Std.int(Math.random() * 8);		
		switch (rSign) {
			case 1: sign = ESign.Flat;
			case 2: sign = ESign.Natural;
			case 3: sign = ESign.Sharp;			
			default: sign = ESign.None;
		}		
		super(level, sign);		
	}
	
	
}