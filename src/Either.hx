package ;

/**
 * ...
 * @author Jason O'Neill
 */
abstract Either<A,B> (EEither<A,B>) 
{
	public inline function new( e:EEither<A,B> ) this = e;

	public var value(get,never):Dynamic;
	public var type(get,never):EEither<A,B>;

	inline function get_value() switch this { case Left(v) | Right(v): return v; }
	@:to inline function get_type() return this;

	@:from static function fromA( v:A ) return new Either( Left(v) );
	@:from static function fromB( v:B ) return new Either( Right(v) );
}

enum EEither<A,B>
{
	Left( v:A );
	Right( v:B ); 
}