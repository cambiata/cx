package nx3.enums.tools;
import nx3.enums.ENoteType;
import jasononeil.CleverSort;
/**
 * ...
 * @author 
 */
using  jasononeil.CleverSort;
class ENoteTypeTools
{

	static public function noteSortHeads(type:ENoteType)
	{
		switch(type) 
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				heads.cleverSort(_.level);
				//for (head in heads) trace(head.level);
			default:
				throw 'Can not sort heads on other type than ENoteType.Note - this one is a $type';
		}		
	}
	
}