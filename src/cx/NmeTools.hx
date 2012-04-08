package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class NmeTools {	
	static public function spriteToPngTest() {
		var sprite = new nme.display.Sprite();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(20, 10, 8);
		sprite.graphics.drawCircle(220, 210, 8);
		spriteToPng(sprite, 'nmeToolsTestSprite.png');		
	}
	
	static public function spriteToPng(source : nme.display.Sprite, pngFileName:String, ?width=0.0, ?height=0.0) {		
		if (width == 0) {
			width = source.width;
			height = source.height;
		}
		var bitmapData = new nme.display.BitmapData(Std.int(width), Std.int(height), false);
		bitmapData.draw(source);
		var byteArray = bitmapData.encode('x');
		FileTools.putContentBinary(pngFileName, byteArray.asString());
	}
}	
	
