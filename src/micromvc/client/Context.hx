package micromvc.client;

#if (js)
	#if haxe3
		import js.Browser;
	#else

	#end
	import js.Lib;
#elseif (neko)
	import neko.Web;
#end

#if !haxe3
typedef Browser = Lib;
#end


/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class Context {
	
	public function new(registerControllers:Array<Dynamic>, uri:String=null) {
		
		#if haxe3
		this.controllers = new Map<String, String>();
		#else
		this.controllers = new Hash<String>();
		#end
		
		this.keys = new Array<String>();
		
		for (cntrl in registerControllers) {
			registerConroller(cntrl);
		}		
		
		// invoke controller:
		var controller = getController(getURI(uri));
		
	}
	
	#if haxe3
	private var controllers:Map<String, String> ;
	#else
	private var controllers:Hash<String> ;
	#end
	
	private var keys:Array<String>;
	
	
	private function registerConroller(clss:Dynamic) {		
		var metaType = haxe.rtti.Meta.getType(clss);
		var uriStr = Std.string(metaType.uri).trim();
		if (uriStr == 'null') uriStr = '[/]';		
		var uri = uriStr.substr(1, uriStr.length - 2);	
		var className = Type.getClassName(clss);
		controllers.set(uri, className);	
		keys.push(uri);
	}
	
	public function getController(uri:String):Controller {				
		uri = addSlash(uri);
		//trace(uri);
		for (key in keys) {
			var r = new EReg(key, '');
			if (r.match(uri)) {
				var clss = controllers.get(key);
				var args = getMatchedArray(r);
				args.shift();
				try {
					var instance = Type.createInstance(Type.resolveClass(clss), args );
					return instance;
				} catch (e:Dynamic) {
					throw 'Can not invoke ' + clss + '. Arguments mismatch?';
				}
			} else {
				//trace('dont match ' + key);
			}
		}				
		return null;
	}	
	
	public function getURI(uri:String=null):String {
		if (uri == null) {
			#if (js)
				uri = Browser.window.location.href;
				uri = uri.split(Browser.window.location.host)[1];		
			#elseif (neko)
				uri = Web.getURI();
			#end			
		}
		
		uri = (uri.indexOf('#') > 0) ? uri.substr(0, uri.indexOf('#')) : uri;
		//trace(uri);
		return uri;
	}
	
	static public function getMatchedArray(r:EReg):Array<Dynamic> {
		var a = new Array<Dynamic>();
		for (i in 0...5) {
			try {
				var s = r.matched(i);
				//trace(s);
				a.push(s);
			} catch (e:Dynamic) {
				return a;
			}
		}
		return a;
	}
	
	static private function addSlash(path:String, slash = '/') {		
		path = (path.endsWith('/')) ? path : path + '/';
		path = (path.startsWith('/')) ? path : '/' + path;
		return path;
	}
	
	
}