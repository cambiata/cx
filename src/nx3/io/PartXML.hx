package nx3.io;
import cx.EnumTools;
import nx3.elements.EClef;
import nx3.elements.EDisplayALN;
import nx3.elements.EKey;
import nx3.elements.EKey.EKey;
import nx3.elements.EPartType;
import nx3.elements.NPart;
import nx3.elements.NVoice;

/**
 * ...
 * @author 
 */
using nx3.io.VoiceXML;
 
class PartXML
{
	static public inline var XPART				:String = "part";
	static public inline var XPART_TYPE			:String = "type";
	static public inline var XPART_CLEF			:String = "clef";
	static public inline var XPART_CLEFDISPLAY	:String = "clefdisplay";
	static public inline var XPART_KEY			:String = "key";
	static public inline var XPART_KEYDISPLAY	:String = "keydisplay";
	
	static public function toXml(part:NPart): Xml
	{
		var xml:Xml = Xml.createElement(XPART);		
		
		// voices
		for (voice in part.voices)
		{
			var voiceXml = voice.toXml();
			xml.addChild(voiceXml);			
		}		

		// type
		switch(part.type)
		{
			case EPartType.Normal:
				// nothing for Normal
			default:
				xml.set(XPART_TYPE, Std.string(part.type));				
		}
		
		// clef
		switch(part.clef)
		{			
			case EClef.ClefG:
				// nothing for G-clef
			default:
				xml.set(XPART_CLEF, Std.string(part.clef));			
		}
		
		// clef display
		switch(part.clefDisplay)
		{
			case EDisplayALN.Layout:
				// nothing for Layout
			default:
				xml.set(XPART_CLEFDISPLAY, Std.string(part.clefDisplay));			
		}
		
		// key
		switch(part.key.levelShift)
		{
			case 0:
				// Nothing for Natural
			default:
				xml.set(XPART_KEY, Std.string(part.key.levelShift));			
		}
		
		// key display
		switch(part.keyDisplay)
		{
			case EDisplayALN.Layout:
				// nothing for Layout
			default:
				xml.set(XPART_KEYDISPLAY, Std.string(part.keyDisplay));			
		}		
		
		return xml;
	}
	
	static public function fromXmlStr(xmlStr:String): NPart
	{
		var xml:Xml = Xml.parse(xmlStr).firstElement();	
		
		var voices:Array<NVoice> = [];
		for (v in xml.elements())
		{
			var voice:NVoice = VoiceXML.fromXmlStr(v.toString());		
			voices.push(voice);
		}
		
		// type
		var typeStr = xml.get(XPART_TYPE);
		var type:EPartType = EnumTools.createFromString(EPartType, typeStr);				
		
		// clef
		var str = xml.get(XPART_CLEF);
		var clef:EClef = (str == null) ? EClef.ClefG : EnumTools.createFromString(EClef, str);
		
		// timeDisplay
		var clefDisplayStr = xml.get(XPART_CLEFDISPLAY);
		var clefDisplay = (clefDisplayStr == null) ? EDisplayALN.Layout : EnumTools.createFromString(EDisplayALN, clefDisplayStr);
		
		// key
		var str = xml.get(XPART_KEY);
		var key:EKey = (str == null) ? EKey.Natural : new EKey(Std.parseInt(str));
		
		// keyDisplay
		var keyDisplayStr = xml.get(XPART_KEYDISPLAY);
		var keyDisplay = (keyDisplayStr == null) ? EDisplayALN.Layout : EnumTools.createFromString(EDisplayALN, keyDisplayStr);		
		
		return new NPart(voices, type, clef, clefDisplay, key, keyDisplay);
		
	}
	
}