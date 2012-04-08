package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class OdtTools
{

	static public function test(odtFileName:String) {
		
		var html = meta() + odtToHtml(odtFileName);
		FileTools.putContent(odtFileName+'.html', html);	
		
		/*
		var es = odtGetZipEntries(odtFileName);
		for (e in es) {
			trace(e.fileName);
		}
		var xmlStr = odtGetBodyTextXmlStr(es);
		trace(xmlStr);
		
		var html = odtContentToHtml(xmlStr);
		FileTools.putContent('test.odt.xml', html);
		*/
	}
	
	static public function contentXmlStr(zipEntries:List<format.zip.Data.Entry>):String {		
		var contentBytes:haxe.io.Bytes = ZipTools.getEntryData(zipEntries, 'content.xml');
		var xmlStr = contentBytes.toString();
		return xmlStr;
	}
	
	static public function zipEntries(odtFileName:String):List<format.zip.Data.Entry> {
		return ZipTools.getEntries(odtFileName);
	}
	
	static public function bodyTextXmlStr(zipEntries:List<format.zip.Data.Entry>): String {
		var xmlStr = contentXmlStr(zipEntries);
		var bodyTextStr = Xml.parse(xmlStr).firstElement().elementsNamed('office:body').next().firstElement().toString();
		return bodyTextStr;
	}
	
	static public function meta() {
		return '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
	}
	
	static public function odtToHtml(odtFileName:String, ?imgScale:Float=40.0): String {
		var zipEntries = zipEntries(odtFileName);
		var xmlStr = bodyTextXmlStr(zipEntries);
		var html = contentToHtml(xmlStr, zipEntries, imgScale);
		return html;
	}
	
	static public function contentToHtml(xmlStr:String, ?zipEntries:List<format.zip.Data.Entry>, ?imgScale:Float=40):String {
		var html = '';
		function recursive(xml:Xml, ?level:Int=0, ?parentWidth:Int=0, ?parentHeight:Int=0) {		
			for (child in xml) {
				//trace(level + ': ' + child.nodeType);				
				level++;
				switch(child.nodeType) {
					
					case Xml.Element: 
						switch (child.nodeName) {
							case 'office:text':
								html += '<div>';							
								recursive(child, level);								
								html += '</div>';								
							
							case 'text:h': 
								var hLevel = child.get('text:outline-level');
								html += '<h' + hLevel + '>';							
								recursive(child, level);								
								html += '</h' + hLevel + '>';
							case 'text:p':
								html += '<p>';							
								recursive(child, level);								
								html += '</p>';
								
							case 'text:span': 
								var style = child.get('text:style-name');
								switch(style) {
									case 'T2':
										html += '<b>';
									case 'T1':
										html += '<i>';
								}
								recursive(child, level);
								switch(style) {
									case 'T2':
										html += '</b>';
									case 'T1':
										html += '</i>';
								}
							case 'text:list':
								html += '<ul>';							
								recursive(child, level);								
								html += '</ul>';
							case 'text:list-item':
								html += '<li>';							
								recursive(child, level);								
								html += '</li>';
								
							case 'text:a':
								var href = child.get('xlink:href');
								html += '<a href="' + href + '">';
								recursive(child, level);
								html += '</a>';
							
							case 'text:line-break':
								html += '<br />';
								
							case 'draw:frame':
								var fWidth = Std.int(Std.parseFloat(StringTools.replace(child.get('svg:width'), 'cm', '')) * imgScale);
								var fHeight = Std.int(Std.parseFloat(StringTools.replace(child.get('svg:height'), 'cm', '')) * imgScale);
								//html += '<span style="border:1px solid #000; width:' + fWidth + 'px; height:' + fHeight + 'px;">';							
								html += '<span>';
								recursive(child, level, fWidth, fHeight);								
								html += '</span>';
							case 'draw:image':
								var iSrc = child.get('xlink:href');								
								var style = '';
								if (parentWidth > 0) {
									style = 'width:' + parentWidth + 'px;height:' + parentHeight + 'px';
								}
								
								try  {
									if (zipEntries != null) {
									var imgBytes = ZipTools.getEntryData(zipEntries, iSrc);
									var imgHtml = PngTools.pngBytesToHtmlImg(imgBytes, style);
									html += imgHtml;		
									} else throw "png zip entry error";
								} catch (e:Dynamic) {
									html += '<img style="' + style + '" src="' + iSrc + '" >';							
									recursive(child, level);								
									html += '</img>';
								}
								
								/*
								if (zipEntries == null) {
									html += '<img style="' + style + '" src="' + iSrc + '" >';							
									recursive(child, level);								
									html += '</img>';
								} else {									
									var imgBytes = Zip.zipGetEntryData(zipEntries, iSrc);
									var imgHtml = Png.pngBytesToHtmlImg(imgBytes, style);
									html += imgHtml;
								}
								*/

							case 'table:table':
								html += '<table>';							
								recursive(child, level);								
								html += '</table>';									
							case 'table:table-row':
								html += '<tr>';							
								recursive(child, level);								
								html += '</tr>';									
							case 'table:table-cell':
								html += '<td>';							
								recursive(child, level);								
								html += '</td>';								
								
							default: 
								html += '<tag name="' + child.nodeName + '">';
								recursive(child, level);
								html += '</tag>';
								
						}
					case Xml.PCData:
						if (StringTools.trim(child.toString()).length > 0) {
							html += child;
						}
				}
				level--;
			}
		}
		var xml = Xml.parse(xmlStr);
		recursive(xml);
		return html;
	}	

	
}