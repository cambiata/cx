package cx;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Bytes;
import haxe.Int32;

/**
 * ...
 * @author Jonas Nyström
 */

 
typedef DataItem =
{
	id:String,
	data:Bytes,
}
 
typedef DataItems = Array<DataItem>;

typedef DataItemMeta = 
{
	id:String,
	idLength:Int,
	dataLength:Int,
}
 
 
class DataTools
{

	static public function itemsToBytes(items:DataItems):Bytes
	{		
		var bout:BytesOutput = new BytesOutput();	
		bout.bigEndian = false;				
		bout.writeInt32(Int32.ofInt(items.length));

		for (item in items)
		{
			writeItemMeta(bout, item.id, item.data);					
		}
		
		for (item in items)
		{
			writeItemData(bout, item.data);
		}
		
		return bout.getBytes();		
	}
	
	static public function bytesToItems(bytes:Bytes):DataItems
	{			
		var bin:BytesInput = new BytesInput(bytes);
		bin.bigEndian = false;		
		var length = Int32.toInt(bin.readInt32());
		
		var metas = new Array<DataItemMeta>();
		var datas = new Array<Bytes>();
		var items = new DataItems();
		
		
		for (i in 0...length)
		{
			var meta = readItemMeta(bin);
			metas.push(meta);
		}
		
		for (i in 0...length)
		{
			var data = readItemData(bin, metas[i].dataLength);			
			datas.push(data);
		}
		
		for (i in 0...length)
		{
			var item:DataItem = { id:metas[i].id, data:datas[i] };
			items.push(item);
		}

		return items;
	}
	
	static public function bytesToMetas(bytes:Bytes):Array<DataItemMeta>
	{
		var bin = new BytesInput(bytes);
		bin.bigEndian = false;		

		var length = Int32.toInt(bin.readInt32());
		
		var metas = new Array<DataItemMeta>();		
		for (i in 0...length)
		{
			var meta = readItemMeta(bin);
			metas.push(meta);
		}		
		return metas;
	}
	
	//-----------------------------------------------------------------------------------------------
	
	static private function writeItemMeta(out:BytesOutput, id:String, data:Bytes)
	{
		out.writeInt32(Int32.ofInt(data.length));		
		out.writeByte(id.length);
		out.writeString(id);
	}
	
	static private function writeItemData(out:BytesOutput, data:Bytes)
	{
		out.writeBytes(data, 0, data.length);
	}
	
	static private function readItemMeta(bin:BytesInput): DataItemMeta
	{
		var dataLength = Int32.toInt(bin.readInt32());
		var idLength = bin.readByte();
		var id = bin.readString(idLength);
		return { dataLength:dataLength, idLength:idLength, id:id };
	}	
	
	static private function readItemData(bin:BytesInput, dataLenght:Int)
	{
		var data = Bytes.alloc(cast(dataLenght, Int));
		bin.readBytes(data, 0, dataLenght);		
		return data;
	}	
	
}