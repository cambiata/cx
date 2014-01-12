package ;

import haxe.ds.StringMap.StringMap;
//import haxe.web.Dispatch;
import web.Dispatch;
import neko.Lib;

/**
 * ...
 * @author Jonas Nyström
 */

 class ProjectController {
	public function new() {	}
	 
	 function doDefault() return 'project default';
	 
	 function doTest() return 'project test';
	 
 }
 
class Api
{
	public function new() {	}
	
	function doDefault() return 'default';

	function doUser() 
	{
		return "Api.doUser()";
	}
	
	function doHelp(?topic:String) return 'info on this $topic';
	
	function doProject( d:Dispatch, ?test:String )
	{ 

		d.dispatch(this,  new ProjectController() ); 

		return 'project $test';
		//return d.dispatch( new ProjectController() ); 
	} 	
}
//.....
 
class Main 
{
	static function main() 
	{		
		var ret =  Dispatch.run("/project", new StringMap(), null, new Api());
		trace (ret);
	}
}