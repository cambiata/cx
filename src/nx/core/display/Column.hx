package nx.core.display;

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
	
	?aPositionX:		Float,
	?aWidthX:			Float,
	?aSuperX:			Float,
	
	?sPositionX:		Float,
	?sWidthX:			Float,
	?sSuperX:			Float,
	
}