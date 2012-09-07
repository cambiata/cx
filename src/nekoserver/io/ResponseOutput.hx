package nekoserver.io;

import haxe.io.Output;

class ResponseOutput extends Output {
#if debug	
	public static var length: Int = 0;
#end
	public function new() {
	}

	public override function writeByte(c) {
		neko.Lib.print(String.fromCharCode(c));
#if debug	
		length++;
#end
	}
	
	public override function write(s: haxe.io.Bytes) {
		neko.Lib.print(s.toString());
#if debug	
		length += s.length;
#end
	}

}	