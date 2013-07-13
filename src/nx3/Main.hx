package nx3;

import neko.Lib;
import nx3.elements.Head;
import nx3.elements.Note;
import nx3.enums.ENoteValue;
import nx3.units.Fixed16;
import nx3.units.Level;


using nx3.elements.io.ElementsXML;
/**
 * ...
 * @author Jonas Nyström
 */
class Main 
{
	
	static function main() 
	{
		var head = new Head(1);
		trace(head.toXml());
		
		var note = new Note([new Head(33)]);
		var nv:ENoteValue = ENoteValue.Nv4;
		trace(nv.value);
		trace(note.heads.length);
		
		
	
	}
	
}