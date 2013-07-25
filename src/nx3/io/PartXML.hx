package nx3.io;
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
	
	static public function toXml(part:NPart): Xml
	{
		var xml:Xml = Xml.createElement(XPART);		
		
		// type
		switch(part.)
		{
			case EPartType.Normal:
				// nothing for Normal
			default:
				xml.set(XPART_TYPE, Std.string(part.type));
		}			
	}
}