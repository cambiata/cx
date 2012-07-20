package sx.app.sxsound;

import com.bit101.components.ProgressBar;
import cx.NmeTools;
import haxe.io.Bytes;
import haxe.io.BytesData;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;
import com.bit101.components.HBox;
import com.bit101.components.PushButton;
import nme.media.Sound;
import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.utils.ByteArray;
import sx.nme.media.extract.WavDataExtractor;
import sx.nme.media.format.File;
import sx.nme.media.format.FileWav;
import sx.nme.media.SXSound;
import sx.nme.media.SXSoundMulti;

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
	private var progressBar:ProgressBar;
	private var _sm:SXSoundMulti;
	private var sound1:ByteArray;
	private var sound2:ByteArray;
	private var fyyr:ByteArray;
	
	
	
	
	
	
	
	
	
	
	
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
		_sm = new SXSoundMulti();
	}
	
	private function _createUI() {
		hbox = new HBox(Lib.current.stage, 0, 0);		
		button1 = new PushButton(hbox, 0, 0, 'Button 1', function(e:MouseEvent) {			
			if (sound1 != null ) {
				_sm.addSoundData(sound1);		
				return;				
			}
			
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = nme.net.URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
				
				var wde:WavDataExtractor = new WavDataExtractor(cast(e.target, URLLoader).data);
				
				wde.onProgress = function(bytesLoaded:Int, bytesTotal:Int) {
					var value = bytesLoaded / bytesTotal;
					this.progressBar.setValue(value);
				}				
				
				sound1 = wde.getSoundData();				
				//_s.setSoundData(soundData);
				//_s.testPlay();
				fyyr  = _sm.addSoundData((sound1));	
				//_sm.testPlay();
				
			});
			urlLoader.load(new URLRequest('6.wav'));			
		});
		
		button2 = new PushButton(hbox, 0, 0, 'Button 2', function(e:MouseEvent) {			
			
			/*
			if (sound2 != null ) {
				_sm.addSoundData((sound2));		
				return;				
			}
			*/
			
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = nme.net.URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE, function(e:Event) {
				
				var wde:WavDataExtractor = new WavDataExtractor(cast(e.target, URLLoader).data);
				
				wde.onProgress = function(bytesLoaded:Int, bytesTotal:Int) {
					var value = bytesLoaded / bytesTotal;
					this.progressBar.setValue(value);
				}				
				
				sound2 = wde.getSoundData();				
				//_s.setSoundData(soundData);
				//_s.testPlay();
				//_sm.addSoundData((sound2));		
				
				_sm.replaceSoundData(fyyr, sound2);
				
				
				//_sm.testPlay();
				
			});
			urlLoader.load(new URLRequest('6b.wav'));	
			
		});
		
		progressBar = new ProgressBar(hbox, 0, 0);
		progressBar.maximum = 1;
		
	}
	
	/*
	 * *********************************************************
	 * PUBLIC GETTERS & SETTERS
	 * *********************************************************
	 *
	*/	
		
	
}

