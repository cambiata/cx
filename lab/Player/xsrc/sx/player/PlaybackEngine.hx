package scorx.model;
import cx.audio.mixer.Mixer;
import flash.media.Sound;
import flash.utils.ByteArray;
import flash.Vector.Vector;
import scorx.data.ChannelsLoader.TChannelsData;
import scorx.data.TChannelData;

/**
 * ...
 * @author 
 */
class PlaybackEngine
{
	var sounds:Array<Sound>;
	var mixer:Mixer;
	var channelIds:Array<String>;
	
	public function new() 
	{
		this.channelIds = [];
	}
	
	public function reset()
	{
		this.sounds = new Array<Sound>();		
	}
	
	public function addChannel(channelId:String, data:ByteArray)
	{
		trace('addChannel ' + channelId + " " + data.length);				
		this.channelIds.push(channelId);
		var sound:Sound = new Sound();
		sound.loadCompressedDataFromByteArray(data, data.length);
		this.sounds.push(sound);
		
	}
	

	
	public function complete()
	{
		trace(sounds.length);
		this.mixer = new Mixer(sounds, function(startPos:Float, endPos:Float, curPos:Float) {
			trace(curPos);
		});		
	}
	
	public function start(startPos:Float= 0)
	{
		//this.mixer.stopPlayback();

		
		
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