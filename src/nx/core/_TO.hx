package nx.core;
import nx.core.display.DNote;
import nx.core.display.DPlex;
import nx.core.element.Head;
import nx.core.element.Note;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class _TO 
{

	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	static public var dNoteNv4_1_m1 			= new DNote(new Note([new Head(-1)]));
	static public var dNoteNv4_1_m1_UP 	= new DNote(new Note([new Head(-1)], null, EDirectionUAD.Up));
	static public var dNoteNv4_1_p0 			= new DNote(new Note([new Head()]));
	static public var dNoteNv4_1_p0_DN 		= new DNote(new Note([new Head()], null, EDirectionUAD.Down));
	static public var dNoteNv4_1_p0_UP 		= new DNote(new Note([new Head()], null, EDirectionUAD.Up));
	static public var dNoteNv4_1_p1 			= new DNote(new Note([new Head(1)]));
	static public var dNoteNv4_1_p1_DN 		= new DNote(new Note([new Head(1)], null, EDirectionUAD.Down));
	
	
	static public var dNoteNv4_2_m1p1 		= new DNote(new Note([new Head( -1), new Head(1)]));
	static public var dNoteNv4_2_p0p1 		= new DNote(new Note([new Head( 0), new Head(1)]));
	static public var dNoteNv4_2_p0p1_DN	= new DNote(new Note([new Head( 0), new Head(1)], null, EDirectionUAD.Down));
	static public var dNoteNv4_2_m1p0 		= new DNote(new Note([new Head( -1), new Head(0)]));
	static public var dNoteNv4_2_m1p0_UP 	= new DNote(new Note([new Head( -1), new Head(0)], null, EDirectionUAD.Up));
	
	
	static public var dplex_2_m1_UP_p1_DN = new DPlex([_TO.dNoteNv4_1_m1_UP, _TO.dNoteNv4_1_p1_DN]);
	static public var dplex_2_m1_UP_p0_DN = new DPlex([_TO.dNoteNv4_1_m1_UP, _TO.dNoteNv4_1_p0_DN]);
	static public var dplex_2_p0_UP_p0_DN = new DPlex([_TO.dNoteNv4_1_p0_UP, _TO.dNoteNv4_1_p0_DN]);
	
}