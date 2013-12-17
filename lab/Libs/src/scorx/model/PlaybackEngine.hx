package scorx.model;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.Lib;
import flash.media.Sound;
import flash.utils.ByteArray;
import flash.Vector.Vector;
import scorx.data.TChannelData;
import scorx.data.TChannelsData;

import msignal.Signal.Signal0;
import msignal.Signal.Signal1;

#if flash
	import scorx.data.Mixer;
#end

#if js
	import scorx.audio.js.Mixer;
#end

/**
 * ...
 * @author 
 */
class PlaybackEngine 
{
	public var sounds(default, null):Array<Sound>;
	
	
	public var mixer:Mixer;

	
	var channelIds:Array<String>;
	
	public var onStart:Signal1<Float>;
	public var onStop:Signal0;
	public var onError:Signal1<String>;
	public var onPosition:Signal1<Float>;		
	
	public function new() 
	{
		this.channelIds = [];
		this.onStart = new Signal1<Float>();
		this.onStop = new Signal0();
		this.onPosition = new Signal1<Float>();	
		this.onError = new Signal1<String>();
	}
	
	public function reset()
	{
#if flash		
		this.sounds = [];	
#end		
	}
	
	public function addChannels(channels:TChannelsData)
	{
#if flash		
		this.reset();
		for (channel in channels)
		{
			var ch:TChannelData = channel;
			this.channelIds.push(ch.id);
			var sound:Sound = new Sound();			
			sound.loadCompressedDataFromByteArray(ch.data, ch.data.length);
			this.sounds.push(sound);
		}
		this.complete();
#end	
	}

	public function loadOneFile(url:String)
	{
		#if js
			this.mixer = new Mixer(function(startPos:Float, endPos:Float, curPos:Float) {			
				this.onPosition.dispatch(curPos);
			});
			this.mixer.load(url);
		#end
	}
	
	public function getSoundLength():Float
	{
		return this.sounds[0].length;		
	}
	
	public function complete()
	{
#if flash		
		this.mixer = new Mixer(sounds, function(startPos:Float, endPos:Float, curPos:Float) {			
			this.onPosition.dispatch(curPos);
		});
		this.mixer.onStart = this.mixerStart;
		this.mixer.onStop = this.mixerStop;
		this.mixer.onError = this.mixerError;
#end
	}
	
	public function start(startPos:Float= 0)
	{
		if (startPos >= 1) startPos = 0;
		
		if (this.mixer == null) return;
		this.mixer.startPlayback(startPos);				

	}
	
	public function stop()
	{

		if (this.mixer == null) return;		
		this.mixer.stopPlayback();		

	}
	
	public function isPlaying():Bool 
	{

		if (this.mixer == null) return false;		
		return this.mixer.isPlaying;	
	}
	
	public function setVolume(channelId:String, value:Float)
	{
		var chNr = Lambda.indexOf(channelIds, channelId);		

		if (this.mixer == null) return;		
		this.mixer.setVolume(chNr, value);

	}
	
	private function mixerStart(pos:Float)
	{
		trace('MIXER mixerStart');
		this.onStart.dispatch(pos);
	}
	
	private function mixerStop()
	{
		trace('MIXER mixerStop');
		this.onStop.dispatch();
	}
	
	private function mixerError(msg:String)
	{
		trace(msg);
		this.onError.dispatch(msg);
	}
	
}