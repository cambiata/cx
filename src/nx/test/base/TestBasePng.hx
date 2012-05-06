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
		sprite.graphics.beginFill(0xFF0000);
		sprite.graphics.drawRect(10, 10, 30, 30);		
		
	}
	
	public function new(showPng:Bool=false, pngFilename:String=null) 
	{
		super();
		this.showPng = showPng;
		this.pngFilename = pngFilename;
	}
	
	override public function tearDown() {
		var bitmapData = new BitmapData(1000, 500);
		bitmapData.draw(this.sprite);
		var byteArray = bitmapData.encode('png');	
		var pngFilename =  (this.pngFilename != null) ? this.pngFilename : StringTools.replace(Type.getClassName(Type.getClass(this)), '.', '-') + '.png';
		
		if (showPng) {
			FileTools.putBinaryContentExecute(neko.FileSystem.fullPath(pngFilename), byteArray.asString());			
		} else {
			FileTools.putBinaryContent(neko.FileSystem.fullPath(pngFilename), byteArray.asString());			
		}
		
		
		
	}
	
	
}