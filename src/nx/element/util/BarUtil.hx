package nx.element.util;
import nx.element.Bar;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.EBarline;
import nx.enums.EClef;
import nx.enums.EPartType;
import nx.enums.ETime;

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
	
	static public function addPart(bar:Bar, newIdx:Int=-1, type:EPartType=null) {
		if (newIdx == -1) newIdx = bar.parts.length;
		newIdx = Std.int(Math.max(0, Math.min(newIdx, bar.parts.length)));
		bar.parts.insert(newIdx, new Part(type, [new Voice()]));
	}
	
	static public function setTime(bar:Bar, time:ETime) {
		bar.time = time;	
	}
	
	static public function setBarline(bar:Bar, barline:EBarline) {
		bar.barline = barline;
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