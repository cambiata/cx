package scorx.model;
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
	
	public function log(d:Dynamic)
	{
		var item:StackItem = CallStack.callStack()[1];
		var call:String = Std.string(item);
		var segments =  call.split(',');
		var row = segments.pop().replace(')', '');
		var file = segments.pop().split('\\').pop();
		var callee = '$file:$row: ';		
		var msg = callee + Std.string(d);
		trace(msg);		
		GameConsole.log(msg);
	}
	
}