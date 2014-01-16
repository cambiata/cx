package nx3.elements;
/**
 * ...
 * @author Jonas Nyström
 */

interface BProcessor 
{
	function doBeaming(dvoice:DVoice, ?forceDirection:EDirectionUAD=null):Void;
}