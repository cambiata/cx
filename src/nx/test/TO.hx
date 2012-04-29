package nx.test;

import nx.element.Head;
import nx.element.Note;
import nx.element.Voice;


/**
 * ...
 * @author Jonas Nyström
 */

 
 
class TO 
{

	// Notes
	static public function getNote0():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0)]) 
	static public function getNote1():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(1), Head.getNew(2)]) 
	static public function getNote2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(4), Head.getNew(3)])
		
	// Voices
	//static public function getVoice0():IVoice return Voice.getNew([getNote0()])
	
	
	static public function getVoice0():Voice<Note<Head<Dynamic>>> return Voice.getNew([getNote0()])
	
	
}