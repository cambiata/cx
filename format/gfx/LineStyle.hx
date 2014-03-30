package format.gfx;

#if (nme)
import nme.display.LineScaleMode;
import nme.display.CapsStyle;
import nme.display.JointStyle;

#else
import flash.display.LineScaleMode;
import flash.display.CapsStyle;
import flash.display.JointStyle;
#end

class LineStyle
{
   public var thickness:Float;
   public var color:Int;
   public var alpha:Float;
   public var pixelHinting:Bool;
   public var scaleMode:LineScaleMode;
   public var capsStyle:CapsStyle;
   public var jointStyle:JointStyle;
   public var miterLimit:Float;

   public function new()
   {
      thickness = 1.0;
      color = 0x000000;
      alpha = 1.0;
      pixelHinting = false;
      scaleMode = LineScaleMode.NORMAL;
      capsStyle = CapsStyle.ROUND;
      jointStyle = JointStyle.ROUND;
      miterLimit = 3.0;
   }
}
