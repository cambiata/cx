package cx;
import neko.io.File;
import neko.io.FileOutput;

/**
 * ...
 * @author Jonas Nyström
 */

class ExcelTools {
	
	static var file:FileOutput;
	
	static public function start(filename:String) {
		file = neko.io.File.write(filename, true);		
		bof();
	}
	
	static private function bof() {
		file.writeInt16(0x809);
		file.writeInt16(0x8);
		file.writeInt16(0x0);
		file.writeInt16(0x10);
		file.writeInt16(0x0);
		file.writeInt16(0x0);		
	}
	
	static private function eof() {
		file.writeInt16(0x0A);
		file.writeInt16(0x00);
	}
	
	static public function writeNumber(row:Int, col:Int, number:Float) {
		file.writeInt16(0x203);
		file.writeInt16(14);
		file.writeInt16(row);
		file.writeInt16(col);
		file.writeInt16(0x0);
		file.writeDouble(number);
	}
	
	static public function writeString(row:Int, col:Int, str:String) {
		if (str == null) str = '';
		str = StrTools.toLatin1(str);
		//str = cx.Tools.stringAscii(str);
		var length = str.length;		
		file.writeInt16(0x204);
		file.writeInt16(8+length);
		file.writeInt16(row);
		file.writeInt16(col);
		file.writeInt16(0x0);
		file.writeInt16(length);
		
		file.writeString(str);
	}
	static public function finish() {
		eof();
		file.close();
	}
	
	
}