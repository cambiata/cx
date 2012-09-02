package nx.element.util;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.EClef;
import nx.enums.EDirectionUAD;
import nx.enums.EKey;
import nx.enums.EVoiceType;

/**
 * ...
 * @author Jonas Nyström
 */

class PartUtil 
{

	static public function addVoice(part:Part, type:EVoiceType=null) {
		if (part.voices.length > 1) throw "Cant add voice";
		if (type == null) type = EVoiceType.Normal;
		part.voices.push(new Voice(null, [new Note()]));
		
		part.voices[0].direction = EDirectionUAD.Up;
		part.voices[1].direction = EDirectionUAD.Down;
	}
	
	static public function setClef(part:Part, clef:EClef) {
		part.clef = clef;
	}
	
	static public function setKey(part:Part, key:EKey) {
		part.key = key;
	}
	

}