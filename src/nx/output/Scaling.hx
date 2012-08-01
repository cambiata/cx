package nx.output;
import nme.geom.Rectangle;
/**
 * ...
 * @author Jonas Nyström
 */

class Scaling  {

	static public inline function getBig():TScaling  {
		return {
			linesWidth:			1.5,
			space:					16.0,
			halfSpace: 				8.0,
			noteWidth:				22.0,
			halfNoteWidth:		11.0,
			quarterNoteWidth: 	5.5,
			signPosWidth:		19.0,
			svgScale:				.36,
			svgX:					-11.0,
			svgY:					-82.0,
		}
	}
	
	static public inline function getMid():TScaling {
		return {
			linesWidth:			1.25,
			space:					12.0,
			halfSpace: 				6.0,
			noteWidth:				16.5,
			halfNoteWidth:		8.25,
			quarterNoteWidth: 	4.124,
			signPosWidth:		14.0,
			svgScale:				.27,
			svgX:					-8.0,
			svgY:					-60.5,
		}
	}	
	
	
	static public inline function getNormal():TScaling {
		return {
			linesWidth:			.75,
			space:					8.0,
			halfSpace: 				4.0,
			noteWidth:				11.0,
			halfNoteWidth:		5.5,
			quarterNoteWidth: 	2.75,
			signPosWidth:		9.5,
			svgScale:				.175,
			svgX:					-6.0,
			svgY:					-40.0,
		}
	}
	
	static public inline function getSmall():TScaling {
		return {
			linesWidth:			.5,
			space:					6.0,
			halfSpace: 				3.0,
			noteWidth:				8.0,
			halfNoteWidth:		4.0,
			quarterNoteWidth: 	2.0,
			signPosWidth:		7.0,
			svgScale:				.14,
			svgX:					-5.0,
			svgY:					-32.0,
		}
	}
	
	static public inline function getLinear(): TScaling {
		return {
			linesWidth:			0.0,
			space:					0.0,
			halfSpace: 				10.0,
			noteWidth:				0.0,
			halfNoteWidth:		0.0,
			quarterNoteWidth: 	10.0,
			signPosWidth:		0.0,
			svgScale:				0.0,
			svgX:					-2.0,
			svgY:					0.0,
		}		
		
	}
	
	static public inline function scaleRectangle(rectangle:Rectangle, ms:TScaling):Rectangle {
		return new Rectangle(rectangle.x*ms.quarterNoteWidth, rectangle.y*ms.halfSpace, rectangle.width*ms.quarterNoteWidth, rectangle.height*ms.halfSpace);
	}
	
	static public inline function scaleX(displayX:Float, ms:TScaling):Float {
		return displayX * ms.quarterNoteWidth;
	}	
	
}


