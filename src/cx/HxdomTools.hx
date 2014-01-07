package cx;
import hxdom.Elements.EHtml;
import hxdom.HtmlSerializer;
import thx.xml.XmlFormat;

/**
 * ...
 * @author Jonas Nyström
 */
class HxdomTools
{
	static public function ehtmlToHtml(ehtml:EHtml, format:Bool=true, clean:Bool=false)
	{
		var html = HtmlSerializer.run(ehtml);
		if (clean) html = cleanHtml(html);
		if (format) {
			var xml:Xml = Xml.parse(html);		
			var format = new XmlFormat(true, '\t');
			html = format.format(xml).toString();	
		}
		return html;
	}	
	
	
	static public function cleanHtml(htmlStr:String)
	{
		var str = htmlStr;
		var r = ~/data-hxclass='[a-zA-Z0-9-.\s]+'/g;
		str = r.replace(str, "");		
		var r = ~/data-hxid='[a-zA-Z0-9-.\s]+'/g;
		str = r.replace(str, "");		
		str = StringTools.replace(str, "  ", " ");		
		return str;
	}
	
	
}