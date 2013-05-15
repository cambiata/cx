package cx;
import haxe.io.Bytes;
//import nme.utils.ByteArray;

/**
 * ...
 * @author Jonas Nyström
 */

class AmfTools 
{
	/*
	static public function testFiles() {

		var bytesList = FileTools.filesBytesInDirectory('files/');
		var filesList = Lambda.array(bytesList);
		
		var object = { files: filesList };
		//trace(obj);
		objectToFile(object, 'test.object.amf');
		var object2 = fileToObject('test.files.amf');
		trace(object2.files.length);
		var files = cast(object2.files, Array<Dynamic>);
		trace(Type.typeof(object2.files));
		for (f in files) {
			trace(Type.typeof(f));
			var bs:Bytes = cast(f, Bytes);
			trace(bs.length);
		}
		*/
		
		//------------------------------------------------------------------------------
		// AS3 code:
		/*
		var filename = 'test.files.amf';
		var l = new URLLoader();
		l.dataFormat = URLLoaderDataFormat.BINARY;
		l.addEventListener(Event.COMPLETE, function(event:Event) {
			var loadedByteArray:ByteArray = cast(l.data, ByteArray);
			var object = loadedByteArray.readObject();

			var files = cast(object.files, Array<Dynamic>);
			for (byteArray in files) {
				trace(byteArray.length);
			}
			
		});
		l.load(new URLRequest(filename));
		*/
		
	/*	
	}
	*/
	/*
	static public function test() {
		var object = { test: ['Hej', 'hopp'], name:'Jonas', age:45.1, obj: { a:'abc', b: [1.1, 2.22, 3.333] }}; // ['hejsan hoppsan'];
		objectToFile(object, 'test.object.amf');
		var object2 = fileToObject('test.object.amf');
		trace(object2);
	}
	*/
	
	static public function objectToBytes(object:Dynamic):Bytes {
		var output = new haxe.io.BytesOutput();
		output.bigEndian = true;
		var writer = new nekoserver.amf.io.Amf3Writer(output);
		writer.write(object);		
		return output.getBytes();
	}
	
	#if (neko || cpp)
	static public function objectToFile(object:Dynamic, filename:String) {
		var bytes = objectToBytes(object);		
		//-----------------------------------------------------		
		var f = sys.io.File.write(filename, true);		
		f.write(bytes);
		f.close();
	}
	#end
	
	static public function bytesToObject(bytes:Bytes):Dynamic {
		var input = new haxe.io.BytesInput(bytes);		
		var reader = new nekoserver.amf.io.Amf3Reader(input);
		var object = reader.read();
		return object;				
	}
	
	#if (neko || cpp)
	static public function fileToObject(filename:String):Dynamic {
		var f = sys.io.File.read(filename, true);
		var bytes = f.readAll();
		//------------------------------------------------------
		return bytesToObject(bytes);
	}
	#end
}
