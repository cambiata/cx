/**
 * ...
 * @author Jonas Nyström
 */

class Cx {
	static public function test() {
		return 'Cx.test()';
	}
	
	//-----------------------------------------------------------------------------------------------
	
	static public function stringRepeater(count:Int, repString:String) {
		var r = '';
		for (i in 0...count) {
			r += repString;
		}
		return r;
	}
	
	static public function putContent(filename:String, content:String) {
		var f = neko.io.File.write(filename, false);
		f.writeString(content);
		f.close();		
	}
	
	static public function putContentBinary(filename:String, content:String) {
		var f = neko.io.File.write(filename, true);
		f.writeString(content);
		f.close();		
	}
	
	//-----------------------------------------------------------------------------------------------
	
	static public function pngToHtmlImg(pngFile:String) {
		var bytes = neko.io.File.getBytes(pngFile);		
		return pngBytesToHtmlImg(bytes);
	}
	
	static public function pngBytesToHtmlImg(pngBytes:haxe.io.Bytes, ?style:String='') {
		var string = pngBytes.toString();
		var BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var string64 = haxe.BaseCode.encode(string, BASE64);		
		var html = '<img style="' + style + '" src="data:image/png;base64,' + string64 + '" />';
		return html;
	}
	
	//------------------------------------------------------------------------------------------------
	
	static public function zipGetEntries(zipFilename:String): List<format.zip.Data.Entry> {
		var bytes = neko.io.File.getBytes(zipFilename);
		var bytesInput = new haxe.io.BytesInput(bytes);
		var r = new format.zip.Reader(bytesInput);
		var data = r.read();
		return data;		
	}	
	
	static public function zipListEntries(zipEntries : List<format.zip.Data.Entry>) {
		for(zipEntry in zipEntries ) {
			var content = zipEntry.data;
			neko.Lib.println("- " + zipEntry.fileName + ": " + zipEntry.compressed + ':' + content.length);
		}
	}		
	
	static public function zipGetEntryData(zipEntries: List<format.zip.Data.Entry>, entryFileName:String): haxe.io.Bytes {
		for (zipEntry in zipEntries ) {
			if (zipEntry.fileName == entryFileName) {
				return zipEntry.data;
			}
		}
		return null;
	}
	
	//----------------------------------------------------------------------------------------------------------

	static public function odtTest(odtFileName:String) {
		var html = Cx.odtContentGetMeta() + Cx.odtToHtml(odtFileName);
		Cx.putContent(odtFileName+'.html', html);	
	}
	
	static public function odtGetContentXmlStr(zipEntries:List<format.zip.Data.Entry>):String {		
		var contentBytes:haxe.io.Bytes = zipGetEntryData(zipEntries, 'content.xml');
		var xmlStr = contentBytes.toString();
		return xmlStr;
	}
	
	static public function odtGetZipEntries(odtFileName:String):List<format.zip.Data.Entry> {
		return zipGetEntries(odtFileName);
	}
	
	static public function odtGetBodyTextXmlStr(zipEntries:List<format.zip.Data.Entry>): String {
		var xmlStr = odtGetContentXmlStr(zipEntries);
		var bodyTextStr = Xml.parse(xmlStr).firstElement().elementsNamed('office:body').next().firstElement().toString();
		return bodyTextStr;
	}
	
	static public function odtContentGetMeta() {
		return '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
	}
	
	static public function odtToHtml(odtFileName:String, ?imgScale:Float=40.0): String {
		var zipEntries = odtGetZipEntries(odtFileName);
		var xmlStr = odtGetBodyTextXmlStr(zipEntries);
		var html = odtContentToHtml(xmlStr, zipEntries, imgScale);
		return html;
	}
	
	static public function odtContentToHtml(xmlStr:String, ?zipEntries:List<format.zip.Data.Entry>, ?imgScale:Float=40):String {
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
								
								if (zipEntries == null) {
									html += '<img style="' + style + '" src="' + iSrc + '" >';							
									recursive(child, level);								
									html += '</img>';
								} else {									
									var imgBytes = zipGetEntryData(zipEntries, iSrc);
									var imgHtml = pngBytesToHtmlImg(imgBytes, style);
									html += imgHtml;
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
	
	//--------------------------------------------------------------------------------------------------------
	
	static public function nmeSpriteToPngTest() {
		var sprite = new nme.display.Sprite();
		sprite.graphics.beginFill(0x0000FF);
		sprite.graphics.drawCircle(20, 10, 8);
		sprite.graphics.drawCircle(220, 210, 8);
		Cx.nmeSpriteToPng(sprite, 'nmeSprite.png');		
	}
	
	static public function nmeSpriteToPng(source : nme.display.Sprite, pngFileName:String, ?width=0.0, ?height=0.0) {		
		if (width == 0) {
			width = source.width;
			height = source.height;
		}
		var bitmapData = new nme.display.BitmapData(Std.int(width), Std.int(height), false);
		bitmapData.draw(source);
		var byteArray = bitmapData.encode('x');
		putContentBinary(pngFileName, byteArray.asString());
	}
	
	
}