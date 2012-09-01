package nx.element.util;
import nx.element.Note;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.ETie;

/**
 * ...
 * @author Jonas Nyström
 */

class NoteUtil 
{

	static public function clone(note:Note) {
		return Note.fromXmlStr(note.toXml().toString());
	}
	
	static public function setLevel(note:Note, levelChange:Int, headNr:Int = -1) {
		if (headNr == -1) {
			for (head in note.heads) {
				head.level += levelChange;				
			}
		} else {
			note.heads[headNr].level += levelChange;
		}		
	}		
	
	static public function setSign(note:Note, sign:ESign, headNr:Int = -1) {
		if (headNr == -1) {
			for (head in note.heads) {
				head.sign = sign;				
			}
		} else {
			note.heads[headNr].sign = sign;
		}		
	}

	static public function setTie(note:Note, tie:ETie, headNr:Int = -1) {
		if (headNr == -1) {
			for (head in note.heads) {
				head.tie = tie;				
			}
		} else {
			note.heads[headNr].tie = tie;
		}		
	}
	
	static public function setType(note:Note, type:ENoteType) {
		note.type = type;
	}
	
	
	
	static public function setValue(note:Note, value:ENoteValue) {
		note.notevalue = value;
	}			
	
}