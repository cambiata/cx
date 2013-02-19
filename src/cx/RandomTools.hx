package cx;


class RandomTools {
	
	//public static inline function bool():Bool return Std.int(Math.random())
	public static inline function int(min:Int, max:Int):Int return min + Math.floor(((max - min + 1) * Math.random()))
	public static inline function float(min:Float, max:Float):Float return min + ((max - min) * Math.random())
	public static inline function fromArray<T>(arr:Array<T>):Null<T> return (arr != null && arr.length > 0) ? arr[int(0, arr.length - 1)] : null
	
	public static inline function monthStr():String {
		var monthNr = int(1, 12);
		var str = Std.string(monthNr);
		return IntTools.pad(monthNr, '00');
	}
	
	public static inline function dayStr():String {
		var dayNr = int(0, 31);		
		var str = Std.string(dayNr);
		return cx.IntTools.pad(dayNr, '00');
		
	}
	
	public static inline function yearStr():String {
		return '19' + Std.string(int(40, 99));
	}
	
	public static inline function ssnrStr():String {
		return Std.string(int(1111, 9999));
	}
	
	public static inline function fullSsnrStr():String {
		return yearStr() + monthStr() + dayStr() + '-' + ssnrStr();
	}
	
}