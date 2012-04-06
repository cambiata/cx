import haxe.io.Bytes;
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
		
		/*
		var string = bytes.toString();
		var BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var string64 = haxe.BaseCode.encode(string, BASE64);		
		var html = '<img src="data:image/png;base64,' + string64 + '" />';
		return html;
		*/
		//Util.putContent('test.html', html);		
	}
	
	static public function pngBytesToHtmlImg(pngBytes:Bytes) {
		var string = pngBytes.toString();
		var BASE64:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
		var string64 = haxe.BaseCode.encode(string, BASE64);		
		var html = '<img src="data:image/png;base64,' + string64 + '" />';
		return html;
		
	}
	
	//------------------------------------------------------------------------------------------------
	
	static public function zipGetEntries(zipFilename:String): List<neko.zip.Reader.ZipEntry> {
		var f = neko.io.File.read(zipFilename, true);
		var zipEntries = neko.zip.Reader.readZip(f);		
		f.close();
		return zipEntries;
	}	
	
	static public function zipListEntries(zipEntries : List<neko.zip.Reader.ZipEntry>) {
		for(zipEntry in zipEntries ) {
			var content = (zipEntry.compressed) ? neko.zip.Reader.unzip(zipEntry) : zipEntry.data;
			neko.Lib.println("- " + zipEntry.fileName + ": " + content.length);
		}
	}	
	
	static public function zipGetEntryData(zipEntries: List<neko.zip.Reader.ZipEntry>, entryFileName:String): Bytes {
		for (zipEntry in zipEntries ) {
			if (zipEntry.fileName == entryFileName) {
				return (zipEntry.compressed) ? neko.zip.Reader.unzip(zipEntry) : zipEntry.data;
			}
		}
		return null;
	}
	
}