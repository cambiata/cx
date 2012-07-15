package sx.nme.media.extract;
import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */

interface ISXSoundDataExtractor 
{
	
	function getSoundData (): ByteArray;
	
	/*
	function onStart(): Void -> Void;
	function onProgress(): Int->Int->Void;
	function onComplete(): Int->Void;
	*/
	
}