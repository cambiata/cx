package cx3.types;

/**
 * ...
 * @author Jonas Nyström
 */

 
using StringTools;
using cx3.types.tools.NameTools;

abstract Firstname(String) {
	public function new(s:String) this = s.adjName()
	@:from static public inline function fromString(s:String) return new Firstname(s)	
	@:to public inline function toString():String return Std.string(this)
}
