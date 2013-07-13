package cx;

class IntTools 
{
	inline static public function pad(int:Int, pattern:String = '000'):String 
	{
		var str = Std.string(int);
		return pattern.substr(0, str.length) + str;		
	}
	
}