package nekoserver.remoting;

import nekoserver.RequestHandler;
import nekoserver.BasicRequestHandler;

class RemotingHandler extends BasicRequestHandler {
	//remoting package contains only one call, this flag shows whether it was readen
	private var wasReaden: Bool;
	
	public function new() {
		super();
		wasReaden = false;
	}
	
	public override function finishResponse(): Void {}
	
	public override function encodeError(error: Dynamic): Void {
		var serializer = new haxe.Serializer();
		serializer.serializeException(error);	
		neko.Lib.print(serializer.toString());		
	}
	
	public override function checkRequest(): Bool {
		return !(neko.Web.getClientHeader("X-Haxe-Remoting") == null);
	}
	
	public override function initRequest() {
		wasReaden = false;
	}
	
	public override function hasNext(): Bool {
		return !wasReaden;
	}
	
	public override function next(): RequestData {
		wasReaden = true;

		var encodedFunction = neko.Web.getParams().get("__x");

		if (encodedFunction == null)
			throw "missing remoting data";		
		
		var unserializer = new haxe.Unserializer(encodedFunction);
		var path: Array<String> = unserializer.unserialize();
		var args: Array<Dynamic> = unserializer.unserialize();			
					
		return {path: path, args: args};
	}
	
	public override function startResponse(): Void {
		// doing nothing here, all the stuff goes into encodeResponseEntry
		// to allow setting cookies and the like
	}
	
	public override function encodeResponseEntry(response: Dynamic): Void {
		neko.Lib.print("hxr");
		var serializer = new haxe.Serializer();
		serializer.serialize(response);			
		neko.Lib.print(serializer.toString());		
	}
}