package nx.display.beam;
import nx.enums.EDirectionUAD;
import nx.display.DisplayVoice;
/**
 * ...
 * @author Jonas Nyström
 */

interface IBeamingProcessor {
	function doBeaming(dVoice:DisplayVoice, ?forceDirection:EDirectionUAD=null):Void;
}