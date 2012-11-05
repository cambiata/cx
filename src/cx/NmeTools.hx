package cx;
import nme.events.KeyboardEvent;
import nme.display.BitmapData;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.utils.ByteArray;

#if neko
import cx.FileTools;
#end

/**
 * ...
 * @author Jonas Nyström
 */

class NmeTools {	
	
	#if neko
	static public function spriteToPngTest() {
		var sprite = new nme.display.Sprite();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(20, 10, 8);
		sprite.graphics.drawCircle(220, 210, 8);
		spriteToPng(sprite, 'nmeToolsTestSprite.png');		
	}
	
	static public function spriteToPng(source : nme.display.Sprite, pngFileName:String, ?width=1000.0, ?height=600.0) {		
		if (width == 0) {
			width = source.width;
			height = source.height;
		}
		var bitmapData = new nme.display.BitmapData(Std.int(width), Std.int(height), false);
		bitmapData.draw(source);
		var byteArray = bitmapData.encode('png');
		FileTools.putBinaryContent(pngFileName, byteArray.asString());
	}
	#end
	
	/*
	static public function displayObjectToByteArray(source:DisplayObject, ?width=0.0, ?height=0.0) {		
		if (width == 0) {
			width = source.width;
			height = source.height;
		}
		var bitmapData = new nme.display.BitmapData(Std.int(width), Std.int(height), false);
		bitmapData.draw(source);
	}
	*/
	
	/*
	static public function rectangleArraysIntersection(ra1:Array<Rectangle>, ra2:Array<Rectangle>):Rectangle {
		var ret:Rectangle = null; // = new Rectangle(0, 0, 0, 0);
		//trace('');
		for (r1 in ra1) {
			if (r1 == null) continue;
			for (r2 in ra2) {
				if (r2 == null) continue;
				var i = r1.intersection(r2);
				//trace([r1, r2, i]);
				if ((i.width > 0) && (i.height > 0)) {
					ret = (ret != null) ? ret.union(r1.intersection(r2)) : r1.intersection(r2);
				}
			}
		}		
		return ret;
	}
	
	static public function rectangleArraysIntersection2(ra1:Array<Rectangle>, ra2:Array<Rectangle>):Rectangle {
		var ret:Rectangle = null; // = new Rectangle(0, 0, 0, 0);
		//trace('');
		for (r1 in ra1) {
			if (r1 == null) continue;
			for (r2 in ra2) {
				if (r2 == null) continue;
				var i = intersection2(r1, r2);
				//trace([r1, r2, i]);
				if ((i.width > 0) && (i.height > 0)) {
					ret = (ret != null) ? ret.union(intersection2(r1, r2)) : intersection2(r1, r2);
					
					if (r2.left < r1.left) {
						ret.width = r1.left - r2.left;
					}					
				}
			}
		}		
		return ret;
	}	
	*/
	
	/*
	static public function getRight(r:Rectangle):Float {
		
	}
	
	static public function getBottom(r:Rectangle):Float {
		
	}
	*/
	
	static public function rectanglePushX(r:Rectangle, x:Float):Rectangle {
		if (r == null) return null;
		r.offset(x, 0);
		return r.clone();
	}
	
	/*
	static public function intersection2(r1:Rectangle, r2:Rectangle):Rectangle {
		if (r1 == null) return null;
		if (r2 == null) return null;
		var r2test:Rectangle = r2.clone();
		r2test.width = 100000;

		if (!r1.intersects(r2test)) return new Rectangle(0, 0, 0, 0);
		var newX = Math.max(r1.left + r1.width, r2test.left);
		var moveX = newX - r2test.left;
		var newY = Math.max(r1.top + r1.height, r2test.top);
		var moveY = newY - r2test.top;

		return new Rectangle(0, 0, moveX, moveY);		
	}
	
	static public function arrayRectanglesOverlapX(rects1:Array<Rectangle>, rects2:Array<Rectangle>) {
		var move = 0.0;
		for (r1 in rects1) {
			for (r2 in rects2) {
				var r3 = NmeTools.intersection2(r1, r2);
				move = Math.max(move, r3.width);
			}
		}
		return move;
	}	
	*/
	
	
	static public function byteArrayCopy(source:ByteArray):ByteArray {				
		var copy:ByteArray = new ByteArray();
		source.position = 0;
		source.readBytes(copy, 0, source.length);
		copy.position = 0;
		return copy;
	}
	
	/*
	static public function getKeyCode(e:KeyboardEvent) {
		var keyCode = e.keyCode;
		
		#if (neko || cpp) 
			if (e.keyCode == e.charCode)
				if (keyCode >= 65 && keyCode <= 122) {
					keyCode = keyCode-32;
				}
		#end		
		
		return keyCode;
	}
	*/
	
	
}	

