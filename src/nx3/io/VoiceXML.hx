package nx3.io;
import cx.EnumTools;
import nx3.elements.EDirectionUAD;
import nx3.elements.NNote;
import nx3.elements.NVoice;
import nx3.elements.EDirectionUD;
import nx3.elements.EVoiceType;

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

	static public function toXml(voice:NVoice): Xml
	{
		var xml:Xml = Xml.createElement(XVOICE);		
		
		// type
		switch(voice.type)
		{
			case EVoiceType.Barpause:
				xml.set(XVOICE_TYPE, Std.string(voice.type));
			default:
		}		
		
		if (voice.direction != EDirectionUAD.Auto)  xml.set(XVOICE_DIRECTION, Std.string(voice.direction));
		
		if (voice.nnotes != null)
		{
			for (note in voice.nnotes) {
				var noteXml = note.toXml();
				xml.addChild(noteXml);
			}				
		}
		
		return xml;		
	}
	
	static public function fromXmlStr(xmlStr:String): NVoice
	{
		var xml:Xml= Xml.parse(xmlStr).firstElement();			
		
		// type
		var typeStr = xml.get(XVOICE_TYPE);
		var type:EVoiceType = EnumTools.createFromString(EVoiceType, typeStr);		
		
		var directionStr = xml.get(XVOICE_DIRECTION);
		var direction:EDirectionUAD = null;
		direction = (directionStr == null) ? EDirectionUAD.Auto : EnumTools.createFromString(EDirectionUAD, directionStr);	
	
		
		var notes:Array<NNote> = [];
		//for (n in xml.elementsNamed(NoteXML.XNOTE)) 
		for (n in xml.elements()) 
		{
			var note:NNote = NoteXML.fromXmlStr(n.toString());
			notes.push(note);
		}			
		
		return new NVoice(notes, type, direction);
	}
	
	static public function test(item:NVoice):Bool
	{
		var str = toXml(item).toString();		
		var item2 = fromXmlStr(str);
		var str2 = toXml(item2).toString();
		trace(str);
		trace(str2);
		return (str == str2);
	}	
}