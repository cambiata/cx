package cx;
import neko.FileSystem;
import neko.io.File;
import haxe.io.Eof; 

using StringTools;

/**
 * ...
 * @author Jonas Nyström
 */

class ConfigTools
{
	/*
	trace(cx.example.Config.name);
	cx.ConfigTools.loadConfig(cx.example.Config, 'default.conf');
	trace(cx.example.Config.name);
	*/
	
	static public function loadConfig(configObject:Dynamic, ?filename:String='default.conf', ?delimiter:String='=', ?arrayDelimiter:String=','):Void  {
		if (!FileSystem.exists(filename)) {
			throw "Config file " + filename + " doesn't exist";
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
		} catch(e : Eof){}	
	}	

	//--------------------------------------------------------------------------------------------------------------
	
	static private var setFieldValue = function(configObject:Dynamic, field:String, value:Dynamic) {
		Reflect.setField(configObject, field, value);
		return;
	}
	
	static private var missingFields:Array<String> = new Array<String>();
	
	static public function initField(configObject:Dynamic, field:String, valueString:String, arrayDelimiter:String = ',') {
		
		if (!Reflect.hasField(configObject, field)) { missingFields.push(field); return; }
		
		var f = Reflect.field(configObject, field);
		
		if (Std.is(f, String)) setFieldValue(configObject, field, valueString.trim());
		if (Std.is(f, Int)) setFieldValue(configObject, field, Std.parseInt(valueString.trim()));
		if (Std.is(f, Float)) setFieldValue(configObject, field, Std.parseFloat(valueString.trim()));

		if (Std.is(f, Array)) {
			var values = valueString.split(arrayDelimiter);			
			var arrItem = f.shift();
			
			if (Std.is(arrItem, String)) {
				var values:Array<String> = valueString.split(arrayDelimiter);
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