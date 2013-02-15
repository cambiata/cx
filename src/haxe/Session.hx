package haxe;
import neko.SQLiteSession;
import neko.Web;

#if neko
//private typedef HaxeSession = neko.Session;
private typedef HaxeSession = SQLiteSession;
#elseif php
private typedef HaxeSession = php.Session;
#end

class Session
{
	public static var gcStartChance(null, gcStartChance_setter) : Float;
	static inline function gcStartChance_setter(chance:Float) : Float
	{
		
		
		#if php
		// for PHP is not a possible to set this at runtime. See php.ini.
		#elseif neko
		HaxeSession.gcStartChance = chance;
		#end
		return chance;
	}
	
	public static var gcMaxLifeTime(null, gcMaxLifeTime_setter) : Int;
	static inline function gcMaxLifeTime_setter(seconds:Int) : Int
	{
		#if php
		// for PHP is not a possible to set this at runtime. See php.ini.
		#elseif neko
		HaxeSession.gcMaxLifeTime = seconds;
		#end
		return seconds;
	}
	
	public static var savePath(null, savePath_setter) : String;
	static inline function savePath_setter(path:String) : String
	{
		HaxeSession.setSavePath(path);
		return path;
	}
	
	public static inline function start()
	{
		HaxeSession.start();
	}
	
	public static inline function close()
	{
		HaxeSession.close();
	}
	
	public static inline function get(name:String) : Dynamic
	{
		return HaxeSession.get(name);
	}
	
	public static inline function set(name:String, value:Dynamic) : Void
	{
		HaxeSession.set(name, value);
	}
	
	public static inline function exists(name:String) : Bool
	{
		return HaxeSession.exists(name);
	}
	
	public static inline function remove(name:String)
	{
		HaxeSession.remove(name);
	}
	
	public static inline function clear()
	{
		HaxeSession.clear();
	}
}


