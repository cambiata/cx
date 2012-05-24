package nx.app.nme;

import nme.display.Sprite;
import nme.Lib;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import haxe.unit.TestRunner;
import nx.test.TestHead;
import nx.test.TestDisplayHead;
import nx.test.TestNote;
import nx.test.TestDisplayNote;
import nx.test.TestVoice;
import nx.test.TestDisplayVoice;
import nx.test.TestXml;
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




import nx.display.DisplayNote;
import nx.display.DisplayVoice;
import nx.output.Render;
import nx.output.Scaling;
import nx.test.TO;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.output.Scaling;
class Main extends Sprite
{	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		// entry point
		trace('nme');

		
		var runner = new TestRunner();
		runner.add(new TestHead());

		runner.add(new TestDisplayHead());		
		runner.add(new TestNote());
		runner.add(new TestDisplayNote());	
		runner.add(new TestVoice());
		runner.add(new TestDisplayVoice());
		runner.add(new TestXml());
		
		
		//runner.run();
		
		//-----------------------------------------------------------------------------------------------------
		
		
		var scaling = Scaling.getBig();
		var render = new Render(Lib.current, scaling);	
		render.clef(10, 100);
		render.lines(10, 100, 980);	
		
		/*
		var v = TO.getVoiceOneBar4_4_Nv8s_02();

		var y = 100;
		var dv = new DisplayVoice(v);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(scaling);
				x += distance;
			}
			render.note(x, y, dn);
			//render.noteARects(x, y, dn);
		}
		*/
		
		
		
		var p0 = Part.getNew([
			Voice.getNew([
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew(-1)/*, Head.getNew(-0)*/], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-2)/*, Head.getNew(-0)*/], ENoteValue.Nv8),
				Note.getNew([Head.getNew(-1)]),
				Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(0, ESign.Flat)]),
				
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
				Note.getNew([Head.getNew(2)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(5, ESign.Natural)], ENoteValue.Nv8),
				Note.getNew([Head.getNew(4)]),

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
			p0, 
			//pMultiUp, 
			//pMultiDown
			//p16th,
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
				var x2 = x + dp.getDisplayNoteXPostitions().get(dn).scaleX(scaling);
				render.note(x2, y, dn);
				//render.noteRects(x2, y, dn);
			}
			y += 200;
		}	

		
		
		
		var x = 500;
		var y = 100;
		for (dp in db.getDisplayParts()) {
			for (dn in dp.getDisplayNotesSequence()) {			
				var x2 = x + db.getDisplayNoteXPostitions().get(dn).scaleX(scaling);
				render.note(x2, y, dn);
				//render.noteRects(x2, y, dn);
			}
			
			for (bg in dp.getBeamGroups()) {
					var x1 = x + db.getDisplayNoteXPostitions().get(bg.getFirstNote()).scaleX(scaling);
					var x2 = x + db.getDisplayNoteXPostitions().get(bg.getLastNote()).scaleX(scaling);
					render.beamGroup(x1, y, x2, BeamTools.getDimensions(bg));										
			}
						
			y += 200;
		}		
		
	}
	

}