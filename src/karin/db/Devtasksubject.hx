package karin.db;

/**
 * ...
 * @author Jonas Nyström
 */
//using DevtasksubjectTools;
enum Devtasksubject
{
	Utveckling;
	Admin;
	Scorx;
	Sajt;
	Anvandare;
	Underlag;
	Infor;
	Ovrigt;	
}


class DevtasksubjectTool {
	static public function getIndex(e:Devtasksubject):Int {		
		return Type.enumIndex(e);
	}	
}