package cx.nme.display.utils;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Loader;
import nme.display.LoaderInfo;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.net.URLLoader;
import nme.net.URLLoaderDataFormat;
import nme.net.URLRequest;

/**
 * ...
 * @author Jonas Nyström
 */

class NumberLoader {
	
	private var number:Array<Int>;
	private var bds:Array<BitmapData>;
	private var widths:Array<Int>;
	private var parsed:Bool;
	
	public function new(filename:String) {
		widths = [10, 7, 10, 9, 9, 9, 9, 9, 9, 9, 4, 5];		
		bds = [];		
		
		var loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event) {
			var bd:BitmapData = cast(cast(e.target, LoaderInfo).content, Bitmap).bitmapData;
			this.parseBitmapData(bd);
		});
		loader.load(new URLRequest(filename));		
	}
	
	private function parseBitmapData(bd:BitmapData) {
		var x = 0.0;
		for (i in 0...11) {
			bds[i] = new BitmapData(widths[i], 12, true);
			bds[i].copyPixels(bd, new Rectangle(x, 12, widths[i], 12), new Point(0, 0));				
			x += widths[i];
		}	
		this.parsed = true;
	}
	
	public function getNumberFromString(str:String):Bitmap {
		if (!this.parsed) throw "Not parsed numbers!";
		var a:Array<Int> = [];
		
		var width:Int = 0;
		for (c in str.split('')) {
			var value = Std.parseInt(c);
			value = (value != null) ? value : 10;
			a.push(value);
			width += widths[value];
		}
		var bdNumber:BitmapData = new BitmapData(width, 12, true);
		var x = 0;
		for (i in a) {
			bdNumber.copyPixels(bds[i], new Rectangle(0, 0, widths[i], 12), new Point(x, 0));		
			x += widths[i];
		}			
		var bdFinish:Bitmap = new Bitmap(bdNumber);		
		
		return bdFinish;
		
	}
	
	public function getNumber(float:Float, decimals:Int = 5):Bitmap {
		if (!this.parsed) throw "Not parsed numbers!";
		var str = Std.string(float).substr(0, decimals);
		return this.getNumberFromString(str);
	}
	
	private var hashNumber:Hash<Bitmap>;
	
	public function getNumberCache(float:Float, decimals:Int = 5):Bitmap {
		if (!this.parsed) throw "Not parsed numbers!";
		var str = Std.string(float).substr(0, decimals);				
		if (this.hashNumber == null) this.hashNumber = new Hash<Bitmap>();
		if (this.hashNumber.exists(str)) return new Bitmap(this.hashNumber.get(str).bitmapData);
		
		var bmp = getNumberFromString(str);
		this.hashNumber.set(str, bmp);
		return bmp;
		
	}
	
}
