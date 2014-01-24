package harfang;
import harfang.result.ActionResult;

/**
 * ...
 * @author Jonas Nyström
 */
class Output
{
	static public function handle(data:Dynamic) 
	{
		if (Std.is(data, ActionResult)) {
			Sys.println(cast(data, ActionResult).execute());						
		} else if (data != null) {
			Sys.println(data);
		}			
	}
	
}