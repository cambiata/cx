package nx.svg;

import cx.ReflectTools;
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
	

	//static var fields:Array<String> = Type.getClassFields(NoteElements);
	
	static public function getSvgString(tag:String):String {
		/*
		try {
			return Reflect.callMethod(NoteElements, Reflect.field(NoteElements, tag), []);
		} catch (e:Dynamic) {
		}
		// if doesnt exist:
		return NoteElements.clefG();
		*/
		return NoteElements.getSvg(tag);
	}
	
}