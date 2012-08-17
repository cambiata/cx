package nx.layout;
import nx.display.DBars;
import nx.display.DSystem;

/**
 * ...
 * @author Jonas Nyström
 */

interface ILayoutProcessor 
{	
	function doLayout(dbars:DBars, firstBarNr:Int=0):Array<DSystem>;	
}