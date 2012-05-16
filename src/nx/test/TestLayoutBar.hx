package nx.test;
import haxe.unit.TestCase;
import nx.display.layout.LayoutBar;

import nx.element.Bar;
import nx.element.Part;
import nx.element.Voice;
import nx.element.Note;
import nx.element.Head;

import nx.display.DisplayBar;

import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class TestLayoutBar extends TestCase
{

	public function test0() 
	{
		var p0 = Part.getNew([Voice.getNew([
			Note.getNew([Head.getNew(0)]),
			Note.getNew([Head.getNew(0, ESign.Flat)]),
			Note.getNew([Head.getNew(0)]),
			Note.getNew([Head.getNew(0)]),
			])]);
		
		var p1 = Part.getNew([Voice.getNew([Note.getNew([Head.getNew(0)])])]);
		
		var db = new DisplayBar(Bar.getNew([p0, p1]));		
		
		
		var lb = new LayoutBar(db);
	}
	
}