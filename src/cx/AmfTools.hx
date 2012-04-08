package cx;
import nekoserver.amf.io.Amf3Reader;

/**
 * ...
 * @author Jonas Nyström
 */

class AmfTools 
{
	static public function test() {
		var obj = { test: ['Hej', 'hopp'], name:'Jonas', age:45.1, obj: { a:'abc', b: [1.1, 2.22, 3.333] }}; // ['hejsan hoppsan'];
		trace(obj);
		objectToFile(obj, 'test.object.amf');
		var obj2 = fileToObject('test.object.amf');
		trace(obj2);
	}
	
	static public function objectToFile(object:Dynamic, filename:String) {
		var output = new haxe.io.BytesOutput();
		output.bigEndian = true;
		var writer = new nekoserver.amf.io.Amf3Writer(output);
		writer.write(object);
		//-----------------------------------------------------		
		var f = neko.io.File.write(filename, true);
		f.write(output.getBytes());
		f.close();
	}
	
	static public function fileToObject(filename:String):Dynamic {
		var f = neko.io.File.read(filename, true);
		var bytes = f.readAll();
		var input = new haxe.io.BytesInput(bytes);		
		var reader = new nekoserver.amf.io.Amf3Reader(input);
		var object = reader.read();
		return object;
	}
}

/*

		var obj = {test: ['Hej', 'hopp'], name:'Jonas', age:45.1, obj:{a:'abc', b: [1.1,2.22,3.333]}}; // ['hejsan hoppsan'];
		//-------------------------------------				
		var output = new haxe.io.BytesOutput();
		output.bigEndian = true;
		var writer = new nekoserver.amf.io.Amf3Writer(output);
		writer.write(obj);
		//-----------------------------------------------------		
		var f = neko.io.File.write('../helloNeko-3.amf', true);
		f.write(output.getBytes());
		f.close();
		
		//-------------------------------------		
		var f = File.read('../helloNeko-3.amf', true);
		var bytes = f.readAll();
		var input = new haxe.io.BytesInput(bytes);		
		var reader = new Amf3Reader(input);
		var ret = reader.read();
		trace(ret);
		
		*/