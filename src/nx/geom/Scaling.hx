package nx.geom;
import nme.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class Scaling  {
	
	static public function getNormal():TScaling {
		return {
			linesWidth:		.75,
			space:			8.0,
			halfSpace: 		4.0,
			noteWidth:		11.0,
			halfNoteWidth:	5.5,
			quarterNoteWidth: 2.25,
			signPosWidth:	9.0,
			svgScale:		.18,
			svgX:			-5.0,
			svgY:			-41.0,
		}
	}
	static public function getBig():TScaling {
		return {
			linesWidth:		1.5,
			space:			16.0,
			halfSpace: 		8.0,
			noteWidth:		22.0,
			halfNoteWidth:	11.0,
			quarterNoteWidth: 5.5,
			signPosWidth:	18.0,
			svgScale:		.36,
			svgX:			-10.0,
			svgY:			-82.0,
		}
	}
	static public function getSmall():TScaling {
		return {
			linesWidth:		.5,
			space:			6.0,
			halfSpace: 		3.0,
			noteWidth:		8.0,
			halfNoteWidth:	4.0,
			quarterNoteWidth: 2.0,
			signPosWidth:	7.0,
			svgScale:		.14,
			svgX:			-4.0,
			svgY:			-32.0,
		}
	}
	
	static public function toDRect(dr:Rectangle, ms:TScaling):DRectangle {
		return new DRectangle(dr.x*ms.quarterNoteWidth, dr.y*ms.halfSpace, dr.width*ms.quarterNoteWidth, dr.height*ms.halfSpace);
	}
	
	static public function toX(displayX:Float, ms:TScaling):Float {
		return displayX * ms.quarterNoteWidth;
	}	
	
}



typedef TScaling = {
	linesWidth:			Float,
	space:				Float,
	halfSpace:			Float,
	noteWidth:			Float,
	halfNoteWidth:		Float,
	quarterNoteWidth: 	Float,
	signPosWidth:		Float,
	svgScale:			Float,
	svgX:				Float,
	svgY:				Float,
}