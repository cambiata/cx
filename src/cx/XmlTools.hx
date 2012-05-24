package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class XmlTools 
{
	static public function getElementContent(entry:Xml, elementName:String):String {
		return entry.elementsNamed(elementName).next().firstChild().toString();	
	}
	
	static public function getElementAttrValue(entry:Xml, elementName:String, attribute:String): String {
		return entry.elementsNamed(elementName).next().get(attribute);		
	}
	
	
}