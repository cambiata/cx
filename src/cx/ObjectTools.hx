package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class ObjectTools 
{

	public static function clone<T>(src : T) : T
	{
		var dst = { };
		return cast copyTo(src, dst);
	}
	
	public static function copyTo(src : { }, dst : { } )
	{
		for (field in Reflect.fields(src))
		{
			var sv = Dynamics.clone(Reflect.field(src, field));
			var dv = Reflect.field(dst, field);
			if (Types.isAnonymous(sv) && Types.isAnonymous(dv))
			{
				copyTo(sv, dv);
			} else {
				Reflect.setField(dst, field, sv);
			}
		}
		return dst;
	}	
	
}