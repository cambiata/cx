package nx3.elements;

/**
 * ...
 * @author Jonas Nyström
 */

enum ETie 
{	
	Tie(direction:EDirectionUAD, level:Int);	
	Gliss(direction:EDirectionUAD, levelLeft:Int, levelRight:Int);
}