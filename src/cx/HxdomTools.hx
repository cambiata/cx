package cx;
import hxdom.Elements.EHtml;
import hxdom.Elements.VirtualElement;
import hxdom.Elements.VirtualNode;
import hxdom.html.Element;
import hxdom.html.HtmlElement;
import hxdom.HtmlSerializer;
import thx.xml.XmlFormat;

/**
 * ...
 * @author Jonas Nyström
 */
class HxdomTools
{
	static public function ehtmlToHtml(ehtml:EHtml, format:Bool=true, clean:Bool=false, stripOuterLevels=0):String
	{
		var html = HtmlSerializer.run(ehtml);
		if (clean) html = cleanHtml(html);
		
		if (format) {
			var xml:Xml = Xml.parse(html);		
			
			var l = 0;
			while (l <= stripOuterLevels) 
			{
				xml = xml.firstElement();
				l++;
			}
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

	static public function toHtml(?e:EHtml, ?e2:VirtualElement<Dynamic>, ?format:Bool=true, ?clean:Bool=false, ?stripOuterLevels=0) : String
	{
		var html:EHtml = null;
		if (e != null)
		{
			html = e;
		}
		else if (e2 != null)
		{
			html = new EHtml();
			html.appendChild(e2);
			stripOuterLevels++;
		}
		else
		{
			throw "Html conversion error!";
		}
		
		return HxdomTools.ehtmlToHtml(html, format, clean, stripOuterLevels);
		
	}
	
	
}