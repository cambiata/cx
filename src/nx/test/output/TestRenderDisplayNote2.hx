package nx.test.output;
import nx.display.beam.BeamingProcessor_4;
import nx.display.beam.BeamingProcessor_4dot;
import nx.display.DisplayNote;
import nx.display.DisplayVoice;
import nx.output.Render;
import nx.test.base.RenderBase;
import nx.test.TO;
import nx.enums.EDirectionUD;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.NmeTools;
using nx.display.utils.DisplayNoteUtils;
using nx.output.Scaling;
class TestRenderDisplayNote2 extends RenderBase
{
	public function testDisplayVoice() {
		Render.drawRects = true;
		
		var v = TO.getVoiceOneBar4_4_Nv8s_02();

		var y = 100;
		var dv = new DisplayVoice(v);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}
		
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, null, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, null, new BeamingProcessor_4dot ());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}				
		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		var y = 300;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Down, new BeamingProcessor_4dot());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}

		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up);
		var x = 100.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up, new BeamingProcessor_4());
		var x = 400.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}		
		
		var y = 500;
		//var v = TO.getVoiceOneBar4_4_Nv8s();
		var dv = new DisplayVoice(v, EDirectionUAD.Up, new BeamingProcessor_4dot());
		var x = 700.0;
		var prevDn:DisplayNote;
		for (dn in dv.getDisplayNotes()) {
			prevDn = dv.getPrevDisplayNote(dn);
			if (prevDn != null) {
				var distance = prevDn.getNoteDistanceX(dn).scaleX(this.scaling);
				x += distance;
			}
			render.note(x, y, dn);
		}
		
		//trace(dv.getBeamlist());		
		//this.spriteSave('displayVoice.png');
		
		assertTrue(true);
		
	}
	
}