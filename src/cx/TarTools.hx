package cx;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import format.tar.Data.Entry;
import format.tar.Reader;

/**
 * ...
 * @author Jonas Nyström
 */
class TarTools
{

	static public function getEntriesFromBytes(tarfileBytes:Bytes): List<Entry> {
		var bytesInput = new BytesInput(tarfileBytes);
		var r = new Reader(bytesInput);
		var data = r.read();		
		return data;		
	}	
	
}