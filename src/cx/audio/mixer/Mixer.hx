package cx.audio.mixer;

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

class Mixer {
	private var sounds:Vector<Sound>;
	private var bytes:Vector <ByteArray>;
	private var volumes:Vector<Float>;
	private var channelsCount:Int;
	static private var maxChannels:Int = 7;
	private var bufferSize:Int;
	private var doubleBuffer:Int;
	private var bufferPos:Int;	
	private var bufferEnd:Int;
	private var posCurrent:Float;
	private var posStart:Float;
	private var posStop:Float;
	private var outputSnd:Sound;
	private var outputChannel:SoundChannel;
	private var volumeTransform:SoundTransform;
	private var playCallback:Float->Float->Float->Void;
	
	public function new(sounds:Array<Sound>=null, playCallback:Float->Float->Float->Void=null) {
		bufferSize = 4096;
		doubleBuffer = bufferSize * 2;
		bufferPos = 0;		
		outputSnd = new Sound();
		outputSnd.addEventListener(SampleDataEvent.SAMPLE_DATA, processSampleData);
		this.volumes = new Vector<Float>();
		for (i in 0...maxChannels) volumes[i] = 0.7;
		stopTimer = new Timer(10);
		stopTimer.addEventListener(TimerEvent.TIMER, stopTimerHandler);
		volumeTransform = new SoundTransform();
		this.playCallback = playCallback;
		if (sounds != null) this.setSounds(sounds);
	}
	
	public function setSounds(sounds:Array<Sound>) {
		this.sounds = new Vector<Sound>();
		this.bytes = new Vector<ByteArray>();
		for (sound in sounds) {
			this.sounds.push(sound);
			this.bytes.push(new ByteArray());
		}
		this.channelsCount = this.sounds.length;			
		this.bufferEnd = Std.int((this.sounds[0].length/100) * this.bufferSize);
	}
	
	public function setVolumes(newVolumes: Array<Float>) {
		var i = 0;
		for (i in 0...newVolumes.length) this.setVolume(i, newVolumes[i]);
	}	
	
	public function setVolume(channelNr:Int, volume:Float) {
		this.volumes[channelNr] = volume;
	}
	
	private function processSampleData(e:SampleDataEvent):Void {
		for(i in 0...this.channelsCount) {
			bytes[i].position = 0;
			sounds[i].extract(bytes[i], bufferSize, bufferPos);
			bytes[i].position = 0;
		}
		
		for (j in 0...doubleBuffer){
			var val:Float = 0;
			for (i in 0...this.channelsCount) val += bytes[i].readFloat() * volumes[i];				
			e.data.writeFloat(val);			
		}			
		bufferPos += bufferSize;		
		posCurrent = bufferPos / bufferEnd;
		
		if (posCurrent >= posStop) this.stopPlayback();
		if (playCallback != null) this.playCallback(posStart, posStop, posCurrent);		
	}
	
	public function startPlayback(posStart:Float=0, posStop:Float=1) {
		this.posStart = Math.min(1, posStart);
		this.posStop = Math.max(this.posStart, posStop);
		this.bufferPos = Std.int((this.sounds[0].length / 100) * this.bufferSize * posStart);
		this.outputChannel = this.outputSnd.play();
	}	
	
	private var stopTimer:Timer;
	private function stopTimerHandler(event:Event) {
		stopTimer.stop();	
		this.outputChannel.stop();
	} 
	
	private function stopPlayback() {
		stopTimer.start();
	}
	
	public function setMainVolume(volume:Float) {	
		volumeTransform.volume = volume;
		this.outputChannel.soundTransform = volumeTransform;		
	}
} 

