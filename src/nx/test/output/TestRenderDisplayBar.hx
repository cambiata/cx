package nx.test.output;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.BeamingProcessor_4dot;
import nx.display.beam.BeamTools;
import nx.display.DisplayBar;
import nx.display.DisplayNote;
import nx.element.post.PostTie;
import nx.element.pre.PreTie;
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
		assertTrue(true);
		var p0 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)/*, Head.getNew(-0)*/]),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew( -1)]),
				
				//Note.getNew([Head.getNew(-1)]),
				/*
				Note.getNew([Head.getNew(-1), Head.getNew(0)]),
				Note.getNew([Head.getNew(-1, ESign.Flat)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				
				]).setDirection(EDirectionUAD.Up), 
				
			Voice.getNew([
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(2)]),
				Note.getNew([Head.getNew(2)]),

				/*
				Note.getNew([Head.getNew(2)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(2)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv2),
				*/
				
				]).setDirection(EDirectionUAD.Down), 
				
			]);
			
		var p1 = Part.getNew([
			Voice.getNew([

				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),

				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),

				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				
				
				
				
				/*
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				*/
				/*
				Note.getNew([Head.getNew(0)]),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)]),
				*/
				//Note.getNew([Head.getNew(-1)]),
				//Note.getNew([Head.getNew(-1)], ENoteValue.Nv8dot),
				])/*.setDirection(EDirectionUAD.Up)*/, 
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
			
		var h = Head.getNew( -2);
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew( -1);
		h2.setTieTo(new PreTie());
		
		var p2 = Part.getNew([Voice.getNew([
			Note.getNew([h], ENoteValue.Nv2),
			//Note.getNew([Head.getNew(-3)], ENoteValue.Nv2),
			Note.getNew([h2], ENoteValue.Nv2),
			
			/*
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-3)]),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
			Note.getNew([Head.getNew(-1)]),
			*/
			])]);		
			
			
		var pMultiUp = Part.getNew([
			Voice.getNew([

				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),

				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),

				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(5)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(1)], ENoteValue.Nv8),	
				])
			]);			
		
			
		var pMultiDown = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(-0)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-8)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(-5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-5)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(-5)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(-3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),
				
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(-3)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-5)], ENoteValue.Nv8),

				Note.getNew([Head.getNew(-1)], ENoteValue.Nv8),				
				Note.getNew([Head.getNew(-5)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-2)], ENoteValue.Nv8),							
				])
			]);				

		var p16th = Part.getNew([
			Voice.getNew([
			
				Note.getNew([Head.getNew(1), Head.getNew(3)], ENoteValue.Nv4),
				Note.getNew([Head.getNew(1, ESign.Flat)], ENoteValue.Nv4),
				Note.getNew([Head.getNew(-1), Head.getNew(-3)], ENoteValue.Nv4),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv4),

				
				Note.getNew([Head.getNew(-0)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(-1)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(-3)], ENoteValue.Nv16),
				Note.getNew([Head.getNew(-4)], ENoteValue.Nv16),
				
			])
		]);					
			
			
		var db = new DisplayBar(Bar.getNew([
			//p0, 
			//pMultiUp, 
			//pMultiDown
			p16th,
		]), new BeamingProcessor_4());
		
		/*
		trace(db.getPositionsArray());
		trace(db.getValuesArray());
		trace(db.getExcessArray());
		trace(db.getEndXPosition());
		trace(db.getValue());
		*/
		
		var x = 100;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				render.note(x2, y, dn);
				render.noteRects(x2, y, dn);
			}
			y += 200;
		}	
		
		
		
		var x = 500;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + db.getDisplayNoteXPostitions().get(dn).scaleX(this.scaling);
				render.note(x2, y, dn);
				//render.noteRects(x2, y, dn);
			}
			
			for (bg in dp.getBeamGroups()) {
					var x1 = x + db.getDisplayNoteXPostitions().get(bg.getFirstNote()).scaleX(this.scaling);
					var x2 = x + db.getDisplayNoteXPostitions().get(bg.getLastNote()).scaleX(this.scaling);
					render.beamGroup(x1, y, x2, BeamTools.getDimensions(bg));										
			}
						
			y += 200;
		}		
		
		//var v = db.getDisplayPart(1).getDisplayVoice(0);
		//trace(v);
		/*
		var bl = v.getBeamlist()[1];
		trace(bl);
		trace(bl.getTopHeadsLevels());
		*/
		//BeamTools.getDimensions(v.getBeamlist()[0]);
		//BeamTools.getDimensions(v.getBeamlist()[1]);
		//BeamTools.getDimensions(v.getBeamlist()[2]);
		
		
	}
	
}