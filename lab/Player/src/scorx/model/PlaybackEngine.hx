package scorx.model;
import cx.audio.mixer.Mixer;
import flash.events.Event;
import flash.media.Sound;
import flash.utils.ByteArray;
import flash.Vector.Vector;
import scorx.data.TChannelData;
import scorx.data.TChannelsData;

/**
 * ...
 * @author 
 */
class PlaybackEngine
{
	public var sounds(default, null):Array<Sound>;
	var mixer:Mixer;
	var channelIds:Array<String>;
	var nrOfChannels:Int;
	var nrOfLoaded:Int;
	
	public function new() 
	{
		this.channelIds = [];
	}
	
	public function reset()
	{
		this.sounds = [];		
		this.nrOfChannels = 0;
		this.nrOfLoaded = 0;
	}
	
	public function addChannel(channelId:String, data:ByteArray)
	{
		trace('addChannel ' + channelId + " " + data.length);				
		this.channelIds.push(channelId);
		var sound:Sound = new Sound();
		sound.loadCompressedDataFromByteArray(data, data.length);
		this.sounds.push(sound);
	}

	
	public function addChannels(channels:TChannelsData)
	{
		this.reset();
		this.nrOfChannels = channels.length;
		
		for (channel in channels)
		{
			var ch:TChannelData = channel;
			this.channelIds.push(ch.id);
			var sound:Sound = new Sound();
			//sound.addEventListener(flash.events.s, onSoundComplete);
			sound.loadCompressedDataFromByteArray(ch.data, ch.data.length);
			this.sounds.push(sound);
		}
	}	
	
	private function onSoundComplete(e:Event):Void 
	{
		this.nrOfLoaded++;
		trace([this.nrOfLoaded + ' / ' + this.nrOfChannels]);
	}
	
	public function complete()
	{
		
		this.mixer = new Mixer(sounds, function(startPos:Float, endPos:Float, curPos:Float) {
			trace(curPos);
			
		});		
		
		
		
		
	}
	
	public function start(startPos:Float= 0)
	{
		for (sound in this.mixer.sounds)
		{
			trace(sound.length);
		}		
		this.mixer.startPlayback(startPos);				
	}
	
	public function stop()
	{
		this.mixer.stopPlayback();		
	}
	
	public function isPlaying():Bool 
	{
		return this.mixer.isPlaying;	
	}
	
	public function setVolume(channelId:String, value:Float)
	{
		var chNr = Lambda.indexOf(channelIds, channelId);		
		this.mixer.setVolume(chNr, value);		
	}
	
}