import format.zip.Data;
import format.zip.Tools;
import haxe.io.Bytes;
import haxe.xml.Fast;
import neko.zip.Reader;
/**
 * ...
 * @author Jonas Nyström
 */

class Cx {
	static public function test() {
		return 'Cx.test()';
	}
	
	static public function putContent(filename:String, content:String) {
		var f = neko.io.File.write(filename, false);
		f.writeString(content);
		f.close();		
	}
	
	static public function pngToHtmlImg(pngFile:String) {
		var bytes = neko.io.File.getBytes(pngFile);		
		return pngBytesToHtmlImg(bytes);
	}
	
	static public function pngBytesToHtmlImg(pngBytes:Bytes) {
		var string = pngBytes.toString();
		var BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var string64 = haxe.BaseCode.encode(string, BASE64);		
		var html = '<img src="data:image/png;base64,' + string64 + '" />';
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
	
	static public function zipGetEntryData(zipEntries: List<format.zip.Data.Entry>, entryFileName:String): Bytes {
		for (zipEntry in zipEntries ) {
			if (zipEntry.fileName == entryFileName) {
				return zipEntry.data;
			}
		}
		return null;
	}
	
	//----------------------------------------------------------------------------------------------------------

	/*
	var xmlFast = Cx.odtGetContentXmlFast('test.odt');
	trace(xmlFast);
	
	for (sub in xmlFast.elements) {
		switch(sub.name) {
			case 'text:h': 					
				trace(sub.innerHTML);
			case 'text:p':
				trace(sub.innerHTML);
				for (textElement in sub.elements) {
					trace(textElement.innerHTML);
				}
		}
	}		
	*/
	
	static public function odtGetContentXmlStr(zipEntries:List<format.zip.Data.Entry>):String {		
		var contentBytes:Bytes = zipGetEntryData(zipEntries, 'content.xml');
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
}