package nx3.io;
import cx.EnumTools;
import cx.StrTools;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.enums.EHeadType;
import nx3.enums.ESign;
import nx3.enums.ETie;

/**
 * ...
 * @author Jonas Nyström
 */
class HeadXML
{
	static public function toXml(head:Head)
	{
		var xml:Xml = Xml.createElement(XHEAD);		

		// type
		switch(head.type)
		{
			case EHeadType.Crossed, EHeadType.Rythmic:
				xml.set(XHEAD_TYPE, Std.string(head.type));
			default:
		}

		// level
		xml.set(XHEAD_LEVEL, Std.string(head.level));				
		
		// sign		
		if (head.sign != ESign.None) xml.set(XHEAD_SIGN, Std.string(head.sign));						
		
		// tie
		if (head.tie != null) 
		{
			switch(head.tie)
			{
				case ETie.Tie(direction), ETie.Gliss(direction):
					xml.set(XHEAD_TIE,/* StrTools.until(*/Std.string(head.tie)/*, '(')*/);						
				//default:
			}			
		}
		
		// tie
		if (head.tieTo != null) 
		{
			switch(head.tieTo)
			{
				case ETie.Tie(direction), ETie.Gliss(direction):
					xml.set(XHEAD_TIETO, Std.string(head.tieTo));						
				//default:
			}			
		}		
		
		return xml;
	}
	
	static public var XHEAD  = 'head';
	static public var XHEAD_TYPE = 'type';
	static public var XHEAD_LEVEL = 'level';
	static public var XHEAD_SIGN = 'sign';
	static public var XHEAD_TIE = 'tie';
	static public var XHEAD_TIETO = 'tieto';
	//static public var XHEAD_TIE_DIRECTION = 'tiedirection';
	
	static public function fromXmlStr(xmlStr:String): Head
	{
		var xml = Xml.parse(xmlStr).firstElement();		
		
		// type
		var typeStr = xml.get(XHEAD_TYPE);
		var type:EHeadType = EnumTools.createFromString(EHeadType, typeStr);
		
		// level
		var level:Int = Std.parseInt(xml.get(XHEAD_LEVEL));
		
		// sign
		var sign:ESign = EnumTools.createFromString(ESign, xml.get(XHEAD_SIGN));
		
		// tie
		var tie:ETie = EnumTools.createFromString(ETie, xml.get(XHEAD_TIE));
	
		// tieFrom
		var tieTo:ETie = EnumTools.createFromString(ETie, xml.get(XHEAD_TIETO));		
		
		return new Head(type, level, sign, tie, tieTo);
	}
	
	
	 /*
	public function toXml():Xml 
	{		
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
	
	
	
	
	static public function toNoteXml(note:Note)
	{
		
		
		
	}
	*/
	
	static public function test(item:Head):Bool
	{
		var str = toXml(item).toString();		
		var item2 = fromXmlStr(str);
		var str2 = toXml(item2).toString();
		trace(str);
		trace(str2);
		return (str == str2);
	}	
	
}