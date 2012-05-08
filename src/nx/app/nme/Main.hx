package nx.app.nme;

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
class Main 
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
		runner.run();
		
		//-----------------------------------------------------------------------------------------------------
		
		var scaling = Scaling.getMid();
		var render = new Render(Lib.current, scaling);	
		render.clef(10, 100);
		render.lines(10, 100, 980);	
		
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
	}
}