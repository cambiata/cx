package nx.element.util;
import nx.element.Bar;
import nx.element.Note;
import nx.element.Part;

/**
 * ...
 * @author Jonas Nyström
 */

class BarUtil 
{
	static public function clone(bar:Bar):Bar {
		return Bar.fromXmlStr(bar.toXml().toString());
	}
	
	
	static public function cloneContent(bar:Bar):Bar {
		var parts: Array<Part> = [];
		
		for (part in bar.parts) {
			var voices = Part.fromXmlStr(part.toXml().toString()).voices;
			parts.push(new Part(part.type, voices));
		}
		
		var newBar = new Bar(parts);
		return newBar;
		
		/*
		var newBar = Bar.fromXmlStr(bar.toXml().toString());
		newBar.time = null;
		newBar.timeDisplay = null;
		newBar.ackolade = null;
		newBar.barline = null;
		newBar.barlineLeft = null;
		newBar.indentLeft = null;
		newBar.indentRight = null;		
		for (part in newBar.parts) {
			part.clef = null;
			part.clefDisplay = null;
			part.key = null;
			part.keyDisplay = null;
			part.label = null;
			part.type = null;
			
		}
		return newBar;
		*/
	}	
	
	
	static public function removeNotes(bar:Bar) {
		for (part in bar.parts) {
			for (voice in part.voices) {
				trace(voice.notes.length);
				//while (voice.notes.length > 1) voice.notes.pop();				
				voice.notes.splice(1, 1000);
				trace(voice.notes.length);
			}			
		}	
	}
}