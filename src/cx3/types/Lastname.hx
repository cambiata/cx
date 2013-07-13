package cx3.types;

/**
 * ...
 * @author Jonas Nyström
 */

using StringTools;
using cx3.types.tools.NameTools;

abstract Lastname(String) {	
	public function new(name:String) this = name.adjLastname()
	@:from static public inline function fromString(s:String) return new Lastname(s)
	@:to public inline function toString():String return Std.string(this)
}