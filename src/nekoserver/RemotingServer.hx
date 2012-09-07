package nekoserver;
import haxe.Serializer;
import nekoserver.RequestHandler;

class RemotingServer {
	private var log: String -> Void;
	private var handlers: List<RequestHandler>;
	private var objects: Hash<Dynamic>;
	private var invoker: Dynamic -> Dynamic -> Array<Dynamic> -> Dynamic;
	
	private static var currentHandler: RequestHandler;

	public function new() {
		handlers = new List();
		objects = new Hash<Dynamic>();
		invoker = Reflect.callMethod;
	}
	
	public function setLogger(l: String -> Void) {
		log = l;
	}

	public function setInvoker(i:  Dynamic -> Dynamic -> Array<Dynamic> -> Dynamic) {
		invoker = i;
	}
	
	public function addHandler(handler: RequestHandler) {
		handlers.add(handler);
	}
	
	public function addObject(name: String, obj: Dynamic) {
		objects.set(name, obj);
	}

	public static function addFastSerializationHook(hookName: String, data: Dynamic) {
		if (null != currentHandler) {
			currentHandler.addFastSerializationHook(hookName, data);
		}
	}

	private function getHandler(): RequestHandler {
		for (handler in handlers) {
			if (handler.checkRequest()) {
				return handler;
			}
		}
		
		return null;
	}
	
	
	public function handleRequest(): Bool {		
		var handler = getHandler();		
			
		if (null != handler) {
			handler.initRequest();
			handler.startResponse();
			currentHandler = handler;
			while (handler.hasNext()) {
				try {
					var item = handler.next();
					
					//path array is something like [Object1, Object2,..., ObjectN, aMethodToCall]
					var currentObject = objects.get(item.path[0]);
					
					if (currentObject == null)
						throw "Object '" + item.path[0] + "' is not accessible";
					
					for (i in 1...item.path.length - 1) {
						currentObject = Reflect.field(currentObject, item.path[i]);
					}
					
					//aMethodToCall
					var func = Reflect.field(currentObject, item.path[item.path.length - 1]);
					if	(!Reflect.isFunction(func))
						throw "Calling not-a-function '" + func + "'";				
					var res = invoker(currentObject, func, item.args);
					handler.encodeResponseEntry(res);
				} catch (e: Dynamic) {
					if (log != null) {
						log(haxe.Stack.toString(haxe.Stack.exceptionStack()));
						log(Std.string(e));
						log("\n\n");
					}
					
					handler.encodeError(e);
				}
				
			}
			handler.finishResponse();
			currentHandler = null;
#if debug			
			trace("Response length: " + nekoserver.io.ResponseOutput.length + " bytes.");
#end		
			return true;
		} else return false;
	}
}