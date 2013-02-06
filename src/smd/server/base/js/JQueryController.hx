package smd.server.base.js;
import cx.JQueryTools;

/**
 * ...
 * @author Jonas Nyström
 */

class JQueryController implements IJSController
{
	public function new() 
	{
		JQueryTools.invokeIDs(this);
	}
	
}