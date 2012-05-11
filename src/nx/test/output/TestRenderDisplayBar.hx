package nx.test.output;
import nx.display.DisplayBar;
import nx.display.DisplayNote;
import nx.enums.ESign;
import nx.test.base.RenderBase;
import nx.element.Bar;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
class TestRenderDisplayBar extends RenderBase
{

	public function test0() {
		
		var p0 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1), Head.getNew(-2)]),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)]),
				//Note.getNew([Head.getNew(-1)]),
				/*
				Note.getNew([Head.getNew(-1), Head.getNew(0)]),
				Note.getNew([Head.getNew(-1, ESign.Flat)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				]).setDirection(EDirectionUAD.Up), 
				
			Voice.getNew([
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				/*
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv2),
				*/
				]).setDirection(EDirectionUAD.Down), 
				
			]);
			
		var p1 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(0)]),
				/*
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				//Note.getNew([Head.getNew(-1)]),
				//Note.getNew([Head.getNew(-1)], ENoteValue.Nv8dot),
				]).setDirection(EDirectionUAD.Up), 
			/*	
			Voice.getNew([
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(2)]),				
				Note.getNew([Head.getNew(2)]),				
				]).setDirection(EDirectionUAD.Down), 
				*/
				
			]);		
		var p2 = Part.getNew([Voice.getNew([
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			Note.getNew([Head.getNew(-1)]),
			/*
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)]),
			*/
			])]);		
			
			
		var db = new DisplayBar(Bar.getNew([p0, p1, /*p2*/]));
		assertTrue(db != null);
			
		var dbSeq = db.getDisplayNotesSequence();
		trace(dbSeq);
		
		for (dn in dbSeq) {
			trace(dn.getLevelTop());
			
			
		}
		
		/*
		for (dp in db.getDisplayParts()) {			
			var dpValue = dp.getValue();
			var dpIdx = db.getDisplayPartIndex(dp);
			trace([dpIdx, dpValue]);
			
			var dpXDistances = dp.getDisplayNotePositionsXDistances();
			trace(dpXDistances);
		}
		*/
		
		
		
		
		var x = 100;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			trace('---');
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				render.note(x2, y, dn);
				//trace([dp.getDisplayNoteXPostitions().get(dn), dp.getDisplayNotePosition(dn)]);
			}
			y += 200;
		}	
		
		trace(db.getDisplayNoteXPostitions());
		
		
		var x = 500;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			trace('---');
			for (dn in dp.getDisplayNotesSequence()) {			
				//var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				var x2 = x + db.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				//trace(dp.getDisplayNoteXPostitions());
				trace(db.getDisplayNoteXPostitions());
				render.note(x2, y, dn);
				render.noteRects(x2, y, dn);
				//trace([dp.getDisplayNoteXPostitions().get(dn), dp.getDisplayNotePosition(dn)]);
			}
			y += 200;
		}			
		
		//var dp = db.getDisplayPart(0);
		//trace(dp.getDisplayNoteAvoidVoiceXDistances());
		
	}
	
}