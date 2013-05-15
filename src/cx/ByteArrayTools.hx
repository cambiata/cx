package cx;
import haxe.io.Bytes;
import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */
class ByteArrayTools
{

	static public function toBytes(byteArray:ByteArray):Bytes 
	{
		#if (flash)
			var bytes = Bytes.ofData(byteArray);
		#elseif (html5)
			var arrayBytes = new Array<Int>();
			for (i in 0...byteArray.length) arrayBytes.push(byteArray.readByte());
			var bytes = Bytes.ofData(arrayBytes);
		#else // if neko & cpp
			var bytes:Bytes = byteArray;
		#end
		return bytes;
	}
	
	static public function fromBytes(bytes:Bytes):ByteArray
	{
		#if (flash)	
			var byteArray:ByteArray = entry.data.getData();
		#elseif (html5)
			var bytesData:BytesData = entry.data.getData();
			var byteArray:ByteArray = new ByteArray();
			for (i in 0...bytesData.length) byteArray.writeByte(bytesData[i]);
		#else
			var byteArray = ByteArray.fromBytes(entry.data);
		#end		
		return byteArray;
	}
	
}