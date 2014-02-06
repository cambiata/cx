package nx3.render.tools;


#if (nme)
import nme.display.BitmapData;
import nme.display.Sprite;
#else
import flash.display.BitmapData;
import flash.display.Sprite;
#end


/**
 * ...
 * @author 
 */
class RenderTools
{

	static public function spriteToPng(sprite:Sprite, filename:String, extraWidth:Int=100, extraHeight:Int=100)
	{
		#if (neko || windows)
		var bitmapData = new BitmapData(Std.int(sprite.width)+extraWidth, Std.int(sprite.height)+extraHeight, false);
		bitmapData.draw(sprite);		
		cx.FileTools.putBinaryContent(filename, bitmapData.encode('png').asString());		
		#end
	}
	
}