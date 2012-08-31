package cx;

/**
 * ...
 * @author Jonas Nyström
 */

 /*
class Main {	
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var keyTestSheet = '0Ar0dMoySp13UdE93Vno1QlJ3cklrLW5zTWItOTRZS2c';
	
	static function main() {
		var gs = new cx.GoogleTools.Spreadsheet(email, passwd, keyTestSheet);
		trace(gs.getCells());
	}		
} 
*/
 using StringTools;
class HtmlTools 
{
	static public function getTableFromArray(items:Array<Array<String>>) {
		var html = '';
		html += '<table width="100%" border="1">';
		for (row in items) {
			trace(row);
			html += '<tr>';
			for (cell in row) {
				html += '<td>';
				html += cell;
				html += '</td>';
				
			}
			html += '</tr>';
		}
		html += '</table>';
		return html;
	}
	
	static public function getMeta() {
		return '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
	}	
	
	static public function closeImageTags(htmlString:String) {
		var r = ~/(<img)([^>]*)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}
	
	static public function closeHrTags(htmlString:String) {
		var r = ~/(<hr)([^>]*)(>)/gim; 
		return r.replace(htmlString, "$1$2/>");		
	}	
	
	static public function getCssStyles(htmlString:String):Array<TCssStyle> {
		var xml:Xml;
		try {
			var content = RegexTools.closeImageTags(htmlString);
			content = RegexTools.closeHrTags(content);				
			xml = Xml.parse(content);			
		} catch (e:Dynamic) {
			xml = Xml.parse(htmlString);			
		}
		var result:Array<TCssStyle> = [];
		for (style in xml.firstElement().firstElement().elementsNamed('style')) {
			var s = cast(style, Xml);
			var css = s.firstChild().toString();
			css = css.replace('}', '}///');
			var cssStyles = css.split('///');
			for (cssStyle in cssStyles) {
				var id = cssStyle.substr(0, cssStyle.indexOf('{'));
				var content = cssStyle.substr(cssStyle.indexOf('{'));
				var st:TCssStyle = { id:id, content:content } ;
				result.push(st);
			}			
		}		
		
		return result;
	}
	
	static public function getBoldStyleString(styles:Array<TCssStyle>):String {
		var result = '';
		for (style in styles) {
			//trace([style.id, style.content]);
			if (style.content.indexOf('bold') > 0) {
				result +=  style.id + '{font-weight:bold;}\n';				
			}			
		}		
		return result;
	}

	static public function getItalicStyleString(styles:Array<TCssStyle>):String {
		var result = '';
		for (style in styles) {
			//trace([style.id, style.content]);
			if (style.content.indexOf('italic') > 0) {
				result += style.id + '{font-style:italic;}\n';				
			}			
		}		
		return result;
	}	
	
	static public function replaceGoogleStyles(htmlString:String):String {
		
		var xml:Xml;
		try {
			var content = RegexTools.closeImageTags(htmlString);
			content = RegexTools.closeHrTags(content);				
			xml = Xml.parse(content);			
		} catch (e:Dynamic) {
			xml = Xml.parse(htmlString);			
		}
		
		var styles = HtmlTools.getCssStyles(htmlString);
		var boldStyleString = HtmlTools.getBoldStyleString(styles);
		var italicStyleString = HtmlTools.getItalicStyleString(styles);
		
		for (style in xml.firstElement().firstElement().elementsNamed('style')) {
			var s = cast(style, Xml);
			//trace(s.firstChild().nodeValue);			
			s.firstChild().nodeValue = boldStyleString + italicStyleString;
		}
	
		return return xml.toString();
	}
	
	static public function replaceRootLinks(htmlString:String):String {
		return htmlString.replace('http:///', '/');
	}
	
}

typedef TCssStyle = {
	id:String,
	content:String,
}
