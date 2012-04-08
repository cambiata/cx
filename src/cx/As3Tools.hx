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
}