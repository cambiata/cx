package sx.util;
import cx.ArrayTools;
import sx.type.EOriginatortypes;
import sx.type.TAlternative;
import sx.type.TAlternatives;
import sx.type.TExample;
import sx.type.TListExample;
import sx.type.TOriginator;
import sx.type.TOriginatorItem;
import sx.type.TOriginatorshorts;
import sx.type.TSupplyState;
import sx.util.ExampleTools;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class ExampleTools 
{

	static public inline var SEPARATOR_ORIGITEM 	= ' > ';
	static public inline var SEPARATOR_CATITEM 		= ' > ';
	
	static public function getListExample(example:TExample):TListExample {
		var listExample:TListExample = {
			id:example.information.id,
			subdir:example.subdir,
			
			title:example.information.title,
			subtitle:example.information.subtitle,
			sorttitle:example.information.sorttitle,
			
			bes:getBesFromExample(example),
			ack:getAckFromExample(example),
			introd:example.information.introd,
			
			originatorshorts:getOriginatorshortsFromExample(example),
			originatorItems:example.originatorItems,
			categories:example.categories,							
			
			state: Std.string(TSupplyState.Locked),
			start:Date.fromString('2012-01-01').toString(),
			stop:Date.fromString('2016-01-01').toString(),			
		}
		return listExample;	
	}	
	
	
	static public function getBesFromExample(example:TExample):String {
		for (cat in example.categories) {
			if (cat.categoryId == 'bes') return cat.value;			
		}
		return null;
	}

	static public function getAckFromExample(example:TExample):String {
		for (cat in example.categories) {
			if (cat.categoryId == 'ack') return cat.value;			
		}
		return null;
	}
	
	static public function checkOriginatorType(type:String):String {
		var safeType:EOriginatortypes = Type.createEnum(EOriginatortypes, type);				
		return Std.string(safeType);
	}	
	
	static public function getOriginatorshortsFromExample(example:TExample):TOriginatorshorts {
		var originatorshorts = new TOriginatorshorts();
		for (origItem in example.originatorItems) {
			var originatorshort = ScorxTools.getOriginatorshort(origItem.originator);
			originatorshorts.push(originatorshort);
		}
		return originatorshorts;
	}
	
	static public function getOrigiItemShorts(example:TExample):TOriginatorshorts {
		var originatorshorts = new TOriginatorshorts();
		for (origItem in example.originatorItems) {
			var originatorshort = getOrigItemShort(origItem); 
			originatorshorts.push(originatorshort);
		}
		return originatorshorts;
	}	
	
	static public function getOrigItemShort(origItem:TOriginatorItem):String {
		return origItem.type + SEPARATOR_ORIGITEM +  ScorxTools.getOriginatorshort(origItem.originator, false);
	}

	static public function getAlternativeStaticShorts(example:TExample):Array<String> {
		var result:Array<String> = [];		
		var alternatives = example.categories;
		
		for (alt in alternatives) {
			var short = getAlternativeShort(alt);
			result.push(short);
		}
		return result;
	}	
	
	static public function getAlternativeShort(alternative:TAlternative) {
		return alternative.categoryId + SEPARATOR_CATITEM + alternative.value;
	}
	
	static public function getAlternativeDynamicShorts(example:TExample) {
		var result:Array<String> = [];		
		var alternatives = example.categoriesDynamic;
		
		for (alt in alternatives) {
			var short = getAlternativeShort(alt);
			result.push(short);
		}
		return result;		
	}	
	
	
	static public function removeOrigItemShort(example:TExample, removeTypeOrigShort:String) {
		for (i in 0...example.originatorItems.length) {
			var typeOrigShort = getOrigItemShort(example.originatorItems[i]);
			trace([typeOrigShort, removeTypeOrigShort]);
			if (typeOrigShort.toLowerCase() == removeTypeOrigShort.toLowerCase()) {
				example.originatorItems.splice(i, 1);
				
				trace(example.originatorItems);
				return example;				
			}
		}
		return example;
	}
	
	
	static public function addOriginatorToExample(example:TExample, originator:TOriginator, type:String) {
		//var typ:EOriginatortypes = Type.createEnum(EOriginatortypes, type);		
		type = checkOriginatorType(type);
		var origItem:TOriginatorItem = { type: Std.string(type), originator:originator };
		
		if (hasOriginatorItem(example, origItem)) {
			var origItemShort = getOrigItemShort(origItem);
			throw "Kan ej lägga till  " + origItemShort + ", existerar redan i exemplet!";
		}		
		
		example.originatorItems.push(origItem);
		return example;
	}
	
	static public function hasOriginatorItem(example:TExample, origItem:TOriginatorItem):Bool {		
		var origItemShort = getOrigItemShort(origItem);		
		var origItemShorts = getOrigiItemShorts(example);
		return Lambda.has(origItemShorts, origItemShort);
	}
	
	static public function isDirty(ex1:TExample, ex2:TExample) {
		
		if (ex1.information.id 			!= ex2.information.id) 				return true;
		if (ex1.information.title 		!= ex2.information.title) 			return true;
		if (ex1.information.subtitle 	!= ex2.information.subtitle) 		return true;
		if (ex1.information.sorttitle 	!= ex2.information.sorttitle) 	return true;
		if (ex1.information.added 	!= ex2.information.added) 		return true;
		if (ex1.information.distributorId 	!= ex2.information.distributorId) 		return true;
		if (ex1.information.mediaformatId 	!= ex2.information.mediaformatId) 		return true;
		
		for (item in ex1.originatorItems) {			
			if (! ExampleTools.hasOriginatorItem(ex2, item)) return true;
		}		
		for (item in ex2.originatorItems) {			
			if (! ExampleTools.hasOriginatorItem(ex1, item)) 	return true;
		}		

		for (item in ex1.categories) {			
			if (! ExampleTools.hasAlternative(ex2, item)) return true;
		}		
		for (item in ex2.categories) {			
			if (! ExampleTools.hasAlternative(ex1, item)) return true;
		}		

		for (item in ex1.categoriesDynamic) {			
			if (! ExampleTools.hasAlternativeDynamic(ex2, item)) return true;
		}		
		for (item in ex2.categoriesDynamic) {			
			if (! ExampleTools.hasAlternativeDynamic(ex1, item)) return true;
		}		
		
		return false;
	}
	
	static public function saveDifferencesFromFiledata(filename:String, example:TExample) {
		var ex1 = example;
		var ex2 = ScorxDb.getExample(filename);
		var msgChanged:Array<String> = [];
		var msgAdded:Array<String> = [];
		var msgRemoved:Array<String> = [];
		
		if (ex1.information.id != ex2.information.id) {			
			var fileId = ScorxTools.getId(filename);
			if (ex1.information.id != fileId) throw "File ID and example ID does not correspond";
			ScorxDb.setInformationField(filename, 'id', Std.string(ex1.information.id));
			msgChanged.push('id: ' + ex1.information.id);
		}		
		
		if (ex1.information.title != ex2.information.title) {
			ScorxDb.setInformationField(filename, 'title', ex1.information.title);
			msgChanged.push('title: ' + ex1.information.title);
		}
		
		if (ex1.information.subtitle != ex2.information.subtitle) {
			ScorxDb.setInformationField(filename, 'subtitle', ex1.information.subtitle);
			msgChanged.push('subtitle: ' + ex1.information.subtitle);
		}			
		
		if (ex1.information.sorttitle != ex2.information.sorttitle) {
			ScorxDb.setInformationField(filename, 'sorttitle', ex1.information.sorttitle);
			msgChanged.push('sorttitle: ' + ex1.information.sorttitle);
		}		
		
		for (item in ex1.originatorItems) {			
			if (! ExampleTools.hasOriginatorItem(ex2, item)) {
				ScorxDb.insertOriginatorItem(filename, item);
				var short = ExampleTools.getOrigItemShort(item);
				msgAdded.push('orignatoritem: ' + short);
			}
		}

		for (item in ex2.originatorItems) {			
			if (! ExampleTools.hasOriginatorItem(ex1, item)) {
				ScorxDb.removeOriginatorItem(filename, item);
				var short = ExampleTools.getOrigItemShort(item);
				msgRemoved.push('orignatoritem: ' + short);								
			}
		}
		
		for (item in ex1.categories) {			
			if (! ExampleTools.hasAlternative(ex2, item)) {
				ScorxDb.insertCategory(filename, item);
				var short = ExampleTools.getAlternativeShort(item);
				msgAdded.push('alternative: ' + short);
			}
		}

		for (item in ex2.categories) {			
			if (! ExampleTools.hasAlternative(ex1, item)) {
				ScorxDb.removeCategory(filename, item);
				var short = ExampleTools.getAlternativeShort(item);
				msgRemoved.push('alternative: ' + short);								
			}
		}		
		
		
		for (item in ex1.categoriesDynamic) {			
			if (! ExampleTools.hasAlternativeDynamic(ex2, item)) {
				ScorxDb.insertCategoryDyn(filename, item);
				var short = ExampleTools.getAlternativeShort(item);
				msgAdded.push('alternativeDynamic: ' + short);
			}
		}

		for (item in ex2.categoriesDynamic) {			
			if (! ExampleTools.hasAlternativeDynamic(ex1, item)) {
				ScorxDb.removeCategoryDyn(filename, item);
				var short = ExampleTools.getAlternativeShort(item);
				msgRemoved.push('alternativeDynamic: ' + short);								
			}
		}		
		
		
		var result = { changed:msgChanged.join('\n'), added:msgAdded.join('\n'), removed:msgRemoved.join('\n') };
		trace(result);
		
		return result;
	}	
	
	
	/*
	static public function getAlternativesStatic(example:TExample) {
		var result:TAlternatives = [];
		var altAll = example.categories;
		
		for (alt in altAll) {			
			result.push(alt);
		}
		
		return result;
	}
	
	static public function getAlternativesDynamic(example:TExample) {
		var result:TAlternatives = [];
		var alts = example.categoriesDynamic;
		
		for (alt in alts) {
			result.push(alt);
		}
		
		return result;
	}
	*/


	
	
	
	static public function removeAlternative(example:TExample, alternative:TAlternative) {
		var removeAlternativeShort = getAlternativeShort(alternative);
		for (i in 0...example.categories.length) {
			var alternativeShort = getAlternativeShort(example.categories[i]);
			//trace([typeOrigShort, removeTypeOrigShort]);
			
			if (alternativeShort.toLowerCase() == removeAlternativeShort.toLowerCase()) {
				example.categories.splice(i, 1);				
				trace(example.categories);
				return example;				
			}
		}
		return example;		
	}
	
	/*
	static public function getAlternativeFromShort(alternativeShort:String): TAlternative {
		var result:TAlternative = {categoryId:null, value:null};
		var segments = alternativeShort.split(SEPARATOR_CATITEM);
		result.categoryId = segments[0];
		result.value = segments[1];
		return result;
	}
	*/
	
	static public function hasAlternative(example:TExample, alternative:TAlternative) :Bool {
		var altShort = getAlternativeShort(alternative);
		var altShorts = getAlternativeStaticShorts(example);
		return Lambda.has(altShorts, altShort);
	}
	
	static public function addAlternative(example:TExample, alternative:TAlternative) {
		if (hasAlternative(example, alternative)) {
			var short = getAlternativeShort(alternative);
			throw "Kan ej lägga till  " + short + ", existerar redan i exemplet!";
		}		
		example.categories.push(alternative);
		return example;		
	}

	
	static public function checkAlternativeIntegrity(example:TExample) {				
		var a:Array<String> = [];		
		for (item in example.categories) {
			var category = item.categoryId;
			var value = item.value;
			a.push(category);
		}
		//-----------------------------
		var msgA:Array<String> = [];
		
		var count = cx.ArrayTools.countItem(a, 'bes');
		if (count != 1) msgA.push('Kategori "bes" bör ha ett värde (inte fler)');

		var count = cx.ArrayTools.countItem(a, 'ack');	
		if (count != 1) msgA.push('Kategori "ack" bör ha ett värde (inte fler)');		
		
		var count = cx.ArrayTools.countItem(a, 'brk');
		if (count > 2) msgA.push('Kategori "brk" kan inte ha fler än två värden');		
		
		var count = cx.ArrayTools.countItem(a, 'brk');
		if (count > 2) msgA.push('Kategori "brk" kan inte ha fler än två värden');		
		
		var count = cx.ArrayTools.countItem(a, 'not');
		if (count > 1) msgA.push('Kategori "not" kan inte ha fler än ett värde');		
		
		var count = cx.ArrayTools.countItem(a, 'prd');
		if (count > 1) msgA.push('Kategori "prd" kan inte ha fler än två värden');		
		
		var count = cx.ArrayTools.countItem(a, 'brk');
		if (count > 2) msgA.push('Kategori "brk" kan inte ha fler än två värden');		
	
		if (msgA.length > 0) {
			var msg = msgA.join('\n');
			throw 'Example Alternative Integrity Error: \n' + msg;
		}
		
	}
	
	static public function checkAlternativeDynamicIntegrity(example:TExample) {				
		var a:Array<String> = [];		
		for (item in example.categoriesDynamic) {
			var category = item.categoryId;
			var value = item.value;
			a.push(category);
		}
		//-----------------------------
		var msgA:Array<String> = [];
		
		var count = cx.ArrayTools.countItem(a, 'pbnr');
		if (count > 1) msgA.push('Kategori "pbnr" kan inte ha fler än ett värde');		
		
		if (msgA.length > 0) {
			var msg = msgA.join('\n');
			throw 'Example Alternative Integrity Error: \n' + msg;
		}	
	}
	
	
	
	static public function checkOriginatorIntegrity(example:TExample) {
		if (example.originatorItems.length < 1) {
			var msg = 'Exemplet har ingen upphovsman!';
			throw 'Example Alternative Integrity Error: \n' + msg;
		}		
	}	
	
	static public function checkInformationIntegrity(example:TExample) {
		if (example.information.title == '') {
			var msg = 'Exemplet har ingen titel!';
			throw 'Example Alternative Integrity Error: \n' + msg;
		}		
		
		if (example.information.sorttitle != '') {
			if (example.information.sorttitle.toLowerCase().indexOf(example.information.title.toLowerCase()) < 0) {
				var msg = 'Fältet "sorttitle" bör innehålla exemplets titlel!';
				throw 'Example Alternative Integrity Error: \n' + msg;
			}
		}
		
	}
	
	static public function hasAlternativeDynamic(example:TExample, alternative:TAlternative) :Bool {
		var altShort = getAlternativeShort(alternative);
		var altShorts = getAlternativeDynamicShorts(example);
		return Lambda.has(altShorts, altShort);
	}
	
	static public function addAlternativeDynamic(example:TExample, alternative:TAlternative) {
		if (hasAlternativeDynamic(example, alternative)) {
			var short = getAlternativeShort(alternative);
			throw "Kan ej lägga till dynamiskt alternativ " + short + ", existerar redan i exemplet!";
		}		
		example.categoriesDynamic.push(alternative);
		return example;				
	}
	
	static public function getAlternativeFromShort(short:String):TAlternative {
		var segments = short.split(SEPARATOR_CATITEM);
		var result:TAlternative = { categoryId:segments[0].trim(), value:segments[1].trim() };
		
		return result;
	}
	
	static public function removeAlternativeDynamic(example:TExample, alternative:TAlternative) {
		var removeAlternativeShort = getAlternativeShort(alternative);
		for (i in 0...example.categoriesDynamic.length) {
			var alternativeShort = getAlternativeShort(example.categoriesDynamic[i]);
			if (alternativeShort.toLowerCase() == removeAlternativeShort.toLowerCase()) {
				example.categoriesDynamic.splice(i, 1);				
				return example;				
			}
		}
		return example;			
	}
	
	
}