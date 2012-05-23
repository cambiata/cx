package cx;
import de.polygonal.core.sound.MP3Sound;
import flash.events.SampleDataEvent;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Timer;
import flash.Vector;
import flash.events.Event;

/**
 * ...
 * @author Jonas Nyström
 */

class AudioTools
{
	static public function mp3SegmentsFileToSoundsArray(filename:String, nrOfChannels:Int, callbackFunction:Array<Sound>->Void, segmentsLength:Int = 4) {
		var l = new URLLoader();
		l.dataFormat = URLLoaderDataFormat.BINARY;
		l.load(new URLRequest(filename));
		l.addEventListener(Event.COMPLETE, function(event:Event) {			
			var ba:ByteArray = l.data;
			var bytesList = BytesTools.splitByteArray(ba, nrOfChannels, segmentsLength);			
			byteArrayListToSoundsArray(bytesList, callbackFunction);
		});		
	}
	
	static public function byteArrayListToSoundsArray(byteArrayList:Array<flash.utils.ByteArray>, callbackFunction:Array<Sound>->Void) {
		var sounds = new Array<Sound>();
		var mp3Sounds = new Array<MP3Sound>();	
		var i = 0;
		var chNr = byteArrayList.length;
			for (ba in byteArrayList) {
				var mp3s = new MP3Sound('Sound' + i++);
				mp3s.ofBytes(ba, function(mp3Sound:MP3Sound) {					
					mp3Sounds.push(mp3Sound);
					if (mp3Sounds.length == chNr) {
						mp3Sounds.sort(function(a, b) { return Reflect.compare(a.qname, b.qname); } );
						for (mp3Sound in mp3Sounds) {
							//trace(mp3Sound.qname);
							sounds.push(mp3Sound.sound);
						}
						callbackFunction(sounds);
					}
				});					
			}		
		return null;
	}

}

