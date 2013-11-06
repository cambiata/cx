package cx;

#if (neko || cpp)
import sys.FileSystem;
import sys.io.File;
#end

#if openfl
	import flash.Lib;
#end

using StringTools;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.StrTools;
class ConfigTools
{
	
	static public function getConfig(configObject:Dynamic)
	{
		#if (neko || cpp)		
			loadConfig(configObject);
		#end
		#if (flash || html5)
			loadFlashVars(configObject);
		#end		
	}

	#if (neko || cpp)
	static public function loadConfig(configObject:Dynamic, ?filename:String='default.conf', ?delimiter:String='=', ?arrayDelimiter:String=',', throwIfNoConfigFile:Bool=false):Void  {
		if (!FileSystem.exists(filename)) {
			var msg = "Config file " + filename + " doesn't exist";
			if (throwIfNoConfigFile) 
				throw  msg			
			else 
				trace(msg);
			return;
		}
		var file = File.read(filename, false);		
		try {
			while(true) {
				var line = file.readLine().trim();
				var segments = line.split(delimiter);
				var field:String = segments.shift().trim();
				var valueString:String = segments.join(delimiter).trim();
				initField(configObject, field, valueString, arrayDelimiter);
			}
		} catch(e : Dynamic){}	
	}	
	#end
	
	#if (flash || html5)
	static public function loadFlashVars(configObject:Dynamic) {
		var paramObject:Dynamic = flash.Lib.current.loaderInfo.parameters;
		//var cfields = Type.getClassFields(configObject);		
		//trace(cfields);
		var fields = ReflectTools.getObjectFields(paramObject);
		for (field in fields) 
		{
			/*
			trace(field);
			var currentField:String = null;
			for (cfield in cfields)
			{
				trace([cfield, field]);
				if (cfield.toLowerCase() == field.toLowerCase())
				{
					currentField = cfield;
					trace('FOUND ' + currentField);
					break;
				}
			}
			*/
			var value = Reflect.getProperty(paramObject, field);
			Reflect.setField(configObject, field, value);	
			//trace([field, value]);
		}
		//trace('ready config...');
	}
	
	static public function getFlashVars()
	{
		return flash.Lib.current.loaderInfo.parameters;		
	}
	#end
	
	
	//--------------------------------------------------------------------------------------------------------------
	
	static private var setFieldValue = function(configObject:Dynamic, field:String, value:Dynamic) {
		Reflect.setField(configObject, field, value);
		return;
	}
	
	static private var missingFields:Array<String> = new Array<String>();
	
	static public function initField(configObject:Dynamic, field:String, valueString:String, arrayDelimiter:String = ',') {
		
		if (!Reflect.hasField(configObject, field)) { missingFields.push(field); return; }
		//if (!Reflect.hasField(configObject, field)) Reflect.setField(configObject, field,);
		
		var f = Reflect.field(configObject, field);
		
		if (Std.is(f, String)) setFieldValue(configObject, field, valueString.trim());
		if (Std.is(f, Int)) setFieldValue(configObject, field, Std.parseInt(valueString.trim()));
		if (Std.is(f, Float)) setFieldValue(configObject, field, Std.parseFloat(valueString.trim()));

		if (Std.is(f, Array)) {
			var values = valueString.split(arrayDelimiter);			
			var arrItem = f.shift();
			
			if (Std.is(arrItem, String)) {
				//var values:Array<String> = valueString.split(arrayDelimiter);
				var values:Array<String> = valueString.splitTrim(arrayDelimiter);
				setFieldValue(configObject, field, values);
			}
			
			if (Std.is(arrItem, Int)) {
				var strings:Array<String> = valueString.split(arrayDelimiter);
				var values = new Array<Int>();
				for (string in strings) values.push(Std.parseInt(string));
				setFieldValue(configObject, field, values);
			}

			if (Std.is(arrItem, Float)) {
				var strings:Array<String> = valueString.split(arrayDelimiter);
				var values = new Array<Float>();
				for (string in strings) values.push(Std.parseFloat(string));
				setFieldValue(configObject, field, values);
			}
		}		
	}
}