package nx3.io;
import cx.EnumTools;
import nx3.elements.Note;
import nx3.elements.Voice;
import nx3.enums.EDirectionUD;
import nx3.enums.EVoiceType;

/**
 * ...
 * @author 
 */
using nx3.io.NoteXML;
 
class VoiceXML
{
	static public inline var XVOICE:String = "voice";
	static public inline var XVOICE_TYPE:String = "type";
	static public inline var XVOICE_BARPAUSE:String = "barpause";
	static public inline var XVOICE_DIRECTION:String = "direction";

	static public function toXml(voice:Voice)
	{
		var xml:Xml = Xml.createElement(XVOICE);		
		
		// type
		switch(voice.type)
		{
			case EVoiceType.Barpause:
				xml.set(XVOICE_TYPE, Std.string(voice.type));
			default:
		}		
		
		if (voice.direction != null)  xml.set(XVOICE_DIRECTION, Std.string(voice.direction));
		
		if (voice.notes != null)
		{
			for (note in voice.notes) {
				var noteXml = note.toXml();
				xml.addChild(noteXml);
			}				
		}
		
		
		return xml;		
	}
	
	static public function fromXmlStr(xmlStr:String): Voice
	{
		var xml = Xml.parse(xmlStr).firstElement();			
		
		// type
		var typeStr = xml.get(XVOICE_TYPE);
		var type:EVoiceType = EnumTools.createFromString(EVoiceType, typeStr);		
				
		
		var direction:EDirectionUD = null;
		direction = EnumTools.createFromString(EDirectionUD, xml.get(XVOICE_DIRECTION));			
		
		var notes:Array<Note> = [];
		for (n in xml.elementsNamed(NoteXML.XNOTE)) 
		{
			var note:Note = NoteXML.fromXmlStr(n.toString());
			notes.push(note);
		}			
		
		
		return new Voice(notes, type, direction);
	}
	
	static public function test(item:Voice):Bool
	{
		var str = toXml(item).toString();		
		var item2 = fromXmlStr(str);
		var str2 = toXml(item2).toString();
		trace(str);
		trace(str2);
		return (str == str2);
	}	
}