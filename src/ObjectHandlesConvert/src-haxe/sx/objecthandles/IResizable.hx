package sx.objecthandles;

/**
 * ...
 * @author Jonas Nyström
 */

interface IResizable 
{
	function getWidth() : Float;
	function getHeight() : Float;
	
	function setWidth(val : Float):Float;
	function setHeight(val : Float):Float;
}