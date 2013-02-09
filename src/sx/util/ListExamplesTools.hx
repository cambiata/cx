package sx.util;
import sx.type.THashIds;
import sx.type.TListExamples;

/**
 * ...
 * @author Jonas Nyström
 */

class ListExamplesTools 
{

	static public function getIds(listExamples:TListExamples):Array<Int> {
		var ids = new Array<Int>();
		for (le in listExamples) {
			ids.push(le.id);
		}
		ids.sort(function(a, b) { return Reflect.compare(a, b); } );
		return ids;
	}
	
	static public function getCount(listExamples:TListExamples):Int {
		return Lambda.count(listExamples);
	}
	
	
	static public function getOriginatorshortsIds(listExamples:TListExamples):THashIds {
		//if (originatorshortsIds != null) return originatorshortsIds;
		var originatorshortsIds = new THashIds();
		//if (listExamples == null) getListExamples();
		for (listExample in listExamples) {
			var id = listExample.id;
			for (originatorshort in listExample.originatorshorts) {
				if (!originatorshortsIds.exists(originatorshort)) { 
					originatorshortsIds.set(originatorshort, new Array<Int>());
				}
				
				var ids = originatorshortsIds.get(originatorshort);
				ids.push(id);
				originatorshortsIds.set(originatorshort, ids);
			}
		}		
		return originatorshortsIds;
	}
	
	static public function getBesacksIds(listExamples:TListExamples):THashIds {
		//if (besacksIds != null) return besacksIds;
		 var besacksIds = new THashIds();
		//if (listExamples == null) getListExamples();
		for (listExample in listExamples) {
			var id = listExample.id;			
			var besack:String = listExample.bes + ' ' + listExample.ack;
			if (!besacksIds.exists(besack)) {
				besacksIds.set(besack, new Array<Int>());
			}
			var ids = besacksIds.get(besack);
			ids.push(id);
			besacksIds.set(besack, ids);						
		}		
		return besacksIds;
	}	
	
	static public function getCategoryvaluesIds(listExamples:TListExamples):THashIds {
		//if (categoryvaluesIds != null) return categoryvaluesIds;
		var categoryvaluesIds = new THashIds();
		//if (listExamples == null) getListExamples();
		for (listExample in listExamples) {
			var id = listExample.id;			
			{
				for (category in listExample.categories) {
					if (category.categoryId == 'bes') continue;
					if (category.categoryId == 'ack') continue;					
					var value:String = /*category.categoryId + ':' +*/ category.value;
					if (!categoryvaluesIds.exists(value)) {
						categoryvaluesIds.set(value, new Array<Int>());
					}					
					var ids = categoryvaluesIds.get(value);
					ids.push(id);
					categoryvaluesIds.set(value, ids);											
				}
			}
		}		
		return categoryvaluesIds;				
	}
	
	static public function getSearchvaluesIds(listExamples:TListExamples):THashIds {
		var searchvaluesIds = new THashIds();
		Hashes.merge(searchvaluesIds, getOriginatorshortsIds(listExamples));
		Hashes.merge(searchvaluesIds, getBesacksIds(listExamples));
		Hashes.merge(searchvaluesIds, getCategoryvaluesIds(listExamples));
		return searchvaluesIds;
	}		
	
	static public function getInSubdirs(listExamples:TListExamples, subdirs:Array<String>): TListExamples {
		var ret = new TListExamples();
		for (le in listExamples) {
			if (Lambda.has(subdirs, le.subdir)) ret.set(le.id, le);
			//trace(le.id);
		}
		return ret;
	}
	
	//---------------------------------------------------------------
	
	static public function selectIds(listExamples:TListExamples, ids:Array<Int>):TListExamples {
		var selectedExamples:TListExamples = new TListExamples();
		for (id in ids) {
			if (listExamples.exists(id)) {
				selectedExamples.set(id, listExamples.get(id));
			} else {
				throw 'Id ' + id + ' does not exist in TListExamples';
			}
		}
		return selectedExamples;
	}
	
	
	
	
}