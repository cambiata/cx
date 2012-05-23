package cx.audio.command;
import cx.AudioTools;
import cx.BytesTools;
import cx.command.Command;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.events.Event;
/**
 * ...
 * @author Jonas Nyström
 */

class Mp3SegmentsCommand extends Command
{
	private var filename:String;
	private var nrOfChannels:Int;
	private var sounds:Array<Sound>;

	public function new(filename:String, nrOfChannels:Int=4) {
		super();
		this.filename = filename;		
		this.nrOfChannels = nrOfChannels;
	}
	
	override private function execute() {
		var l = new URLLoader();
		l.dataFormat = URLLoaderDataFormat.BINARY;
		l.load(new URLRequest(this.filename));		
		l.addEventListener(Event.COMPLETE, function(event:Event) {
			//trace('complete');
			var ba = cast(l.data, ByteArray);
			trace(ba.length);		
			var bytesList = BytesTools.splitByteArray(ba, this.nrOfChannels);
			//trace(bytesList.length);
			AudioTools.byteArrayListToSoundsArray(bytesList, function(sounds:Array<Sound>) {
				//trace('sounds!');
				//trace(sounds.length);
				this.sounds = sounds;
				this.complete();
			});
		});			
	}
	
	public function getSounds():Array<Sound> {
		return this.sounds;
	}	
}