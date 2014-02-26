package cx;
import cx.docs.IndexTools;
import cx.docs.IndexTools.Index;
import cx.docs.IndexTools.IndexItem ;
import cx.docs.IndexTools.IndexParser;
import cx.OdtTools.OdtListStyle;
import haxe.ds.StringMap.StringMap;
import hxdom.Attr;
import hxdom.Elements.EAnchor;
import hxdom.Elements.EBase;
import hxdom.Elements.EBody;
import hxdom.Elements.EBold;
import hxdom.Elements.EDiv;
import hxdom.Elements.EHeader1;
import hxdom.Elements.EHeader2;
import hxdom.Elements.EHeader3;
import hxdom.Elements.EHeader4;
import hxdom.Elements.EHtml;
import hxdom.Elements.EImage;
import hxdom.Elements.EItalics;
import hxdom.Elements.EListItem;
import hxdom.Elements.EObject;
import hxdom.Elements.EOrderedList;
import hxdom.Elements.EParagraph;
import hxdom.Elements.EParam;
import hxdom.Elements.ESpan;
import hxdom.Elements.ETable;
import hxdom.Elements.ETableCell;
import hxdom.Elements.ETableRow;
import hxdom.Elements.EUnorderedList;
import hxdom.Elements.VirtualElement;
import hxdom.Elements.VirtualNode;
import hxdom.html.Element;
import hxdom.html.Node;
import hxdom.HtmlSerializer;
/**
 * ...
 * @author Jonas Nyström
 */

 using StringTools;
using hxdom.DomTools;

 
class OdtTools
{
	public function new() { };
	
	var html:EHtml;
	var body: EBody;
	var node:VirtualElement<Dynamic>;
	var styles:StringMap<OdtStyle>;	
	var listStyles:StringMap<OdtListStyle>;

	var imgscale:Float;
	var zipEntries:List<format.zip.Data.Entry>;
	
	public function getHtmlFromContent2(xmlParts:OdtXmlParts, ?zipEntries:List<format.zip.Data.Entry>, ?imgScale:Float = 40):String 
	{		
		return 'x';
	}
	
	public function html2(odtFileName:String)
	{
		var html = getMeta() + getHtmlFromOdt2(odtFileName);
		return html;
	}

	public function getHtmlFromOdt2(odtFileName:String, meta:Bool=true, ?imgScale:Float=40.0, stripOuterLevels=0): String {
		var zipEntries = getZipEntries(odtFileName);
		
		this.zipEntries = zipEntries;
		this.imgscale = imgScale;
		
		var parts = getXmlParts(zipEntries);
		//var html = '';
		//if (meta) html += OdtTools.getMeta();
		this.styles = getStyles(parts.style);
		this.listStyles = getListStyles(parts.style);
		
		this.html = new EHtml();
		this.body = new EBody();
		this.html.appendChild(this.body);
		this.node = new EDiv();
		this.body.appendChild(this.node);
		
		recursiveParser(parts.text);
		
		var html = HxdomTools.ehtmlToHtml(this.html, true, false , stripOuterLevels);
		if (meta) html = getMeta() + html;
		return html;
	}
	
	
	
	
	
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
			style: xml.firstElement().elementsNamed('office:automatic-styles').next(),
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
								html += '<div class="office-text">';							
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
								html += '<table>';							
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
	
