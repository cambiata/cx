package nekoserver.client;

import haxe.remoting.AsyncConnection;
import Type;

typedef EnumEncoderState = {
	var objects: Array<{ obj: Dynamic, field: String, val: Dynamic }>;
	var arrays: Array<{ arr: Array<Dynamic>, index: Int, val: Dynamic }>;
}

/**
 * use NekoServerConnection to connect to AmfHandler
 */ 
class NekoServerConnection implements AsyncConnection, implements Dynamic<AsyncConnection> {
	var __data : {
		error : Dynamic -> Void,
		#if flash9
		cnx : flash.net.NetConnection,
		#elseif flash
		cnx : flash.NetConnection,
		#else
		cnx : Dynamic,
		#end
	};
	var __path : Array<String>;
	
	function new( data, path ) {
		__data = data;
		__path = path;
	}

	public function resolve( name ) : AsyncConnection {
		var s = new NekoServerConnection(__data,__path.copy());
		s.__path.push(name);
		return s;
	}

	public function setErrorHandler(h) {
		__data.error = h;
	}

	public function close() {
		__data.cnx.close();
	}
	
	#if flash
	/**
	* Enums are sent as objects, this method is aimed to decode received enums
	*/
	private function makeEnumFromObject(arg: Dynamic): Dynamic {
		var tag = Std.string(Reflect.field(arg, "tag"));
		var name = Std.string(Reflect.field(arg, "name"));
			
		var edecl = Type.resolveEnum(name);
		if(edecl == null)
			throw "Enum: " + name + " not found!";
		
		var constructor = Reflect.field(edecl, tag);
		
		return (Reflect.isFunction(constructor)) ? Reflect.callMethod(edecl, constructor, Reflect.field(arg, "params")) : constructor;	
	}
	
	private function decode(arg: Dynamic): Dynamic {
		var val: Dynamic = arg[0];
		
		var copy: Array<Dynamic> = arg[1];
		for (item in copy) {
			var obj: Dynamic = item.object;//!
			
			if (item.key == null) {
				val = makeEnumFromObject(obj);
			} else {
				switch (Type.typeof(obj)) {
					case TObject: 
						var field = Reflect.field(obj, Std.string(Reflect.field(item, "key")));//item.key));
						Reflect.setField(obj, item.key, makeEnumFromObject(field));
					case TClass(c):
						obj[item.key] = makeEnumFromObject(obj[item.key]);
					default:
				}
			}
		}
		
		return val;
	}
	
	function decodeObject(arg: Dynamic, parent: Dynamic, field: String) {
		//Profiler.get().profile("init");
		var res = decode(arg);
		if (res != arg) {
			Reflect.setField(parent, field, res);
		}
	}
	
	function decodeArray(arg: Dynamic, parent: Array<Dynamic>, index: Int) {
		var res = decode(arg);
		if (res != arg) {
			parent[index] = res;
		}
	}
	
	/**
	* changing all enums in the Array of parameters into objects
	*/
	private function encode(arg :Dynamic, replace: Dynamic -> Void, state: EnumEncoderState) {
		switch (Type.typeof(arg)) {	
			case TEnum(e):
				replace(encodeEnum(arg, state));
			case TObject:
				for (field in Reflect.fields(arg)) {
					encode(Reflect.field(arg, field), function (newval) { 
						state.objects.push({ obj: arg, field: field, val: Reflect.field(arg, field) });
						Reflect.setField(arg, field, newval);
					}, state);
				}
			case TClass(c):	
				if (c == cast Array) {
					for (i in 0...arg.length) {
						encode(arg[i], function (newval) { 
							state.arrays.push({ arr: arg, index: i, val: arg[i] });
							arg[i] = newval;
						}, state);
					}
				}
			default:
		}		
	}

	private function restoreAfterEncoding(root: Dynamic, state: EnumEncoderState) {
		for (item in state.objects) {
			Reflect.setField(item.obj, item.field, item.val);
		}

		for (item in state.arrays) {
			item.arr[item.index] = item.val;
		}
		
		// to force gc asap
		state.objects = null;
		state.arrays = null;
	}
	
	/**
	* changing enum with object
	*/
	private function encodeEnum(e, state): Dynamic {
		var result;
		result = {};
		
		var params = Type.enumParameters(e);
		// encode parameters
		encode(params, function (v) { }, state);
		
		Reflect.setField(result, "index", Type.enumIndex(e));
		//enum constructor
		Reflect.setField(result, "tag", Type.enumConstructor(e));
		//list of the parameters for the constructor
		Reflect.setField(result, "params", params);
		//geting an enum name
		#if flash9
			Reflect.setField(result, "name", untyped __global__["flash.utils.getQualifiedClassName"](e));
		#else
			Reflect.setField(result, "name", Std.string(Reflect.field(Type.getEnum(e), "__ename__")[0]));
		#end
		Reflect.setField(result, "isEnum", "__true__");
		
		return result;
	}
	#end	
	
	
	public function call( params : Array<Dynamic>, ?onResult : Dynamic -> Void ) : Void {
		if( onResult == null ) onResult = function(e) {};
		var p = params.copy();
		var me = this;
		#if flash9
		var state = { objects: [], arrays: [] }
		encode(p, function(val) {  }, state);
		p.unshift(new flash.net.Responder(
			function(r) { onResult(me.decode(r)); },
			function(e) { me.__data.error(e); }
		));

		#else
		var state = { objects: [], arrays: [] }
		encode(p, function(val) {  }, state);
		p.unshift({
			onStatus: function(e) { me.__data.error(e); },
			onResult: function(r) { onResult(me.decode(r)); }
		});
		#end
		
		p.unshift(__path.join("."));
		untyped __data.cnx.call.apply(__data,p);
		me.restoreAfterEncoding(p, state);
	}

	#if flash
	public static function amfConnect( gatewayUrl : String ) {
		#if flash9
		var c = new flash.net.NetConnection();
		var cnx = new NekoServerConnection({ cnx : c, error : function(e) throw e },[]);
		c.addEventListener(flash.events.NetStatusEvent.NET_STATUS,function(e:flash.events.NetStatusEvent) {
			cnx.__data.error(e);
		});
		c.connect(gatewayUrl);
		return cnx;
		#else
		var c = new flash.NetConnection();
		if( !c.connect(gatewayUrl) )
			throw "Could not connected to gateway url "+gatewayUrl;
		return new NekoServerConnection({ cnx : c, error : function(e) throw e },[]);
		#end
	}

	public static function connect( nc ) {
		return new NekoServerConnection({ cnx : nc, error : function(e) throw e },[]);
	}
	#end

}
