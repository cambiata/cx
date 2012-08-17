package nx.layout;
import nx.core.display.DSystem;

/**
 * ...
 * @author Jonas Nyström
 */

interface ILayoutProcessor 
{	
	function doLayout(systemWidth:Float = 800.0, firstBarNr:Int=0):Array<DSystem>;	
}