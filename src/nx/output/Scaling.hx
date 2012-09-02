package nx.output;
import nme.geom.Rectangle;
/**
 * ...
 * @author Jonas Nyström
 */

class Scaling  {

	static public inline function getPrint1():TScaling  {
		return {
			linesWidth:			3,
			space:					32.0,
			halfSpace: 				16.0,
			noteWidth:				44.0,
			halfNoteWidth:		22.0,
			quarterNoteWidth: 	11.0,
			signPosWidth:		38.0,
			svgScale:				.72,
			svgX:					-23.0,
			svgY:					-164.0,
			fontScaling:			16.0,
		}
	}	
	
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
			fontScaling:			8.0,
		}
	}
	
	static public inline function getMid():TScaling {
		return {
#if js			
			linesWidth:			0.8,
#elseif flash
			linesWidth:			1.3,
#else
			linesWidth:			1.25,
#end			
			space:					12.0,
			halfSpace: 				6.0,
			noteWidth:				16.5,
			halfNoteWidth:		8.25,
			quarterNoteWidth: 	4.124,
			signPosWidth:		14.0,
			svgScale:				.27,
			svgX:					-8.5,
			svgY:					-61.0,
			fontScaling:			6.0,
		}
	}	
	
	static public inline function getNormal():TScaling {
		return {
#if js
			linesWidth:			.5,
#else
			linesWidth:			.75,
#end
			space:					8.0,
			halfSpace: 				4.0,
			noteWidth:				11.0,
			halfNoteWidth:		5.5,
			quarterNoteWidth: 	2.75,
			signPosWidth:		9.5,
			svgScale:				.175,
			svgX:					-5.5,
			svgY:					-40.0,
			fontScaling:			4.0,
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
			fontScaling:			3.0,
		}
	}

	static public inline function getMini():TScaling {
		return {
			linesWidth:			.3,
			space:					4.0,
			halfSpace: 				2.0,
			noteWidth:				6.0,
			halfNoteWidth:		3.0,
			quarterNoteWidth: 	1.5,
			signPosWidth:		5.0,
			svgScale:				.09,
			svgX:					-3.0,
			svgY:					-20.0,
			fontScaling:			2.0,
		}
	}

	static public inline function getMicro():TScaling {
		return {
			linesWidth:			.1,
			space:					2.0,
			halfSpace: 				1.0,
			noteWidth:				3.0,
			halfNoteWidth:		1.5,
			quarterNoteWidth: 	0.75,
			signPosWidth:		2.5,
			svgScale:				.05,
			svgX:					-1.0,
			svgY:					-12.0,
			fontScaling:			1.0,
		}
	}
	
	static public inline function scaleRect(ms:TScaling, rectangle:Rectangle):Rectangle {
		return new Rectangle(rectangle.x*ms.quarterNoteWidth, rectangle.y*ms.halfSpace, rectangle.width*ms.quarterNoteWidth, rectangle.height*ms.halfSpace);		
	}
	
	static public inline function scaleX(ms:TScaling, displayX:Float):Float {
		return displayX * ms.quarterNoteWidth;
	}
	
	static public inline function descaleX(ms:TScaling, realX:Float):Float {
		return realX / ms.quarterNoteWidth;
	}
	
	static public inline function scaleY(ms:TScaling, displayY:Float):Float {
		return displayY * ms.halfSpace;
	}	
	
	static public inline function descaleY(ms:TScaling, realY:Float):Float {
		return realY / ms.halfSpace;
	}	
	
	/*
	static public function scaleUp(scaling:TScaling) :TScaling {
		switch(scaling.space) {
			case getMicro().space: return getMini();
			case getMini().space: return getNormal();
			case getNormal().space: return getMid();
			case getMid().space: return getBig();
			case getBig().space: return getPrint1();
			default: return getMicro();
		}
	}
	*/
	
}


