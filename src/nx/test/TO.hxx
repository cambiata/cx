package nx.test;

import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.ENoteValue;
import nx.enums.ESign;


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
	
	// fjärdedelar
	static public function getNoteNv4L0():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0)]) 
	static public function getNoteNv4L1():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(1)]) 
	static public function getNoteNv4L3():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(3)]) 
	static public function getNoteNv4Lm1():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-1)]) 
	static public function getNoteNv4Lm3():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-3)]) 
	// m förtecken
	static public function getNoteNv4L2Sharp():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(3, ESign.Sharp)]) 
	static public function getNoteNv4Lm1Flat():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-1, ESign.Flat)]) 
	// m dot
	static public function getNoteNv4DotLm4():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-4)], ENoteValue.Nv4dot) 
	static public function getNoteNv4DotL2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(2)], ENoteValue.Nv4dot) 
	
	
	// åttondelar
	static public function getNoteNv8L0():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0)], ENoteValue.Nv8) 
	static public function getNoteNv8L3():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(3)], ENoteValue.Nv8) 
	static public function getNoteNv8L6():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(6)], ENoteValue.Nv8) 
	static public function getNoteNv8Lm2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-2)], ENoteValue.Nv8) 
	static public function getNoteNv8Lm5():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-5)], ENoteValue.Nv8) 
	// m förtecken
	static public function getNoteNv8L6Sharp():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(6, ESign.Sharp)], ENoteValue.Nv8) 
	static public function getNoteNv8Lm2Natural():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-2, ESign.Natural)], ENoteValue.Nv8) 
	// m dot	
	static public function getNoteNv8DotL3():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(3)], ENoteValue.Nv8dot) 
	static public function getNoteNv8DotLm2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-2)], ENoteValue.Nv8dot) 
	
	
	// sextondelar
	static public function getNoteNv16L0():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0)], ENoteValue.Nv16) 
	static public function getNoteNv16L2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(2)], ENoteValue.Nv16) 
	static public function getNoteNv16L4():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(4)], ENoteValue.Nv16) 	
	static public function getNoteNv16Lm1():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-1)], ENoteValue.Nv16) 
	static public function getNoteNv16Lm5():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-5)], ENoteValue.Nv16) 		
	// m förtecken
	static public function getNoteNv16L4Flat():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(4, ESign.Flat)], ENoteValue.Nv16) 	
	static public function getNoteNv16Lm1Sharp():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-1, ESign.Sharp)], ENoteValue.Nv16) 
	
	
	// halvnoter
	static public function getNoteNv2L0():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0)], ENoteValue.Nv2) 
	static public function getNoteNv2L2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(2)], ENoteValue.Nv2) 
	static public function getNoteNv2Lm2():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-2)], ENoteValue.Nv2) 
	// m förtecken
	static public function getNoteNv2L0Flat():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(0, ESign.Flat)], ENoteValue.Nv2) 
	static public function getNoteNv2L2Sharp():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(2, ESign.Sharp)], ENoteValue.Nv2) 
	static public function getNoteNv2Lm2Natural():Note<Head<Dynamic>>  return Note.getNew([Head.getNew(-2, ESign.Natural)], ENoteValue.Nv2) 
	
	// Voices
	//static public function getVoice0():IVoice return Voice.getNew([getNote0()])
	static public function getVoice0():Voice<Note<Head<Dynamic>>> return Voice.getNew([getNote0()])	
	static public function getVoiceOneBar4_4_Mixed1() return Voice.getNew([TO.getNoteNv4DotL2(), getNoteNv8L6(), getNoteNv4L3(), getNoteNv8Lm2Natural (), getNoteNv8L3()])
	static public function getVoiceOneBar4_4_Nv8s() return Voice.getNew([
		TO.getNoteNv8L0 (), 
		TO.getNoteNv8L0 (), 
		TO.getNoteNv8L3 (), 
		TO.getNoteNv8L3 (), 
		TO.getNoteNv8Lm2 (), 
		TO.getNoteNv8Lm5 (), 
		TO.getNoteNv8Lm2Natural (),
		TO.getNoteNv8L3 ()
		])
		
	static public function getVoiceOneBar4_4_Nv8s_02() return Voice.getNew([		
		TO.getNoteNv8L3 (), 
		TO.getNoteNv8Lm2 (), 
		TO.getNoteNv8L6Sharp (), 
		TO.getNoteNv8L3 (), 
		TO.getNoteNv8L0 (), 
		TO.getNoteNv8L3 (), 
		TO.getNoteNv8Lm2 (), 
		TO.getNoteNv8Lm5 (), 
		TO.getNoteNv8Lm2Natural (),
		])
	
	// Fjärdedelar	
	
		static public function getVoiceOneBar4_4_Nv4s () return Voice.getNew([
			//Note.getNew([Head.getNew( -2)]),
			TO.getNoteNv4L0(),
			TO.getNoteNv4L0(),
			TO.getNoteNv4L0(),
			TO.getNoteNv4L0(),
		])

		static public function getVoiceOneBar4_4_Nv4sLm3 () return Voice.getNew([		
			Note.getNew([Head.getNew( 1)]),
			//TO.getNoteNv4Lm3(),
			TO.getNoteNv4Lm3(),
			TO.getNoteNv4Lm3(),
			TO.getNoteNv4Lm1Flat (),
		])

		static public function getVoiceOneBar4_4_Nv4sL1 () return Voice.getNew([		
			//TO.getNoteNv4L1(), 
			//Note.getNew([Head.getNew( -2)]),
			TO.getNoteNv4L1(),
			TO.getNoteNv4L1(),
			TO.getNoteNv4L1(),
			TO.getNoteNv4L1(),
		])
		
	// Halvnoter	
	
		static public function getVoiceOneBar4_4_Nv2s() return Voice.getNew([		
			TO.getNoteNv2L0(),
			TO.getNoteNv2L0(),
		])
		
		static public function getVoiceOneBar4_4_Nv2sLm2() return Voice.getNew([		
			TO.getNoteNv2Lm2(),
			TO.getNoteNv2Lm2(),
		])
		
		static public function getVoiceOneBar4_4_Nv2sL2() return Voice.getNew([		
			TO.getNoteNv2L2Sharp (),
			TO.getNoteNv2Lm2(),
		])
		
		
	//-----------------------------------------------------------------------------------------------------
	// Parts
	
	static public function getPart0() return Part.getNew([Voice.getNew([Note.getNew([Head.getNew(0)])])])
	
	static public function getPart4_4_2v_simple() return Part.getNew([getVoiceOneBar4_4_Nv4sLm3(), getVoiceOneBar4_4_Nv2sL2()])
	
	
}