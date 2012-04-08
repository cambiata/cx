package cx;

class As3Tools {
	
	static public function test() {
		var filename = 'test.object.amf';
		var l = new URLLoader();
		l.dataFormat = URLLoaderDataFormat.BINARY;
		l.addEventListener(Event.COMPLETE, function(event:Event) {
			trace('loaded');
			var ba:ByteArray = cast(l.data, ByteArray);
			var obj = ba.readObject();
			trace(obj);
		});
		l.load(new URLRequest(filename));
	}
	
	static public function testLoadFiles() {
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
	}
}