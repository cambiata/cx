package sx.util;
import sx.type.TListExamples;
import sx.type.TSupplyState;

/**
 * ...
 * @author Jonas Nyström
 */

class ListExamplesFilters 
{

	static public function filterIncludeIds(listExamples:TListExamples, ids:Array<Int>):TListExamples {
		var ret = new TListExamples();
		for (listExample in listExamples) {			
			if (Lambda.has(ids, listExample.id)) ret.set(listExample.id, listExample);			
		}
		return ret;		
	}

	static public function filterExcludeIds(listExamples:TListExamples, ids:Array<Int>):TListExamples {
		var ret = new TListExamples();
		for (listExample in listExamples) {
			if (!Lambda.has(ids, listExample.id)) ret.set(listExample.id, listExample);			
		}
		return ret;		
	}
	
	static public function filterDates(listExamples:TListExamples, testDate:Date = null) {
		if (testDate == null) testDate = Date.now();
		var ret = new TListExamples();
		for (listExample in listExamples) {			
			if ((Date.fromString(listExample.start).getTime() <= testDate.getTime()) && (Date.fromString(listExample.stop).getTime() >= testDate.getTime()))
				ret.set(listExample.id, listExample);			
		}
		return ret;				
	}
	
	//-----------------------------------------------------------------------------------------------------
	
	static public function setState(listExamples:TListExamples, state:TSupplyState, ids:Array<Int>) {		
		for (listExample in listExamples) {
			if (ids != null) {
				if (Lambda.has(ids, listExample.id)) {	listExample.state = Std.string(state);}
			} else listExample.state = Std.string(state);
		}
		return listExamples;
	}
	
	static public function setStop(listExamples:TListExamples, stop:Date, ids:Array<Int>) {		
		for (listExample in listExamples) {
			if (ids != null) {
				if (Lambda.has(ids, listExample.id)) {
					listExample.stop = stop.toString();
					listExample.start = Date.fromTime(Math.min(Date.fromString(listExample.stop).getTime(), Date.fromString(listExample.start).getTime())).toString();
					}
			} else {
					listExample.stop = stop.toString();
					listExample.start = Date.fromTime(Math.min(Date.fromString(listExample.stop).getTime(), Date.fromString(listExample.start).getTime())).toString();
			}
			
		}
		return listExamples;
	}
	
	
}