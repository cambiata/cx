package cx;


class RandomTools {
	
	public static inline function bool():Bool return Math.random()
	public static inline function int(min:Int, max:Int):Int return min + Math.floor(((max - min + 1) * Math.random()));
	public static inline function float(min:Float, max:Float):Float return min + ((max - min) * Math.random());
	public static inline function fromArray<T>(arr:Array<T>):Null<T> return (arr != null && arr.length > 0) ? arr[int(0, arr.length - 1)] : null;
	
}