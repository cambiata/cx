package cx;

import cx.Sys;

class ArgTools {
	static private var arghash:Hash<String>;
	static private var argarr:Array<String>;	
	static private function parse() {
		arghash = new Hash<String>();
		argarr = new Array<String>();
		var args = Sys.args();
		var hashtag = null;
		for (a in args) {
			if (StringTools.startsWith(a, '-')) {				
				hashtag = a;
				if (!arghash.exists(hashtag)) arghash.set(hashtag, hashtag);
			} else {
				var val = a;
				if (hashtag != null) {
					if (arghash.exists(hashtag)) {					
						if (arghash.get(hashtag) == hashtag) {
							val = a;
						} else {
							val = arghash.get(hashtag) + ',' + a;
						}
					}					
					arghash.set(hashtag, val);				
				} else {
					arghash.set(val, val);
					argarr.push(val);
				}
				
			}			
		}		
	}
	
	static public function get(argument:String):String {
		if (arghash == null) parse();		
		if (arghash.exists(argument)) return arghash.get(argument);
		return null;
	}
	
	static public function getIndex(argIndex:Int):String {				
		try {
			return argarr[argIndex];
		} catch (e:Dynamic) {}
		return null;
	}	
}