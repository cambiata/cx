package nx3.elements.beams;
import nx3.elements.EDirectionUAD;
import nx3.elements.DVoice;
/**
 * ...
 * @author Jonas Nyström
 */

interface IBeamingProcessor {
	function doBeaming(dvoice:DVoice, ?forceDirection:EDirectionUAD=null):Void;
}