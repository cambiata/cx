package nekoserver.amf.io;

import nekoserver.amf.Types;

class Amf3Reader {	
	public var decodedStrings: Array<String>;
	public var decodedObjects: Array<Dynamic>;
	public var decodedClassDefs: Array<ClassDef>;
	private var input: haxe.io.Input;
	
	public function new(i: haxe.io.Input) {
		input = i;
		decodedStrings = [];
		decodedObjects = [];
		decodedClassDefs = [];
	}
	
	private function readWithCode(marker: Int): Dynamic {
		return switch (marker) {
			case 0x00: cast null;
			case 0x01: cast null;
			case 0x02: cast false;
			case 0x03: cast true;
			case 0x04: cast readAmf3Int();
			case 0x05: cast input.readDouble();
			case 0x06: cast readAmf3String();
			case 0x08: cast readAmf3Date();
			case 0x09: cast readAmf3Array();
			case 0x0A: cast readAmf3Object();
			case 0x0C: cast readAmf3ByteArray();
			default: throw "Not supported or wrong amf type-marker";
		}
	}

	private function readAmf3ByteArray() {
		var data = readAmf3String();
		return haxe.io.Bytes.ofData(neko.NativeString.ofString(data));
	}

	private function readAmf3Date(): Date {
		var flag = readAmf3Int();
		return flag & 1 == 0 ? Date.fromTime(input.readDouble())
			: cast decodedObjects[flag >> 1];
	}
	
	/**
	 * a String is encoded in UTF format
	 */
	private function readAmf3String(): String {
		var strref = readAmf3Int();
		
		var result = "";
		if (strref & 0x01 == 0) {
			strref = strref >> 1;
			
			if (strref >= decodedStrings.length) {
				throw "Undefined String reference";
			}
			
			result = decodedStrings[strref];
		} else {
			var length = strref >> 1;
			
			if (length > 0) {
				result = input.read(length).toString();
				decodedStrings.push(result);
			}
		}
		
		return result;
	}

	/**
	 * an Int is encoded in U29 format
	 */
	private function readAmf3Int(): Int {
		var char = input.readByte();
		
		if (char & 0x80 == 0x00) {
			return char;
		}
		
		var result = char & 0x7F;
		char = input.readByte();
		
		if (char & 0x80 == 0x00) {
			return (result << 7) | (char & 0x7F);
		}
		
		result = ((result << 7) | (char & 0x7F));
		char = input.readByte();
		
		if (char & 0x80 == 0x00) {
			return (result << 7) | (char & 0x7F);
		}
		
		result = ((result << 7) | (char & 0x7F));
		char = input.readByte();		
		result = (result << 8) | char;
		
		if (result & 0x10000000 != 0) {
			//result is negative number, but it's 29-bit negative number. To make it 32-bit negative we need to put three '1' before result
			result |= 0xe0000000;
		}
		
		return result;
	}
	
	private function readAmf3Array(): Array<Dynamic> {
		var result: Array<Dynamic> = [];
		
		var handle = readAmf3Int();
		var isStored = (handle & 0x01) == 0;
		handle = handle >> 1;
		
		var index = decodedObjects.length;
		decodedObjects.push(null);
		
		/*
		 * if isStored is true the same array was decoded earlier so this 
		 * should be found in StoredObjects array
		 */
		if (!isStored) {
			//here should be some key it's significent only if it's not null... But fortunately that's not our case
			input.readByte();
			
			for (i in 0...handle) {
				result.push(read());
			}
			
			//decodedObjects.push(result);
			decodedObjects[index] = result;
		} else {
			result = decodedObjects[handle];
		}
		
		return result;
	}
	
	/**
	 * TODO: the method needs to be developed to be able to decode an instance of a class
	 */
	private function readAmf3Object(): Dynamic {		
		var handle = readAmf3Int();
		//if false the same object vas decoded earlier so it's to be found in decodedObjects array
		var decodingNeeded = ((handle & 1) != 0);
		handle = handle >> 1;
		
		var classDef;
		if (decodingNeeded) {
			//indicating whether the classDef was decoded earlier
			var inlineClassDef = ((handle & 1) != 0 );
			
			if (inlineClassDef) {
				//type is always "" as we are decoding only objects
				var type = readAmf3String();
				var typedObject = ((type != null) && (type != ""));
				//flags that identify the way the object was serialized 
				var externalizable = ((handle & 1) != 0 ); 
				handle = handle >> 1;
				var dyn = ((handle & 1) != 0 ); 
				handle = handle >> 1;
				/*
				 * handle is showing the quantity of Class members. While implemening the decoding of classes
				 * use this var. In case of objects handle should be 0
				 */ 
				
				var type = (dyn) ? ClassType.Dyn : ClassType.Exteralizable;
				classDef = {typedObject: typedObject, type: type};
				decodedClassDefs.push(classDef);
			} else {
				classDef = decodedClassDefs[handle];
			}
		} else {
			var result = decodedObjects[handle];
			
			if (Reflect.field(result, "isEnum") == "__true__") {
				result = makeEnumFromObject(result);
			}
			
			return result;
		}
		
		var index = decodedObjects.length;
		decodedObjects.push(null);		
		
		var result = {};
		
		//object
		if (!classDef.typedObject) {
			var key = readAmf3String();
			//the decoded object ends with key ""
			while (key != "" && key != null) {
				var value = read();
				//result.set(key, value);
				Reflect.setField(result, key, value);
				
				key = readAmf3String();
			}			
		}	
		decodedObjects[index] = result;
		
		if (Reflect.field(result, "isEnum") == "__true__") {
			result = makeEnumFromObject(result);
		}
		
		return result;
	}
	
	public function read(): Dynamic {
		return readWithCode(input.readByte());
	}
	
	/**
	* Enums are sent as objects this method is aimed to decode recived enums
	*/
	private static function makeEnumFromObject(arg: Dynamic): Dynamic {
		var tag = Std.string(Reflect.field(arg, "tag"));
		var name = Std.string(Reflect.field(arg, "name"));
			
		var edecl = Type.resolveEnum(name);
		if(edecl == null)
			throw "Error! Enum: " + name + " not found!";
		
		var constructor = Reflect.field(edecl, tag);
		
		return (Reflect.isFunction(constructor)) ? Reflect.callMethod(edecl, constructor, Reflect.field(arg, "params")) : constructor;	
	}	
}