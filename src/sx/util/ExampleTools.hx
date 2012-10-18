package sx.util;
import sx.type.TExample;
import sx.type.TListExample;
import sx.type.TOriginatorshorts;
import sx.type.TSupplyState;

/**
 * ...
 * @author Jonas Nyström
 */

class ExampleTools 
{

	static public function getListExample(example:TExample):TListExample {
		var listExample:TListExample = {
			id:example.information.id,
			title:example.information.title,
			subtitle:example.information.subtitle,
			sorttitle:example.information.sorttitle,
			bes:getBesFromExample(example),
			ack:getAckFromExample(example),
			originatorshorts:getOriginatorshortsFromExample(example),
			introd:example.information.introd,
			originatorItems:example.originatorItems,
			categories:example.categories,				
			
			subdir:example.subdir,
			
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
	
	static public function getOriginatorshortsFromExample(example:TExample, includeType:Bool=false):TOriginatorshorts {
		var originatorshorts = new TOriginatorshorts();
		for (origItem in example.originatorItems) {
			
			var originatorshort = ScorxTools.getOriginatorshort(origItem.originator);
			if (includeType) originatorshort = origItem.type + ' > ' + originatorshort;
			
			originatorshorts.push(originatorshort);
		}
		return originatorshorts;
	}
	
	static public function getCategoriesShortsFromExample(example:TExample, includeType:Bool=false):Array<String> {
		var result:Array<String> = [];		
		for (cat in example.categories) {
			var short = cat.value;
			if (includeType) short = cat.categoryId + ' > ' + short;
			result.push(short);
		}
		return result;
	}	
	
	
	
}