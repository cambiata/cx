package cx;
import cx.docs.IndexTools;
import cx.docs.IndexTools.Index;
import cx.docs.IndexTools.IndexItem;
import cx.docs.IndexTools.IndexParser;
import haxe.ds.StringMap.StringMap;

/**
 * ...
 * @author Jonas Nyström
 */

class OdtTools
{

	static public function test(odtFileName:String) {
		
		var html = getMeta() + getHtmlFromOdt(odtFileName);
		FileTools.putContent(odtFileName+'.html', html);	

	}
	
	static public function getXmlParts(zipEntries:List<format.zip.Data.Entry>):OdtXmlParts {	
		var xmlStr = getContentXmlStr(zipEntries);
		var xml = Xml.parse(xmlStr);	
		var styleXml = xml.firstElement().elementsNamed('office:automatic-styles').next();
		var parts: OdtXmlParts = {			
			fontdecl: null,
			styles: _getStyles(styleXml),
			text: xml.firstElement().elementsNamed('office:body').next().firstElement(),			
		}		
		return parts;
	}
	
	static public function getContentXmlStr(zipEntries:List<format.zip.Data.Entry>):String {		
		var contentBytes:haxe.io.Bytes = ZipTools.getEntryData(zipEntries, 'content.xml');
		var xmlStr = contentBytes.toString();
		return xmlStr;
	}
	
	static public function getZipEntries(odtFileName:String):List<format.zip.Data.Entry> {
		return ZipTools.getEntries(odtFileName);
	}
	
	/*
	static public function getBodyTextXmlStr(zipEntries:List<format.zip.Data.Entry>): String {
		var xmlStr = getContentXmlStr(zipEntries);
		var bodyTextStr = Xml.parse(xmlStr).firstElement().elementsNamed('office:body').next().firstElement().toString();
		return bodyTextStr;
	}
	
	static public function getAutomaticStylesXmlStr(zipEntries:List<format.zip.Data.Entry>): String {
		var xmlStr = getContentXmlStr(zipEntries);
		var stylesXmlStr = Xml.parse(xmlStr).firstElement().elementsNamed('office:automatic-styles').next().firstElement().toString();
		return stylesXmlStr;
	}
	*/
	
	static public function getMeta() {
		return '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
	}
	
	static public function getHtmlFromOdt(odtFileName:String, meta:Bool=true, ?imgScale:Float=40.0): String {
		var zipEntries = getZipEntries(odtFileName);
		var parts = getXmlParts(zipEntries);
		var html = '';
		if (meta) html += OdtTools.getMeta();
		html += getHtmlFromContent(parts, zipEntries, imgScale);
		return html;
	}
	
