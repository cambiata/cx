package micromvc.server;
import cx.PathTools;
import haxe.rtti.Meta;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
using cx.PathTools;
class Context 
{

	public function new(registerControllers:Array<Dynamic>, uri:String=null) {
		this.controllers = new Hash<String>();
		this.keys = new Array<String>();
		for (cntrl in registerControllers) {			
			registerConroller(cntrl);
		}		
		var controller = getController(getURI(uri));
	}
	private var controllers:Hash<String> ;
	private var keys:Array<String>;
	
	private function registerConroller(clss:Dynamic) {		
		var metaType = haxe.rtti.Meta.getType(clss);
		var uriStr = Std.string(metaType.uri).trim();
		if (uriStr == 'null') uriStr = '[/]';		
		var uri = uriStr.substr(1, uriStr.length - 2);	
		var className = Type.getClassName(clss);
		if (controllers.exists(uri)) throw "Trying to register controller with same uri twice";
		controllers.set(uri, className);	
		keys.push(uri);
	}
	
	public function getController(uri:String):Controller {				
		uri = uri.addSlash().addSlashBefore();
		
		for (key in keys) {
			var r = new EReg(key, '');
			if (r.match(uri)) {
				var clss = controllers.get(key);
				var args = getMatchedArray(r);
				args.shift();
				try {
					var instance = Type.createInstance(Type.resolveClass(clss), [] );
					var uri2 = uri.substr(key.length).addSlash().addSlashBefore();
					var metaFields = Meta.getFields(Type.resolveClass(clss));
					var fields = Reflect.fields(metaFields);
					for (field in fields) {
						var metaField = Reflect.getProperty(metaFields, field);
						var actionId = metaField.action;
						if (actionId == null) actionId = [field];
						var actionUri = actionId[0].addSlash().addSlashBefore();
						
						if (uri2.startsWith(actionUri)) {
							var actionMethod = field;
							var uri3 = uri2.substr(actionUri.length).removeSlash().removeSlashBefore();
							var args:Array<Dynamic> = uri3.split('/');
							if (args.length == 1 && Std.string(args) == '[]') args = [];
							try {								
								Reflect.callMethod(instance, Reflect.field(instance, actionMethod), args);
								return null;
							} catch (e:Dynamic) {
								throw 'Context error 2: Can not invoke ' + clss + ' with action method ' + actionMethod + ' using args: ' + Std.string(args);
							}
						}
					}			
					try {
						Reflect.callMethod(instance, Reflect.field(instance, 'index'), []);
					} catch (e:Dynamic) {
						throw 'Context error 3: Can not invoke ' + clss + ' with index method (no params!)';
					}
					return null;
				} catch (e:Dynamic) {
					throw 'Context Error 1: class ' + clss + ' ';
				}
			} else {
				//trace('dont match ' + key);
			}
		}				
		return null;		
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

	public function getURI(uri:String=null):String {
		if (uri == null) uri = neko.Web.getURI();
		uri = (uri.indexOf('#') > 0) ? uri.substr(0, uri.indexOf('#')) : uri;
		return uri;
	}	
	
}
