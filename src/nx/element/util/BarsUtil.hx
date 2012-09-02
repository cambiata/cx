package nx.element.util;
import nx.element.Bars;
import nx.enums.EPartType;

/**
 * ...
 * @author Jonas Nyström
 */

class BarsUtil 
{
	static public function addPart(bars:Bars, partIdx:Int = -1, type:EPartType=null) {
		for (bar in bars.bars) {
			BarUtil.addPart(bar, partIdx, type);
		}
	}
	
}