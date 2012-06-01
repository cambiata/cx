package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class HtmlfileTools 
{
	static public function getItems(htmlString:String):Array<HtmlItem> {
		var result = new Array<HtmlItem>();
		var bodyXml = findBody(htmlString);
		if (bodyXml == null) return result;
		return result;
	}
	
	static private function findBody(htmlString:String):Xml
	{
		try {
			var xml = Xml.parse(htmlString).firstElement();
			if (xml.nodeName.toLowerCase() == 'body') return xml;
		} catch (e:Dynamic) {}
			
		try {
			var xml = Xml.parse(htmlString).firstElement().firstElement();
			if (xml.nodeName.toLowerCase() == 'body') return xml;
		} catch (e:Dynamic) {}
			
		try {
			var xml = Xml.parse('<body>' + htmlString + '</body>');
			trace(xml);
			if (xml.nodeName.toLowerCase() == 'body') return xml;
		} catch (e:Dynamic) {}
		
		return null;
	}
	
}

typedef HtmlItem = {
	tag:String,
	text:String,
	anchor:String,
}