package nx.display.utils;
import cx.NmeTools;
import nme.display.Sprite;
import nme.geom.Rectangle;
import nx.display.DisplayNote;
import nx.output.Scaling;
import nx.output.TScaling;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.NmeTools;
class DisplayNoteUtils {
	
	static public function overlap(dnOver:DisplayNote, dnUnder:DisplayNote) {
		
	}
	
	
	/*
	static public function overlapHeads(dnOver:DisplayNote, dnUnder:DisplayNote) {
		trace(dnOver.getDisplayRect());
		trace(dnUnder.getDisplayRect());
	}
	*/
	
	/*
	static public function minDistance(dn1:DisplayNote, dn2:DisplayNote):Float {
		function ofA(ra1:Array<Rectangle>, ra2:Array<Rectangle>):Float {
			var offsetX = 0.0;			
			
			for (r1 in ra1) {
				for (r2 in ra2) {
					var i = NmeTools.intersection2(r1, r2.rectanglePushX(offsetX));
					if (i != null) offsetX = Math.max(offsetX, i.width);
					
				}
			}			
			return offsetX;
		}
		
		var r1:Rectangle = dn1.getDisplayRect();
		var offsetX = r1.width;
		var r2:Rectangle = dn2.getDisplayRect().clone();
		r2.rectanglePushX(offsetX);				
		//-----------------------------------------------------------------------------------------------------		
		// dot - note
		//var i = NmeTools.intersection2(dn1.getDisplayRectDots(), dn2.getDisplayRect().rectanglePushX(offsetX));
		//if (i != null) offsetX += i.width;		
		var ox = ofA([
				dn1.getDisplayRectStave(),
				dn1.getDisplayRectDots(),
			], [
				r2, 
				dn2.getDisplayRectStave().rectanglePushX(offsetX),
				dn2.getDisplayRectSigns().rectanglePushX(offsetX),
				
			]);
		offsetX += ox;
		
		// Mysko!!! att man måste köra detta ett varv till!		
		
		var ox = ofA([
				dn1.getDisplayRectDots(),
			], [				
				dn2.getDisplayRectSigns().rectanglePushX(offsetX),
				dn2.getDisplayRectAppogiatura().rectanglePushX(offsetX),
				dn2.getDisplayRectArpeggio().rectanglePushX(offsetX),
			]);
		offsetX += ox;		
		
		return offsetX;
	}
	*/
	
	static public function drawAODR(ar:Array<Rectangle>, sprite:Sprite, x:Float, y:Float, ms:TScaling, color:Int=0x000000) {				
		sprite.graphics.lineStyle(2, color);		
		for (r in ar) {
			var r2 = Scaling.scaleRectangle(r, ms);
			r2.offset(x, y);
			sprite.graphics.drawRect(r2.x, r2.y, r2.width, r2.height);
		}		
	}
	
	/*
	static public function overlapX(ar1:Array<Rectangle>, ar2:Array<Rectangle>) {
		var move = 0.0;
		for (r1 in ar1) {
			for (r2 in ar2) {
				var r3 = NmeTools.intersection2(r1, r2);
				trace(r3.width);				
				move = Math.max(move, r3.width);
			}
		}
		return move;
	}
	*/
}

