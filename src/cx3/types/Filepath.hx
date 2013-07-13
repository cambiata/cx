package cx3.atypes;

/**
 * ...
 * @author Jonas Nyström
 */

abstract Filepath(String) {
    public function new(s:String) {
        s = s.replace('\\', '/').replace('//', '/');
        if (!s.endsWith('/')) s += '/';
        this = s;
    }
    @:from static public inline function fromString(s:String) return new Filepath(s)
    @:to public inline function toString():String return Std.string(this)
    public inline function toWin():String return this.replace('/', '\\')
} 