package sx.util;
import sx.type.TListExamples;

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
	
}