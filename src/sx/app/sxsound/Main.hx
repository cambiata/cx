package sx.app.sxsound;

import haxe.io.Bytes;
import haxe.io.BytesData;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;
import com.bit101.components.HBox;
import com.bit101.components.PushButton;
import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.utils.ByteArray;
import sx.nme.media.extract.WavDataExtractor;
import sx.nme.media.format.File;
import sx.nme.media.format.FileWav;
import sx.nme.media.SXSound;

/**
 * ...
 * @author Jonas Nyström
 */

class Main extends Sprite
{

	static public function main() {
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;		
		Lib.current.addChild(new Main());
	}

	/*
	 * *********************************************************
	 * PRIVATE MEMBERS
	 * *********************************************************
	 *
	*/	
	
	private var hbox:HBox;
	private var button1:PushButton;
	private var button2:PushButton;
	private var _s:SXSound;
	
	/*
	 * *********************************************************
	 * CONSTRUCTOR
	 * *********************************************************
	 *
	*/	
	
	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	/*
	 * *********************************************************
	 * INITIALIZATION
	 * *********************************************************
	 *
	*/	

	private function init(e) {
		_createUI();
		var fw:FileWav = new FileWav();
		_s = new SXSound();
	}
	
	private function _createUI() {
		hbox = new HBox(Lib.current.stage, 0, 0);		
		button1 = new PushButton(hbox, 0, 0, 'Button 1', function(e:MouseEvent) {			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = nme.net.URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
				
				var ba:ByteArray  = cast(e.target, URLLoader).data;
				var wde:WavDataExtractor = new WavDataExtractor(ba);
				var buffer = wde.getSoundData();
				
				_s.setSoundData(buffer);
				_s.testPlay();
				
			});
			urlLoader.load(new URLRequest('rain_loop.wav'));			
		});
		
		button2 = new PushButton(hbox, 0, 0, 'Button 2', function(e:MouseEvent) {			
			_s.testStop();
		});
	}
	
	/*
	 * *********************************************************
	 * PUBLIC GETTERS & SETTERS
	 * *********************************************************
	 *
	*/	
		
	
	
	
	
}

