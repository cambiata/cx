package nx3.elements.tools;
import nx3.elements.ENoteType;
import nx3.elements.NHead;
import nx3.elements.VTree;

/**
 * ...
 * @author 
 */

class ENoteTypeToolsx
{

	static public function noteSortHeads(type:ENoteType)
	{
		switch(type) 
		{
			case ENoteType.Note(heads, variant, articulations, attributes):
				//heads  = CleverSort.cleverSort(heads, _.level);
				
				
				//var hds:Array<NHead> = heads;
				trace(heads);
				heads.sort(function(a:NHead, b:NHead) { return Reflect.compare(a.level, b.level); } );
				
				
				
				//heads.cleverSort(_.level);
				//for (head in heads) trace(head.level);
			default:
				throw 'Can not sort heads on other type than ENoteType.Note - this one is a $type';
		}		
	}
	
}