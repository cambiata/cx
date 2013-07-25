package nx3.render.scaling;

/**
 * ...
 * @author 
 */
class Scaling
{
	static public var MID:TScaling = 
	{
	#if js			
		linesWidth:			0.8,
	#elseif flash
		linesWidth:			1.5,
	#else
		linesWidth:			1.25,
	#end			
		space:					12.0,
		halfSpace: 			6.0,
		noteWidth:			10,
		halfNoteWidth:		5,
		quarterNoteWidth: 	2.5,
		signPosWidth:		14.0,
		svgScale:				.27,
		svgX:					0,
		svgY:					-55.0,
		fontScaling:			6.0,		
	}
	
	static public var NORMAL:TScaling = 
	{
	#if js
		linesWidth:			.5,
	#else
		linesWidth:			.75,
	#end
		space:					8.0,
		halfSpace: 			4.0,
		noteWidth:			7.0 , //11.0, 
		halfNoteWidth:		3.5, // 5.5
		quarterNoteWidth: 	1.75, // 2.75
		signPosWidth:		9.5,
		svgScale:				.175,
		svgX:					0,
		svgY:					-36.0,
		fontScaling:			4.0,		
	}
	
	static public var SMALL:TScaling =
	{
		linesWidth:			.5,
		space:					6.0,
		halfSpace: 			3.0,
		noteWidth:			5.0, //8.0,
		halfNoteWidth:		2.5, // 4.0
		quarterNoteWidth: 	1.25, // 2.0
		signPosWidth:		7.0,
		svgScale:				.14,
		svgX:					-0,
		svgY:					-28.5,
		fontScaling:			3.0,		
	}	
}