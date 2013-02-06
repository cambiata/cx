package smd.server.base.js;
import cx.PathTools;
import cx.RegexTools;
import js.Lib;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class JSContext {
	
	public function new(registerControllers:Array<Dynamic>) {
		this.controllers = new Hash<String>();
		this.keys = new Array<String>();
		
		for (cntrl in registerControllers) {
			registerConroller(cntrl);
		}		
	}
	private var controllers:Hash<String> ;
	private var keys:Array<String>;
	
	
	private function registerConroller(clss:Dynamic) {		
		var metaType = haxe.rtti.Meta.getType(clss);
		var uriStr = Std.string(metaType.uri).trim();
		if (uriStr == 'null') uriStr = '[/]';		
		var uri = uriStr.substr(1, uriStr.length - 2);	
		trace(uri);
		//trace(clss);
		var className = Type.getClassName(clss);
		//trace(className);
		controllers.set(uri, className);	
		keys.push(uri);
	}
	
	public function getController(uri:String):IJSController {		
		
		uri = PathTools.addSlash(uri);
		trace(uri);
		
		for (key in controllers.keys()) {
			trace(key);
		}
		
		for (key in keys) {
			trace(key);
		}
		
		for (key in keys) {
			trace(key);
			var r = new EReg(key, '');
			if (r.match(uri)) {
				trace('match!');
				var clss = controllers.get(key);
				trace(clss);
				var args = RegexTools.getMatchedArray(r);
				args.shift();
				trace(args);
				
				try {
					var instance = Type.createInstance(Type.resolveClass(clss), args );
					return instance;
				} catch (e:Dynamic) {
					throw 'Can not invoke ' + clss + '. Arguments mismatch?';
				}
				
			} else {
				trace('dont match ' + key);
			}
		}				
		return null;
	}	
	
	public function getURI():String {
		var uri = Lib.window.location.href;
		var segments = uri.split(Lib.window.location.host);
		return segments[1];
	}
}