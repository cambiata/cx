package cx;
import haxe.Int32;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

/**
 * ...
 * @author Jonas Nyström
 */
class FileBunchTools
{


#if (neko || cpp)
	static public function filesToBunchfile(filenames:Array<String>, filename:String) 
	{		
		FileTools.putBytes(filename, filesToBytes(filenames));
	}
	
	static public function bunchfileToItems(filename:String):FileBunchItems
	{
		var bytes = FileTools.getBytes(filename);
		return bytesToItems(bytes);
	}
	
	static public function bunchfileToSeparateFiles(filename:String, targetDir:String)
	{
		var items = bunchfileToItems(filename);
		for (item in items)
		{			
			FileTools.putBytes(PathTools.addSlash(targetDir) + item.id, item.bytes);
		}
	}
	
	
	static public function filesToBytes(filenames:Array<String>):Bytes
	{
		var items = filesToItems(filenames);		
		return itemsToBytes(items);		
	}
	
	static public function filesToItems(filenames:Array<String>):FileBunchItems
	{
		var items = new FileBunchItems();		
		for (filename in filenames)
		{
			var bytes:Bytes = FileTools.getBytes(filename);
			
			var item:FileBunchItem = 
			{
				bytes:			bytes,
				bytesLength:	bytes.length, 
				id:				filename,
				idLength:		filename.length,
			}
			trace(item.bytesLength);
			items.push(item);
		}		
		return items;
	}
#end
	
	static public function itemsToBytes(items:FileBunchItems):Bytes 
	{
		var out:BytesOutput = new BytesOutput();	
		out.bigEndian = true;
		
		out.writeByte(items.length);				
		for (item in items) 
		{
			out.writeByte(item.idLength);
			out.writeString(item.id);
			trace(item.bytesLength);
			out.writeInt32(Int32.ofInt(item.bytesLength));
			out.writeBytes(item.bytes, 0, item.bytesLength);
			
		}
		return out.getBytes();
	}

	static public function bytesToItems(bytes:Bytes):FileBunchItems 
	{		
		trace(bytes.length);
		var bin:BytesInput = new BytesInput(bytes);
		bin.bigEndian = true;
		
		var length = bin.readByte();
		trace(length);
		var items = new FileBunchItems();
		for (i in 0...length) {
			var idLength = bin.readByte();
			var item:FileBunchItem = {
				idLength: 		idLength,
				id:				bin.readString(idLength),
				bytesLength:	Int32.toInt(bin.readInt32()),
				bytes:			null,
			}
			item.bytes = Bytes.alloc(cast(item.bytesLength, Int));
			bin.readBytes(item.bytes, 0, item.bytesLength);
			items.push(item);
		}
		return items;		
	}
	
	
}




typedef FileBunchItem = 
{
	var bytes:Bytes;
	var bytesLength:Int;
	var id:String;
	var idLength:Int;
}

typedef FileBunchItems = Array<FileBunchItem>;