package cx.nme.media.example;

import nme.media.Sound;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.SampleDataEvent;
import nme.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

class NekoSoundSine extends Sprite 
{
	private var sound:Sound;
	private var phase:Float;
	private var step:Float;
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}
	
	private function onSampleData(e:SampleDataEvent):Void 
	{
		for (i in 0...2048) {
			e.data.writeFloat(Math.sin(phase));
			e.data.writeFloat(Math.sin(phase));
			phase += step;
		}
	}

	private function init(e) 
	{
		phase  = 0;
		step = Math.PI*2 * 440/44100;		
				
		this.sound = new Sound();
		this.sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
		this.sound.play();
		
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e:Event) {
			this.sound.play();
			trace('hello');
		});
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new NekoSoundSine());
	}
	
}
