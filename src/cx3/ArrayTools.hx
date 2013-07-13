package cx3;

/**
 * ...
 * @author Jonas Nyström
 */

using Lambda;
class ArrayTools 
{
	static public function unique<T>(arr: Array<T>): Array<T> {
		var result = new Array<T>();
		for (item in arr) if (!Lambda.has(result, item)) result.push(item);		
		
		result.sort(function(a, b) { return Reflect.compare(a, b); } );
		
		return result;
	}
	
	static public function fromIterator<T>(it : Iterator<T>) : Array<T> {
		var result = [];
		for (v in it) result.push(v);
		return result;
	}	
	
	static public function fromIterables<T>(it : Iterable<T>) : Array<T>{
		return fromIterator(it.iterator());
	}
	
	static public function fromHashKeys<T>(it : Iterator<T>) : Array<T> {
		return ArrayTools.fromIterator(it);
	}
	
	static public function doOverlap(array1:Array<Dynamic>, array2:Array<Dynamic>):Bool {		
		for (item in array1) {
			if (Lambda.has(array2, item)) return true;
		}
		return false;
	}	
	
	static public function overlap<T>(array1:Array<T>, array2:Array<T>): Array<T> {
		return Lambda.array(array1.filter(function(value1) {
			var ret = (array2.has(value1));
			return ret;
		}));
	}
	
	static public function diff<T>(array1:Array<T>, array2:Array<T>): Array<T> {
		
		var result = new Array<T>();
		
		for (item in array1) {
			if (! Lambda.has(array2, item)) result.push(item);
		}
		for (item in array2) {
			if (! Lambda.has(array1, item)) result.push(item);
		}
		return result;
		
	}
	
	static public function first<T>(array:Array<T>): T {
		return array[0];
	}
	
	static public function isFirst<T>(array:Array<T>, item:T) :Bool {
		return (array[0] == item);
	}
	

	static public function last<T>(array:Array<T>): T {
		return array[array.length-1];
	}
	
	static public function isLast<T>(array:Array<T>, item:T) :Bool {
		return (array[array.length-1] == item);
	}	

	static public function index<T>(array:Array<T>, item:T) {
		return Lambda.indexOf(array, item);
	}
	
	public static function shuffle<T>(a : Array<T>) : Array<T> {
		var t = range(a.length);
		var arr = [];
		while (t.length > 0)
		{
			var pos = Std.random(t.length),
				index = t[pos];
			t.splice(pos, 1);
			arr.push(a[index]);
		}
		return arr;
	}	
	
	static public function countItem<T>(a:Array<T>, item:T): Int {		
		var cnt = 0;
		for (ai in a) {
			if (ai == item) cnt++;			
		}		
		return cnt;
	}

	//-----------------------------------------------------------------------------------------------------
	
	public static function range(start : Int, ?stop : Int, step = 1) : Array<Int>
	{
		if (null == stop)
		{
			stop = start;
			start = 0;
		}
		if ((stop - start) / step == Math.POSITIVE_INFINITY) throw "infinite range";
		var range = [], i = -1, j;
		if (step < 0)
			while ((j = start + step * ++i) > stop) range.push(j);
		else
			while ((j = start + step * ++i) < stop) range.push(j);
		return range;
	}	
	
}