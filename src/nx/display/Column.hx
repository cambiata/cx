package nx.display;

/**
 * ...
 * @author Jonas Nyström
 */

typedef Column = {
	position: 			Int,
	value: 				Int,
	complexes: 		Array<Complex>,
	positionX:			Float,
	widthX:				Float,
	distanceX:			Float,
	?valueWeight:	Float,
	
	?aPositionX:		Float,		// alloted position
	?aWidthX:			Float,		// alloted width
	?aSuperX:			Float,		// alloted overflow
	
	?sPositionX:		Float,		// spcaed position
	?sWidthX:			Float,		// spaced width
	?sSuperX:			Float,		// spaced overflow
	
	//?sAdd:				Float,
	
}