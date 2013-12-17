package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class ReflectTools 
{
	
	static public function getMethods(object:Dynamic) {
		var result:Array<String> = [];
		var fields =  Type.getInstanceFields(Type.getClass(object));
		for (field in fields) {
			var f = Reflect.field(object, field);
			if (Reflect.isFunction(f)) result.push(field);
		}
		return result;
	}
	
	static public function callMethod(object:Dynamic, methodName:String, args:Array<Dynamic>=null) {		
		//if (! hasMethod(getMethods(object), methodName)) throw "Method " + methodName + " doesn't exist!";
		if (args == null) args = [];
		
		try {
			return Reflect.callMethod(object, Reflect.field(object, methodName), args);
		} catch (e:Dynamic) {
			throw 'Error on ReflectTools.callMethod: ' + methodName + ' > ' + Std.string(e);
		}
	}

	static public function hasMethod(object:Dynamic, methodName:String) {
		return (Lambda.has(getMethods(object), methodName));
	}
	
	static public function getClass(object:Dynamic) {
		return Type.getClass(object);
	}
	
	static public function getClassName(object:Dynamic) {
		return Type.getClassName(getClass(object));
	}

	static public function getStaticFields(object:Dynamic) {		
		return Reflect.fields(getClass(object));
	}	
	
	static public function getObjectFields(object:Dynamic) {
		return Reflect.fields(object);
	}
	
	static public function getStaticField(object:Dynamic, fieldName:String) {
		return Reflect.field(getClass(object), fieldName);
	}
	
	
}