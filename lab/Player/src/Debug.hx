package ;
import haxe.CallStack;
import haxe.Log;
import pgr.gconsole.GameConsole;
/**
 * ...
 * @author 
 */
using StringTools;
class Debug
{

	static public function log(value:Dynamic) 
	{
		try 
		{
			var item:StackItem = CallStack.callStack()[1];
			var call:String = Std.string(item);
			var segments =  call.split(',');
			var row = segments.pop().replace(')', '');
			var file = segments.pop().split('\\').pop();
			var callee = '$file:$row: ';		
			var msg = callee + Std.string(value);		
			
			//---------------------------------------------------------------------
			
			GameConsole.log(msg);
			trace(msg);			
		}
		catch (err:Dynamic)
		{
			
		}
		
	}
	

	
}