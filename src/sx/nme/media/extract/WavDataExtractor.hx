package sx.nme.media.extract;
import nme.utils.ByteArray;
import sx.nme.media.format.FileWav;

/**
 * ...
 * @author Jonas Nyström
 */

class WavDataExtractor implements ISXSoundDataExtractor
{

    private var _fmtWave : FileWav;	
	private var _decodedByteArray:ByteArray;
	private var _loadedByteArray:ByteArray;
	
	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/
	
	public function new(wavDataArray:ByteArray) {
		_loadedByteArray = wavDataArray;
	}
	
	private function decodeWav(loadedByteArray:ByteArray):ByteArray {		
		_decodedByteArray = new ByteArray();
		_loadedByteArray = loadedByteArray;		
		
		_fmtWave = new FileWav();
		_fmtWave.setSize(Std.int(_loadedByteArray.length));		
		_readLoop();
		
		_loadedByteArray = null;
		_fmtWave = null;
		return _decodedByteArray;				
		
		//return null;
	}
		
	private function _readLoop() {
		
		while (_loadedByteArray.position < _loadedByteArray.length) {
			_fmtWave.push( _loadedByteArray, false );
			_fmtWave.populate(44100);
			
			
			if (_fmtWave.samplesAvailable()>0) {
				var samples = _fmtWave.getSamples();
				trace(samples.length);
				
				var ind = new Array<Int>(); 
				ind[0] = 0;
				var cnt = samples[0].length;
				this.writeDecodedData(samples, ind, cnt, _fmtWave.last);
				
			}	
			
		}
	}
		
    private function writeDecodedData(pcm : Array<Array<Float>>, index : Array<Int>, samples : Int, last : Bool = false) : Void {		
        
		var i : Int;
        var end : Int;
		var c1 = pcm[0];
		var c2 = pcm[1];
		i = index[0];
		var i2 = index[1];
		end = i + samples;

#if neko
		if (i2 == null) i2 = 0;
#end
		
		while (i < end) {
			var left:Float = c1[i];
			var right:Float = c2[i2++];
			_decodedByteArray.writeFloat(left);
			_decodedByteArray.writeFloat(right);
			//_decodedByteArray.writeFloat(c1[i]);
			//_decodedByteArray.writeFloat(c2[i2++]);
			i++;
		}
		
		
		
    }		
	
	/* INTERFACE sx.nme.media.extract.ISXSoundDataExtractor */
	
	public function getSoundData():ByteArray {
		return decodeWav(_loadedByteArray);
	}
	
	
	
	
	
}