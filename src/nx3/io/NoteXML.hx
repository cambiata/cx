package nx3.io;
import cx.EnumTools;
import nx3.enums.EDirectionUD;
import nx3.enums.ELyricContinuation;
import nx3.enums.ELyricFormat;
import nx3.enums.ENoteArticulation;
import nx3.enums.ENoteAttributes;
import nx3.enums.ENoteValue;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.enums.ENoteType;
import nx3.enums.ENoteVariant;
import nx3.enums.EPosition;
import nx3.units.Level;

using nx3.io.HeadXML;

/**
 * ...
 * @author 
 */
class NoteXML
{
	static public inline var XNOTE:String = "note";
	static public inline var XPAUSE:String = "pause";
	static public inline var XPAUSE_LEVEL:String = "level";

	static public inline var XLYRIC:String = "lyric";
	static public inline var XLYRIC_TEXT:String = "text";

	static public inline var XUNDEFINED:String = "undefined";
	
	
	static public inline var XNOTE_TYPE:String = "type";
	static public inline var XNOTE_TYPE_NOTE:String = "note";
	static public inline var XNOTE_TYPE_NOTE_VARIANT:String = "variant";
	static public inline var XNOTE_VALUE:String = "value";
	static public inline var XNOTE_DIRECTION:String = "direction";
	static public inline var XNOTE_TYPE_PAUSE:String = "pause";
	static public inline var XNOTE_TYPE_NOTE_ARTICULATIONS:String = "articulations";
	static public inline var LIST_DELIMITER:String = ";";
	static public inline var XNOTE_TYPE_NOTE_ATTRIBUTES:String = "attributes";
	static public inline var XOFFSET:String = "offset";
	static public inline var XLYRIC_CONTINUATION:String = "continuation";
	static public inline var XLYRIC_FORMAT:String = "format";

	static public function toXml(note:Note):Xml
	{
		var xml:Xml = null; 
		
		// type
		switch(note.type)
		{
			//---------------------------------------------------------------------------------------------------------------------------
			case (ENoteType.Note(heads, variant, articulations, attributes)):
				xml = Xml.createElement(XNOTE);		
						
				for (head in heads) {
					var headXml = head.toXml();
					xml.addChild(headXml);
				}				
				
				if (variant != null) xml.set(XNOTE_TYPE_NOTE_VARIANT, Std.string(variant));
				
				if (articulations != null)
				{
					var articulationStrings:Array<String>= [];
					for (articulation in articulations)
					{
						articulationStrings.push(Std.string(articulation));						
					}
					xml.set(XNOTE_TYPE_NOTE_ARTICULATIONS, articulationStrings.join(LIST_DELIMITER));
				}
				
				if (attributes != null)
				{
					var attributesStrings:Array<String> = [];
					for (attribute in attributes)
					{
						attributesStrings.push(Std.string(attribute));
					}
					xml.set(XNOTE_TYPE_NOTE_ATTRIBUTES, attributesStrings.join(LIST_DELIMITER));
				}
				
			//---------------------------------------------------------------------------------------------------------------------------	
			case (ENoteType.Pause(level)):				
				xml = Xml.createElement(XPAUSE);		
				if (level != 0) xml.set(XPAUSE_LEVEL, Std.string(level));
			
			//---------------------------------------------------------------------------------------------------------------------------	
			case(ENoteType.Lyric(text, offset, continuation, format)):				
				xml = Xml.createElement(XLYRIC);		
				xml.set(XLYRIC_TEXT, text);
				if (continuation != null) xml.set(XLYRIC_CONTINUATION, Std.string(continuation));
				if (offset != null) xml.set(XOFFSET, Std.string(offset));
				if (format != null) xml.set(XLYRIC_FORMAT, Std.string(format));
				
			default:
				xml = Xml.createElement(XUNDEFINED);	
		}
		
		// value
		xml.set(XNOTE_VALUE, Std.string(note.value.value));
		
		// direction
		if (note.direction != null) xml.set(XNOTE_DIRECTION, Std.string(note.direction));
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String):Note
	{
		var xml = Xml.parse(xmlStr).firstElement();		
		
		
		var xmlType:String = xml.nodeName;
	
		var type:ENoteType = null;
		switch(xmlType)
		{
			
			//---------------------------------------------------------------------------------------------------------------------------
			case XNOTE:
				var heads:Array<Head> = [];				
				for (h in xml.elementsNamed(HeadXML.XHEAD)) 
				{
					var head = HeadXML.fromXmlStr(h.toString());
					heads.push(head);
				}				
				
				var variant:ENoteVariant = EnumTools.createFromString(ENoteVariant, xml.get(XNOTE_TYPE_NOTE_VARIANT));			
				//if (variant == null) variant = ENoteVariant.Normal;
				
				var articulations:Array<ENoteArticulation> = [];
				var articulationsStr:String = xml.get(XNOTE_TYPE_NOTE_ARTICULATIONS);				
				if (articulationsStr != null)
				{
					var articulationStrings:Array<String> = articulationsStr.split(LIST_DELIMITER);
					for (articulationStr in articulationStrings)
					{
						articulations.push(EnumTools.createFromString(ENoteArticulation, articulationStr));
					}
				}
				
				var attributes:Array<ENoteAttributes> = [];
				var attributesStr:String = xml.get(XNOTE_TYPE_NOTE_ATTRIBUTES);				
				if (attributesStr != null)
				{
					var attributesStrings:Array<String> = attributesStr.split(LIST_DELIMITER);
					for (attributeStr in attributesStrings)
					{
						attributes.push(EnumTools.createFromString(ENoteAttributes, attributeStr));
					}
				}				
				
				type = ENoteType.Note(heads, variant, articulations, attributes);

			//---------------------------------------------------------------------------------------------------------------------------
			case XPAUSE:				
				var level:Level = Std.parseInt(xml.get(XPAUSE_LEVEL));
				type = ENoteType.Pause(level);
				
			//---------------------------------------------------------------------------------------------------------------------------
			case XLYRIC:
				var text = xml.get(XLYRIC_TEXT);				
				
				var offsetStr = xml.get(XOFFSET);
				var offset:EPosition = EnumTools.createFromString(EPosition, offsetStr);
				var continuationStr = xml.get(XLYRIC_CONTINUATION);				
				var continuation:ELyricContinuation = EnumTools.createFromString(ELyricContinuation, continuationStr);
				var formatStr = xml.get(XLYRIC_FORMAT);
				var format:ELyricFormat = EnumTools.createFromString(ELyricFormat, formatStr);
				
				type = ENoteType.Lyric(text, offset, continuation, format);
		}
		
		// value
		var val:Int = Std.parseInt(xml.get(XNOTE_VALUE));
		var value:ENoteValue = ENoteValue.getFromValue(val);
		
		// direction		
		var direction:EDirectionUD = EnumTools.createFromString(EDirectionUD, xml.get(XNOTE_DIRECTION));
		//if (direction == null) direction = EDirectionUAD.Auto;
		
		return new  Note(type, value, direction);
	}
	
	static public function test(item:Note):Bool
	{
		var str = toXml(item).toString();		
		var item2 = fromXmlStr(str);
		var str2 = toXml(item2).toString();
		trace(str);
		trace(str2);
		return (str == str2);
	}
	
	
}