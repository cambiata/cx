package sx.nme.media;
import cx.NmeTools;
import nme.events.SampleDataEvent;
import nme.media.Sound;
import nme.media.SoundChannel;
import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */

class SXSoundMulti 
{
		
	/*
	 * *********************************************************
	 * PRIVATE MEMBERS
	 * *********************************************************
	 *
	*/
	
	private var _sound:Sound;
	private var _soundChannel:SoundChannel;
	private var _soundData:ByteArray;
	private var _bufferLenght:Int;
	private var _pos:Int;
	
	private var _soundDatas:Array<ByteArray>;
	
	
	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(soundData:ByteArray=null) {
		_sound = new Sound();
		//_soundChannel = new SoundChannel();		
		_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);		
		_soundData = soundData;
		_bufferLenght = 2048 * 4 * 2;
		_pos = 0;
		
		_soundDatas = new Array<ByteArray>();
		testPlay();
	}
	
	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	private function onSampleData(e:SampleDataEvent):Void {
		for (soundData in _soundDatas) {		
			_pos = soundData.position;
			if (_pos >= soundData.length - _bufferLenght) {
				_soundDatas.remove(soundData);
				soundData = null;				
			}			
		}
		
		for (i in 0...2048) {					
			var left:Float = 0.0;
			var right:Float = 0.0;
			for (soundData in _soundDatas) {
				left += soundData.readFloat();
				right += soundData.readFloat();
			}
			e.data.writeFloat(left);
			e.data.writeFloat(right);			
		}
		
		trace(_soundDatas.length);
		/*
		trace([_soundData.position, _soundData.length]);
		_pos = _soundData.position;		
		if (_pos < _soundData.length - _bufferLenght) {
			for (i in 0...2048) {		
				var left:Float = _soundData.readFloat();
				var right:Float = _soundData.readFloat();				
				e.data.writeFloat(left);
				e.data.writeFloat(right);
			}
			return;
		}
		
		for (i in 0...2048) {		
			e.data.writeFloat(0);
			e.data.writeFloat(0);
		}	
		*/
	}
	
	

	/*
	 * *********************************************************
	 * PUBLIC METHODS
	 * *********************************************************
	 *
	*/	
	
	public function setSoundData(soundData:ByteArray) {
		_soundData = soundData;
		_soundData.position = 0;
	}
	
	public function testPlay() {		
		_soundChannel = _sound.play();		
	}
	
	public function testStop() {
		_soundChannel.stop();
	}
	

	public function addSoundData(soundData:ByteArray) {
		var sd = NmeTools.byteArrayCopy(soundData);
		sd.position = 0;
		this._soundDatas.push(sd);		
		trace(this._soundDatas.length);
		return sd;
	}
	
	public function replaceSoundData(oldData:ByteArray, newData:ByteArray) {
		
		var idx = 0;
		for (soundData in _soundDatas) {
			idx++;
			if (soundData == oldData) {
				trace('FOUND');
			}			
		}

		if (idx > 0) {
			trace('YKKAS');
			var soundData = NmeTools.byteArrayCopy(newData);
			soundData.position = 0;
			_soundDatas[idx - 1] = soundData;

		}
		
		
	}
	
}