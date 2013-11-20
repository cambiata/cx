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
			//trace('Arguments: ' + argString);
			if (argHash.exists(argString))
			{
				//trace('Arguments exist - return result from cache');				
				return argHash.get(argString);
			}
			else
			{
				//trace('Arguments don\'t exist - caluclate, store in cache and return);
				var ret = Reflect.callMethod( { }, func, args);
				if(Lambda.count(argHash) < hashSize) argHash.set(argString, ret);
				return ret;
			}
		}
				
		//trace('Return normally...');
		f = Reflect.makeVarArgs(f);
		return f;
	}
	
	/*
	 * Usage example
	 * 
	static function main() 
	{
		// An example of time-consuming calculation function here
		var f = function(x:Float) {
			for (i in 0...100000000) x = x * 1.0000000005;			
			return x;
		}
		
		// Create a memoized version of that function
		var mf = cx.MemoizeTools.memoize(f);		
		
		// Try it out:
		trace (mf(5));	// first time, calculate mf(5) and store the result in memoize cache
		trace (mf(5));  // second time, use the cached result
		
		trace(mf(2));
		trace(mf(2));
	}	
	*/
	
}