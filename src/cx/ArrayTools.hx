package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class ArrayTools 
{
	static public function unique<T>(arr: Array<T>): Array<T> {
		var result = new Array<T>();
		for (item in arr) if (!Lambda.has(result, item)) result.push(item);		
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
	
	static public function overlap(array1:Array<Dynamic>, array2:Array<Dynamic>):Bool {		
		for (item in array1) {
			if (Lambda.has(array2, item)) return true;
		}
		return false;
	}	
	
	
}