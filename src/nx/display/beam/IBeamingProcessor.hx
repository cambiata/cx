package nx.display.beam;
import nx.enums.EDirectionUAD;
import nx.display.DVoice;
/**
 * ...
 * @author Jonas Nyström
 */

interface IBeamingProcessor {
	function doBeaming(dvoice:DVoice, ?forceDirection:EDirectionUAD=null):Void;
}