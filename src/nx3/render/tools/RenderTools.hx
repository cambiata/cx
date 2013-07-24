package nx3.render.tools;
import flash.display.BitmapData;
import flash.display.Sprite;

/**
 * ...
 * @author 
 */
class RenderTools
{

	static public function spriteToPng(sprite:Sprite, filename:String, extraHeight:Int=100)
	{
		#if (neko || windows)
		var bitmapData = new BitmapData(Std.int(sprite.width), Std.int(sprite.height)+extraHeight, false);
		bitmapData.draw(sprite);		
		cx.FileTools.putBinaryContent(filename, bitmapData.encode('png').asString());		
		#end
	}
	
}