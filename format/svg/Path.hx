package format.svg;

#if (nme)
import nme.geom.Matrix;
import nme.geom.Rectangle;
import nme.display.GradientType;
import nme.display.SpreadMethod;
import nme.display.InterpolationMethod;
import nme.display.CapsStyle;
import nme.display.JointStyle;
import nme.display.LineScaleMode;
#else
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.InterpolationMethod;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
#end

typedef PathSegments = Array<PathSegment>;

class Path
{
   public function new() { }

   public var matrix:Matrix;
   public var name:String;
   public var font_size:Float;
   public var fill:FillType;
   public var alpha:Float;
   public var fill_alpha:Float;
   public var stroke_alpha:Float;
   public var stroke_colour:Null<Int>;
   public var stroke_width:Float;
   public var stroke_caps:CapsStyle;
   public var joint_style:JointStyle;
   public var miter_limit:Float;

   public var segments:PathSegments;
}
