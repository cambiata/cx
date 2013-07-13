/**
 * ...
 * @author Jonas Nyström
 */

package karin.db;

using Devtaskprio.DevtaskprioTool;

enum Devtaskprio 
{
	Low;
	Mid;
	High;
}

class DevtaskprioTool {
	static public function getIndex(e:Devtaskprio):Int {		
		return Type.enumIndex(e);
	}	
}