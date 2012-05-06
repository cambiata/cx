package nx.svg;

import nx.output.TScaling;
import nx.svg.SVG2Gfx;
import nme.display.Shape;


/**
 * ...
 * @author Jonas Nyström
 */

class SvgAssets 
{
	static public function getSvgShape(tag:String, ms:TScaling):Shape {
		
		var xmlStr:String = getSvgString(tag);
		var svg = new SVG2Gfx(Xml.parse(xmlStr));
		var shape = svg.CreateShape();
		shape.cacheAsBitmap = true;
		shape.scaleX = shape.scaleY = ms.svgScale;	
		
		return shape;
	}
	
	/*
	static public function getSvgShape2(svgXmlStr:String, scale:Float = 0.1):Shape {
		var svg = new SVG2Gfx(Xml.parse(svgXmlStr));
		var shape = svg.CreateShape();
		shape.cacheAsBitmap = true;
		shape.scaleX = shape.scaleY = scale;	
		return shape;
	}	
	*/
	

	static var fields:Array<String>;
	
	static public function getSvgString(tag:String):String {
		if (fields == null) fields = Type.getClassFields(NoteElements);
		if (Lambda.indexOf(fields, tag) > -1) {
			return Reflect.callMethod(NoteElements, Reflect.field(NoteElements, tag), []);
		}
		// if doesnt exist:
		return NoteElements.clefG();
	}
	
}