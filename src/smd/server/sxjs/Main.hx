package smd.server.sxjs;

import dtx.Tools;
import js.Lib;


/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
class Main 
{
	
	static function main() 
	{
		trace('Helloyx');		
		Tools.window.onload = run;
	}

	static function run(e)
	{
		"#test".find().setText('Javascript engine ok!');	
	}
}