package nx3.render.svg;
import cx.ReflectTools;

import flash.display.Shape;


import format.SVG;
import format.svg.SVG2Gfx;



import haxe.macro.Format;
import nx3.render.scaling.TScaling;

/**
 * ...
 * @author 
 */
class ShapeTools
{
	static public function getShape(xmlStr:String, scaling:TScaling) : Shape
	{
		if (xmlStr == null) return null;
		var svg:SVG2Gfx = new SVG2Gfx(Xml.parse(xmlStr));		
		var shape:Shape = svg.createShape();
		shape.scaleX = shape.scaleY = scaling.svgScale;		
		shape.cacheAsBitmap = true;
		return shape;
	}	
	
	static public function getElementStr(element:String):String
	{
		//trace(element);
		try 
		{
			var str = Reflect.field(Elements, element);
			return str;
			
		}
		catch (err:Dynamic)
		{
			return Elements.noteBlack;
		}
		return null;
	}
}