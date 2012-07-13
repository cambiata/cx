package sx.nme.media.extract;
import nme.net.URLRequest;
import nme.events.Event;
import nme.media.Sound;
import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */

class FlashMp3Extractor implements ISXSoundDataExtractor
{
	
	/*
	 * *********************************************************
	 * PRIVATE MEMBERS
	 * *********************************************************
	 *
	*/		
	
	private var _soundData:ByteArray;
	private var _sound:Sound;
	
	
	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(mp3Filename:String) {
		_soundData = null;
		_sound = null;					
		_prepareLoading(mp3Filename);
	}
	
	/*
	 * *********************************************************
	 * PRIVATE METHODS
	 * *********************************************************
	 *
	*/	
	
	private function _prepareLoading(filename:String) {
		_sound = new Sound();
		_sound.addEventListener(Event.COMPLETE, _onLoadComplete);
		_sound.load(new URLRequest(filename));			
	}

	private function _onLoadComplete(e:Event):Void {
		trace('load complete');		
		_soundData = new ByteArray();
		var x = _sound.extract(_soundData, 1000000000, 0);
		_afterLoading();
	}
	
	private function _afterLoading() {
		_sound.removeEventListener(Event.COMPLETE, _onLoadComplete);
		_sound = null;
	}
	
	/*
	 * *********************************************************
	 *  INTERFACE METHODS
	 * *********************************************************
	 *
	*/	
	
	public function getSoundData():ByteArray {
		return (_soundData != null) ? _soundData : throw "Sound data isn't extracted yet.";
	}	

	
}