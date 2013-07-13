/**
 * ...
 * @author Jonas Nyström
 */

package karin.db;

enum Devtaskstatus 
{
	Ide;
	Planerad;
	Startad;
	Klar;
	
}

class DevtaskstatusTool {
	static public function getIndex(e:Devtaskstatus):Int {		
		return Type.enumIndex(e);
	}	
}