	static private function _getListStyles(styleXml:Xml):OdtStyles {
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


	
	
	public function getStyles(xml:Xml) 
	{
		
		var result = new StringMap<OdtStyle>();
		
		for (e in xml)
		{
			if (Std.string(e.nodeType) != 'element') continue;
			if (e.nodeName != 'style:style') continue;
			var styleName = e.get('style:name');
			var styleFamily = e.get('style:family');
			if (styleFamily != 'text') continue;
			var bold = (e.firstElement().get('fo:font-weight') =='bold');
			var italic= (e.firstElement().get('fo:font-style') == 'italic');
			var style:OdtStyle = { name:styleName, italic:italic, bold:bold };
			result.set(styleName, style );
			
		}
		return result;
		
	}

	public function getListStyles(xml:Xml) 
	{
		var result = new StringMap<OdtListStyle>();
		
		for (e in xml)
		{
			if (Std.string(e.nodeType) != 'element') continue;
			if (e.nodeName != 'text:list-style') continue;
			var styleName = e.get('style:name');
			var listType = e.firstChild().nodeName;
			var number = (listType == 'text:list-level-style-number' );
			var style:OdtListStyle = { name:styleName, number : number };
			result.set(styleName, style);
		}
		return result;
	}	
	
	
	public function recursiveParser(xml:Xml)
	{
		for (e in xml)
		{
			var nodeType = Std.string(e.nodeType);
			switch (nodeType) 
			{
				case 'element':
					//var nodeName = e.nodeName;
					//var styleName = e.get('text:style-name');
					
					var childnode = getNewNode(e, this.node/*, nodeName, styleName*/);
					if (childnode == null) continue;
					var currentnode = this.node;
					this.node.appendChild(childnode);
					this.node = childnode;
					recursiveParser(e);
					this.node = currentnode;
					
				case 'pcdata':
					var text = e.toString();
					this.node.addText(text);
			}						
		}
	}		
	
	function getNewNode(e:Xml, n:VirtualElement<Dynamic>):VirtualElement<Dynamic> 
	{
		var nodeName = e.nodeName;
		var styleName = e.get('text:style-name');
		
		
		var node:VirtualElement<Dynamic> = null;
		
		switch nodeName 
		{
			case 'text:p': node = new EParagraph();
			case 'text:h':  {
				switch styleName
				{
					case 'Heading_20_1': node = new EHeader1();
					case 'Heading_20_2': node = new EHeader2();
					case 'Heading_20_3': node = new EHeader3();
					case 'Heading_20_4': node = new EHeader4();
					default: node = new EHeader1();
				}
			}
			case 'text:span':
				if (this.styles.exists(styleName))
				{
					var style:OdtStyle = this.styles.get(styleName);
					node = new ESpan();
					if (style.bold && !style.italic) node = new EBold();
					if (!style.bold && style.italic) node = new EItalics();
					node.attr(hxdom.Attr.ClassName, styleName);
				}
				else
				{
					node = new ESpan();					
				}
				
			case 'table:table' : node = new ETable();
			case 'table:table-row' : node = new ETableRow();
			case 'table:table-cell' : node = new ETableCell();
			case 'draw:frame': 
					var width = Std.int(Std.parseFloat(StringTools.replace(e.get('svg:width'), 'cm', '')) * this.imgscale);
					var height = Std.int(Std.parseFloat(StringTools.replace(e.get('svg:height'), 'cm', '')) * this.imgscale);
					var imgstyle = 'width:${width}px; height:${height}px;';
					
					node = new EDiv();
					var i = e.firstChild();
					var link = i.get('xlink:href');

					if (link.startsWith('Pictures/'))
					{
						try  
						{
							if (this.zipEntries == null) throw "png zip entry error";
							var imgBytes = ZipTools.getEntryData(this.zipEntries, link);
							var imgHtml = PngTools.pngBytesToHtmlImg(imgBytes, imgstyle);
							node.addHtml(imgHtml);
						}
						catch (e:Dynamic)
						{
							node.addText('Image error: ' + Std.string(e) + ' - link: $link');
						}
					} 
					else if (link.startsWith('http'))
					{
						//trace(link);
						//var img = new EImage();
						//img.attr(Attr.Src, link);
						//node.appendChild(img);
						
						var imgTag = '<img src="$link" style="$imgstyle" />';
						node.addHtml(imgTag);
						
					}
					

					
			case 'draw:image':
				//var src = e.get('src');
				//trace('draw:Image $src');
				//trace(e);
				
				node = null;
				
			case 'text:a':
				var target = e.get('office:target-frame-name');
				var href = e.get('xlink:href');
				
				var hrefClass = StrTools.until(href, ':');

				//trace(hrefClass);
				switch hrefClass 
				{
					case 'player': {
						node = new EObject();
						
					}
					default: 
					{
						node = new EAnchor();
						node.attr(Attr.Target, target);
						node.attr(Attr.ClassName, '$hrefClass' );
						
					}
				}
				node.attr(Attr.Href, href);
				
				
			case 'text:list':
					var styleName = e.get('text:style-name');
					var listStyle:OdtListStyle = this.listStyles.get(styleName);
					node =  (listStyle.number) ? new EOrderedList() : new EUnorderedList();
			case 'text:list-item':
					node = new EListItem();
				
			case 'text:bookmark':
				
				//trace(e);
				
			case 'text:soft-page-break':
				node = new ESpan();
				
			case 'text:sequence-decls':
				node = null;
			default : 
				node = new EDiv();
				node.attr(hxdom.Attr.ClassName, '$nodeName $styleName');
		}
		return node;
	}
	
}

typedef OdtStyles = StringMap<OdtStyle>;

typedef OdtStyle = {
	name:String,
	bold:Bool,
	italic:Bool,	
}

typedef OdtListStyle = {
	name:String,
	number:Bool,
}

typedef OdtXmlParts = {
	fontdecl:Xml,
	text:Xml,
	style:Xml,
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



/*
typedef Style = {
	name:String,
	italic:Bool,
	bold:Bool,
}
*/