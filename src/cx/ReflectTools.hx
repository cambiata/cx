package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class ReflectTools 
{
	static public function getMethods(object:Dynamic) {
		return Type.getInstanceFields(Type.getClass(object));
	}
	
	static public function callMethod(object:Dynamic, methodName:String, args:Array<Dynamic>=null) {		
		if (!Lambda.has(getMethods(object), methodName)) throw "Method " + methodName + " doesn't exist!";
		if (args == null) args = [];
		return Reflect.callMethod(object, Reflect.field(object, methodName), args);
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
	

	/*
	Reflect.setField


			var methodName = "jeashSet" + field.substr (0, 1).toUpperCase () +  
	field.substr (1);
       
        if (o[methodName] != null) {
               
                o[methodName] (value);
               
        } else {
               
                o[field] = value;
               
        } 	
	*/
		
	
}