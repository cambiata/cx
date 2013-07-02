package cx;

/**
 * ...
 * @author Jonas Nyström
 */
class MemoizeTools
{
	public static function memoize(func:Dynamic , hashSize:Int = 100) : Dynamic 
	{	
		var argHash = new Map<String, Dynamic>();
		var f =  function(args:Array<Dynamic>)
		{
			var argString = args.join('|');
			trace('Arguments ' + argString);
			if (argHash.exists(argString))
			{
				trace('Arguments exist: ' + argString);
				return argHash.get(argString);
			}
			else
			{
				trace('Arguments dont exist ' + argString);
				var ret = Reflect.callMethod( { }, func, args);
				if(Lambda.count(argHash) < hashSize) argHash.set(argString, ret);
				return ret;
			}
		}
		trace(f);
		
		trace('Return normally...');
		f = Reflect.makeVarArgs(f);
		return f;
	}
}