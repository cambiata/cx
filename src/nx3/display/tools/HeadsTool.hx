package nx3.display.tools;
import nx3.elements.Head;
import nx3.enums.EDirectionUD;
import nx3.units.Level;

/**
 * ...
 * @author 
 */
class HeadsTool
{
	static public function topLevel(heads:Array < Head>):Level return heads[0].level;
	static public function bottomLevel(heads:Array<Head>):Level return heads[heads.length - 1].level;
	static public function midLevel(heads:Array<Head>):Float
	{
		var bottom:Int = HeadsTool.bottomLevel(heads);
		var top:Int =  HeadsTool.topLevel(heads);
		return top + ((bottom - top) / 2);	
	}
	
	static public function getDirection(heads:Array<Head>):EDirectionUD return (HeadsTool.midLevel(heads) > 0) ? EDirectionUD.Up : EDirectionUD.Down;
	
	static public  function getHeadPositions(heads:Array<Head>, direction:EDirectionUD):Array<Int>
	{
		if (heads.length < 2) return [0];
		var len:Int = heads.length;
		var result:Array<Int> = [];
		
		// reset
		for (i in 0...len) {result.push(0); }
		
		// calc
		if (direction == EDirectionUD.Down) 
		{
			for (i in 0...len - 1) 
			{		
				var head:Head = heads[i];
				var headNext:Head =heads[i + 1];
				var lDiff = headNext.level - head.level;
				if (lDiff < 2) {
					if (result[i] == result[i + 1]) {
						result[i + 1] = -1;
					}
				}
			}
		} 
		else 
		// EDirectionUD.Up
		{
			for (j in 0...len - 1) 
			{
				var i = len - j - 1;				
				var head:Head = heads[i];
				var headNext:Head =heads[i - 1];
				var lDiff = head.level - headNext.level;				
				if (lDiff < 2) {
					if (result[i] == result[i - 1]) {
						result[i - 1] = 1;
					}
				}								
			}
		}
		//trace('HeadPositions:');
		//trace(result);
		
		return result;
	}
	
	public static function headsCollide(heads1:Array<Head>, heads2:Array<Head>):Bool
	{
		for (head1 in heads1)
		{
			for (head2 in heads2)
			{
				if (head1.level == head2.level - 1) return true;
				if (head1.level == head2.level) return true;
				if (head1.level == head2.level + 1) return true;
			}
		}
		return false;
	}
	
	
}