	//static public function getHtmlFromContent(xmlStr:String, ?zipEntries:List<format.zip.Data.Entry>, ?imgScale:Float=40):String {
	static public function getHtmlFromContent(xmlParts:OdtXmlParts, ?zipEntries:List<format.zip.Data.Entry>, ?imgScale:Float=40):String {		
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
								var styletag = child.get('text:style-name');
								html += '<p>';															
								var styleObj:OdtStyle = xmlParts.styles.get(styletag);
								if (styleObj != null) {
									if (styleObj.bold)  html += '<b>';
									if (styleObj.italic)  html += '<i>';
								}
								recursive(child, level);								
								if (styleObj != null) {
									if (styleObj.italic)  html += '</i>';
									if (styleObj.bold)  html += '</b>';
								}
								html += '</p>';
								
							case 'text:span': 
								var styletag = child.get('text:style-name');
								var styleObj:OdtStyle = xmlParts.styles.get(styletag);
								if (styleObj != null) {
									if (styleObj.bold)  html += '<b>';
									if (styleObj.italic)  html += '<i>';
								}
								recursive(child, level);
								if (styleObj != null) {
									if (styleObj.italic)  html += '</i>';
									if (styleObj.bold)  html += '</b>';
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
								html += '<table cellpadding="8">';							
								recursive(child, level);								
								html += '</table>';									
							case 'table:table-row':
								html += '<tr>';							
								recursive(child, level);								
								html += '</tr>';									
							case 'table:table-cell':
								html += '<td valign="top">';							
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
		
		recursive(xmlParts.text);
		return html;
	}	
	
	static public function getBookmarks(xmlStr:String, refFilename:String='') {
		var ret = new Array<OdtBookmark>();
		var r = ~/<text:bookmark-start text:name="([^"]*)" [^>]*>([^<]*)<text:bookmark-end[^>]*>/gm;
		while (r.match(xmlStr)) {			
			ret.push( { content:r.matched(1), reference:r.matched(2) , filename:refFilename, filekey:EncodeTools.base64Encode(refFilename)} );			
			xmlStr = r.matchedRight();			
		}		
		return ret;
	}

	/*
	static public function getIndexes(xmlStr:String, refFilename:String='') {
		

		var ret = new Array<OdtIndex>();
		var r = ~/(<text:alphabetical-index-mark-start[^<]+?>)([^<]*)(<text:alphabetical-index-mark-end[^<]+?>)/gm;
		while (r.match(xmlStr)) {			
			var tagStart = r.matched(1);
			var content = r.matched(2);
			var tagEnd = r.matched(3);
			var startXml = Xml.parse(tagStart);
			
			var id = startXml.firstElement().get('text:id');
			var pos = r.matchedPos().pos;
			var len = r.matchedPos().len;
			var key1str = startXml.firstElement().get('text:key1');
			var key1list = Lambda.list(key1str.split(';'));			
			key1list = key1list.filter(function(item) { return (item != ''); } );
			var keys = Lambda.array(key1list.map(function(item) { return StringTools.trim(item); } ));
			var key2 = startXml.firstElement().get('text:key2');
			
			for (key in keys) {
				ret.push( { id:id, content:content, pos:pos, len:len, key:key , filename:refFilename, filekey:EncodeTools.base64Encode(refFilename) } );
			}
			
			
			xmlStr = r.matchedRight();			
		}		
		return ret;
	}
	*/
	
	static public function getIndex(xmlStr:String, refFilename:String = '') {
		
		/*
		var ret = new Index();
		var regex = ~/<a[ .]*href="idx:\/\/([^"]*)"[.]*>([a-zA-Z0-9]*)[.]*<\/a>/igm;
		while (regex.match(xmlStr)) {
			var indexWordsInfo = regex.matched(1);
			var textWord = regex.matched(2);

			var pos = regex.matchedPos().pos;
			var length = regex.matchedPos().len;
			xmlStr = regex.matchedRight();

			var indexWords = StrTools.splitTrim(indexWordsInfo, ';');
			
			for (indexWord in indexWords) {
				trace(indexWord);
					var index:OdtIndexItem = {
							text:textWord,
							id:null,
							keyword:indexWord,	
							pos:pos,
							length:length,
							filename:refFilename,
							filekey:null,
					}
					ret.push(index);
			}
		}
		return ret;
		*/
		return IndexParser.parse(xmlStr);
	}
	
	static public function getTOC(xmlStr:String, refFilename:String = '') {
		var ret = new Array<OdtTOC>();
		var currentLevel = '';
		function recursive(xml:Xml) {		
			for (child in xml) {
				//trace(level + ': ' + child.nodeType);				
				switch(child.nodeType) {
					case Xml.Element: 
						//trace(child.nodeName);
						switch (child.nodeName) {
							case 'office:text':
								//html += '<div>';							
								recursive(child);								
								//html += '</div>';								
							
							case 'text:h': 
								var hLevel = child.get('text:outline-level');
								currentLevel = 'H' + hLevel;
								recursive(child);								
							case 'text:p':
								//html += '<p>';							
								//recursive(child, level);								
								//html += '</p>';
							/*	
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
							*/	
							default: 
								//trace(child);
								recursive(child);
						}
					case Xml.PCData:
						if (StringTools.trim(child.toString()).length > 0) {
							ret.push({content:StringTools.trim(child.toString()), type:currentLevel, filename: refFilename, filekey:EncodeTools.base64Encode(refFilename)});
						}
				}
			}
		}
		var xml = Xml.parse(xmlStr);
		recursive(xml);
		//return html;		
		return ret;
	}
	
	//-----------------------------------------------------------------------------------------------------
		
	static private function _getStyles(styleXml:Xml):OdtStyles {
		var ret = new OdtStyles();
		for (e in styleXml.elements()) {			
			var styleName = e.get('style:name');
			var style:OdtStyle = { name:styleName, bold:false, italic:false };
			if (e.firstElement() != null) {
				if (e.firstElement().get("fo:font-weight") == 'bold') style.bold = true;
				if (e.firstElement().get("fo:font-style") == 'italic') style.italic = true;				
			}
			ret.set(styleName, style);
		}
		return ret;		
	}
}


typedef OdtStyles = StringMap<OdtStyle>;

typedef OdtStyle = {
	name:String,
	bold:Bool,
	italic:Bool,	
}


typedef OdtXmlParts = {
	fontdecl:Xml,
	text:Xml,
	styles:OdtStyles,
}


typedef OdtBookmark = {
	content:String,
	reference:String,
	filename:String,
	filekey:String,
}

typedef OdtTOC = {
	type:String,
	content:String,
	filename:String,
	filekey:String,
}


/*
typedef OdtIndex = Array<OdtIndexItem>;

typedef OdtIndexItem = {
	text:String,
	id:String,
	keyword:String,	
	pos:Int,
	length:Int,
	filename:String,
	filekey:String,
	//key2:String,
}



class OdtIndexTool {	
	private var index:OdtIndex;
	public function new(indexes:Iterable<OdtIndex>) {
		this.index = new OdtIndex();
		for (index in indexes) {
			this.index = this.index.concat(index);
		}
		trace(this.index);
	}	
	
	public function getKeywordIndex():Hash<OdtIndex> {
		var ret = new Hash<OdtIndex>();
		for (indexItem in this.index) {			
			if (!ret.exists(indexItem.keyword)) ret.set(indexItem.keyword, new OdtIndex());
			ret.get(indexItem.keyword).push(indexItem);
		}
		return ret;
	}
	
	
}
*/