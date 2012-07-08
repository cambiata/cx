package cx;
import format.tools.CRC32;
import format.zip.Reader;
import format.zip.Data;
import format.zip.Data.Entry;
import format.zip.Writer;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

#if !flash
import sys.io.File;
#else
import flash.utils.ByteArray;
#end

/**
 * ...
 * @author Jonas Nyström
 */

class ZipTools {	
#if !flash
	static public function getEntries(zipFilename:String): List<Entry> {
		var zipfileBytes = File.getBytes(zipFilename);
		return getEntriesFromBytes(zipfileBytes);
		/*
		var bytesInput = new BytesInput(zipfileBytes);
		var r = new Reader(bytesInput);
		var data = r.read();		
		return data;		
		*/
	}	
	
	static public function listEntries(zipEntries : List<Entry>) {
		for(zipEntry in zipEntries ) {
			var content = zipEntry.data;
			Sys.println("- " + zipEntry.fileName + ": " + zipEntry.compressed + ':' + content.length);
			
		}
	}		

	
	static public function getEntryData(zipEntries: List<Entry>, entryFileName:String): Bytes {
		for (zipEntry in zipEntries ) {
			if (zipEntry.fileName == entryFileName) {
				return zipEntry.data;
			}
		}
		return null;
	}
	

	
	static public function saveZipEntries(filename:String, entries:List<Entry>) {
		var zipBytesOutput = new BytesOutput();
        var zipWriter = new Writer(zipBytesOutput);
        zipWriter.writeData(entries);
        var zipBytes = zipBytesOutput.getBytes();
        var file = File.write(filename, true);
        file.write(zipBytes);
        file.close();		
		
	}
#end

	static public function getEntriesFromBytes(zipfileBytes:Bytes): List<Entry> {
		//var zipfileBytes = File.getBytes(zipFilename);
		var bytesInput = new BytesInput(zipfileBytes);
		var r = new Reader(bytesInput);
		var data = r.read();		
		return data;		
	}	



	static public function createDataEntry(filename:String, data:Bytes):Entry {
		var entry:Entry = {
			fileName : filename,
			fileSize : data.length,
			fileTime : Date.now(),
			compressed : false,
			dataSize : data.length,
			data : data,
			crc32 : CRC32.encode(data),
			extraFields : new List(),			
		};
		return entry;			
	}


}
	
