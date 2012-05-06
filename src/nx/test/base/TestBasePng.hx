package nx.test.base;
import cx.FileTools;
import haxe.unit.TestCase;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author Jonas Nyström
 */

class TestBasePng extends TestCase
{
	private var pngFilename:String;
	private var showPng:Bool;
	public var sprite:Sprite;
	
	override public function setup() {
		this.sprite = new Sprite();
	}
	
	public function spriteSave(filename:String, width:Int=1000, height:Int=600, execute:Bool=true) {
		var bitmapData = new BitmapData(width, height);
		bitmapData.draw(this.sprite);
		var byteArray = bitmapData.encode('png');	
		
		if (execute) {
			FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(filename), byteArray.asString());			
		} else {
			FileTools.putBinaryContent(neko.FileSystem.fullPath(filename), byteArray.asString());			
		}
	}
	
	public function new() 
	{
		super();
	}
	
}