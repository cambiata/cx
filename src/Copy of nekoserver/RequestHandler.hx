package nekoserver;

typedef RequestData = {
	var path: Array<String>;
	var args: Array<String>;
}

interface RequestHandler {
	// function to check if current handler supports current request
	public function checkRequest(): Bool;
	
	// reads the beginning of request
	public function initRequest(): Void;
		
	// iterator interface
	public function next(): RequestData;
	public function hasNext(): Bool;
	
	// writing response
	public function startResponse(): Void;
	public function encodeError(error: Dynamic): Void;
	public function encodeResponseEntry(response: Dynamic): Void;
	public function finishResponse(): Void;
	
	//fast serialization
	public function setFastSerializationHook(hookName: String, setter: Dynamic -> Void): Void;
	public function addFastSerializationHook(hookName: String, data: Dynamic): Void;
}

