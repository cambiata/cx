package nx3.io;
import nx3.elements.EClef;
import nx3.elements.EDisplayALN;
import nx3.elements.EPartType;
import nx3.elements.NPart;

/**
 * ...
 * @author 
 */
class PartXML
{
	static public inline var XPART:String = "part";
	static public inline var XPART_TYPE:String = "type";
	static public inline var XPART_CLEF:String = "clef";
	static public inline var XPART_CLEFDISPLAY:String = "clefdisplay";
	
	static public function toXml(part:NPart): Xml
	{
		var xml:Xml = Xml.createElement(XPART);		
		
		// type
		switch(part.type)
		{
			case EPartType.Normal:
				// nothing for Normal
			default:
				xml.set(XPART_TYPE, Std.string(part.type));
		}
		
		switch(part.clef)
		{
			case EClef.ClefG:
				// nothing for G-clef
			default:
				xml.set(XPART_CLEF, Std.string(part.clef);			
		}
		
		switch(part.clefDisplay)
		{
			case EDisplayALN.Layout:
				// nothing for Layout
			default:
				xml.set(XPART_CLEFDISPLAY, Std.string(part.
		}
	}
}