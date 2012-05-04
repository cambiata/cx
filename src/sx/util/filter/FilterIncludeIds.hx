package sx.util.filter;

/**
 * ...
 * @author Jonas Nyström
 */

class FilterIncludeIds implements IIdFilter
{

	var ids:Array<Int>;
	public function new(ids:Array<Int>) 
	{
		this.ids = ids;
	}
	
	public function filter(id:Int) :Bool {
		return = (Lambda.has(this.ids, id));
	}
	
}