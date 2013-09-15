package scorx.audio.js;

/**
 * ...
 * @author Jonas Nyström
 */
class Mixer
{
	public function new(playCallback:Float->Float->Float->Void = null) {
		
	}
	
	private var playCallback:Float->Float->Float->Void;
	private var posCurrent:Float = 0;
	private var posStart:Float = 0;
	private var posStop:Float = 0;	
	
	public var isPlaying(default, null):Bool;	
	
	var sound:Dynamic;
	
	public function load(url:String):Void
	{
		url += "?ext=.mp3";
		
		this.sound = js.Lib.eval("new Howl({urls: [\"" + url + "\"]});");		
			
		trace(this.sound);
		
		if (this.sound == null) this.onError('ERROR: Is howler.js loaded?');		
		
		this.sound.on("load", function() {			
			trace('SOUND IS LOADED');						
		});

		this.sound.play();
	}	
	
	
	public function setVolumes(newVolumes: Array<Float>) 
	{
		
	}
	
	public function setVolume(channelNr:Int, volume:Float) 
	{
	
	}	
	
	public function startPlayback(posStart:Float = 0, posStop:Float = 1) 
	{
		trace('PLAAYY');
		this.sound.play();
	}
	
	public  function stopPlayback() 
	{	
		
	}
	
	public function getPosition():Float return this.posCurrent;
	
	dynamic public function onStart(posStart:Float) { };
	dynamic public function onStop() { };
	dynamic public function onError(msg:String) { };	
	
	
}