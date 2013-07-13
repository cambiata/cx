package cx3.example;
import cx3.types.Firstname;
import cx3.types.Lastname;
import neko.Lib;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class Cx3Main 
{	
	static function main() 
	{
		var first:Firstname = 'ulla -  stina';
		var last:Lastname = 'svensson&- KARlsson45';
		trace(first);		
		trace(last);
		var last:Lastname = "von pinkenstråhle";
		var l:String = last;
		trace(l);
	}	
}

