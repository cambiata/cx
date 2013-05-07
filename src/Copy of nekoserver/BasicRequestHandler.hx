package nekoserver;

import nekoserver.RequestHandler;

class BasicRequestHandler implements RequestHandler {
	
	private var hooks: Hash <Dynamic -> Void>;

	public function new() {
		hooks = new Hash < Dynamic -> Void>();
	}
	
	public function checkRequest(): Bool { throw "Not implemented"; return false; }
	
	// reads the beginning of request
	public function initRequest(): Void { throw "Not implemented"; }
		
	// iterator interface
	public function next(): RequestData { throw "Not implemented"; return null; }
	public function hasNext(): Bool  { throw "Not implemented"; return false; }
	
	// writing response
	public function startResponse(): Void { throw "Not implemented"; }
	public function encodeError(error: Dynamic): Void { throw "Not implemented"; }
	public function encodeResponseEntry(response: Dynamic): Void { throw "Not implemented"; }
	public function finishResponse(): Void { throw "Not implemented"; }
	
	
	//fast serialization hooks
	public function setFastSerializationHook(hookName: String, setter: Dynamic -> Void) {
		hooks.set(hookName, setter);
	}
	public function addFastSerializationHook(hookName: String, data: Dynamic) {
		if (hooks.exists(hookName)) {
			hooks.get(hookName)(data);
		}
	}
	
}