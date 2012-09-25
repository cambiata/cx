package cx;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class TextfileDB 
{

	var lines:Hash<String>;
	
	private var filename:String;
	private var delimiter:String;
	
	public function new(filename:String, delimiter = ';') {
		this.filename = filename;
		this.delimiter = delimiter;
		if (! FileTools.exists(this.filename)) FileTools.putContent(this.filename, '');
		readLines();
	}
	
	private function readLines() {
		this.lines = new Hash<String>();
		var file:FileInput = null;
		file = File.read(this.filename, false);		
		try {
			while (true) {
				var line = file.readLine().trim();
				var key = line.substr(0, line.indexOf(this.delimiter));
				if (key != '' && key != null) {
					var value = line.substr(key.length+1).trim();
					this.lines.set(key, value);						
				}
			}		
		} catch (e:Dynamic) {
			file.close();
		}		
	}
	
	private function writeLines() {
		var file:FileOutput = File.write(this.filename, false);		
		for (key in this.lines.keys()) {			
			file.writeString(key + this.delimiter + this.lines.get(key) + '\n');
		}
		file.close();
	}
	
	public function get(key:String):String {
		return this.lines.get(key);
	}
	
	public function set(key:String, value:String) {
		this.lines.set(key, value);
		writeLines();
	}
	
	public function remove(key:String) {
		this.lines.remove(key);
		writeLines();
	}
	
	public function clear() {
		this.lines = new Hash<String>();
		writeLines();
	}	
	
	public function keys() {
		return this.lines.keys();
	}
	
	
}