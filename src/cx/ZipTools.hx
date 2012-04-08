package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class ZipTools {	
	
	static public function getEntries(zipFilename:String): List<format.zip.Data.Entry> {
		var bytes = neko.io.File.getBytes(zipFilename);
		var bytesInput = new haxe.io.BytesInput(bytes);
		var r = new format.zip.Reader(bytesInput);
		var data = r.read();
		return data;		
	}	
	
	static public function listEntries(zipEntries : List<format.zip.Data.Entry>) {
		for(zipEntry in zipEntries ) {
			var content = zipEntry.data;
			neko.Lib.println("- " + zipEntry.fileName + ": " + zipEntry.compressed + ':' + content.length);
		}
	}		
	
	static public function getEntryData(zipEntries: List<format.zip.Data.Entry>, entryFileName:String): haxe.io.Bytes {
		for (zipEntry in zipEntries ) {
			if (zipEntry.fileName == entryFileName) {
				return zipEntry.data;
			}
		}
		return null;
	}
}
	
